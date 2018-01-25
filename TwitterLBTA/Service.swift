//
//  Service.swift
//  TwitterLBTA
//
//  Created by John Nik on 5/2/17.
//  Copyright © 2017 johnik703. All rights reserved.
//

import Foundation
import TRON
import SwiftyJSON

struct Service {
    
    let tron = TRON(baseURL: "http://api.letsbuildthatapp.com")
    
    static let sharedInstance = Service()
    
    func fetchHomeFeed(completion: @escaping (HomeDatasource?, Error?) -> ()) {
        let request: APIRequest<HomeDatasource, JSONError> = tron.request("/twitter/home")
        
        request.perform(withSuccess: { (homeDataSource) in
            
            completion(homeDataSource, nil)
        }) { (err) in            
            completion(nil, err)
//            print("Failed to fetch json...", error)
        }

    }
    
    class JSONError: JSONDecodable {
        required init(json: JSON) throws {
            print("JSON ERROR")
        }
    }
    
}
