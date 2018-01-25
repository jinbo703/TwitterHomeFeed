//
//  HomeDatasourceController.swift
//  TwitterLBTA
//
//  Created by John Nik on 4/30/17.
//  Copyright © 2017 johnik703. All rights reserved.
//

import LBTAComponents
import TRON
import SwiftyJSON



class HomeDatasourceController: DatasourceController {
    
    
    let errorMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "Apologies something went wrong. Please try again later..."
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(errorMessageLabel)
        errorMessageLabel.fillSuperview()  // LBTA method call
        
        setupNavigationBarItems()
        
        collectionView?.backgroundColor = UIColor(r: 223, g: 223, b: 223)
        
        
        Service.sharedInstance.fetchHomeFeed { (homeDatasource, err) in
            
            if let err = err {
                self.errorMessageLabel.isHidden = false
                
                if let apiError = err as? APIError<Service.JSONError> {
                    
                    if apiError.response?.statusCode != 200 {
                        self.errorMessageLabel.text = "Status Code was not 200"
                    }
                    
                }
                
                
                return
            }
            
            self.datasource = homeDatasource
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            guard let user = self.datasource?.item(indexPath) as? User else { return .zero }
            
            let estimagtedHeight = estimatedHeightForText(user.bioText)
            
            return CGSize(width: view.frame.width, height: estimagtedHeight + 80)

        } else if indexPath.section == 1 {
            
            guard let tweet = datasource?.item(indexPath) as? Tweet else {
                return .zero
            }
            
            let estimagtedHeight = estimatedHeightForText(tweet.message)
            
            return CGSize(width: view.frame.width, height: estimagtedHeight + 77)
            
        }
        
        
        
        return CGSize(width: view.frame.width, height: 200)
        
    }
    
    private func estimatedHeightForText(_ text: String) -> CGFloat {
    
        let approximateWidthOfBioTextView = view.frame.width - 12 - 50 - 4
        let size = CGSize(width: approximateWidthOfBioTextView, height: 1000)
        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 14.5)]
        
        let estimatedFrame = NSString(string: text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        return estimatedFrame.height
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if section == 1 {
            return .zero
        }
        
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        if section == 1 {
            return .zero
        }
        
        return CGSize(width: view.frame.width, height: 64)
    }
    
    
    
    
    
    
    
}













