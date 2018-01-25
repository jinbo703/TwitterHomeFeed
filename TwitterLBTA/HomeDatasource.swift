//
//  HomeDatasource.swift
//  TwitterLBTA
//
//  Created by John Nik on 4/30/17.
//  Copyright © 2017 johnik703. All rights reserved.
//

import LBTAComponents
import TRON
import SwiftyJSON


extension Collection where Iterator.Element == JSON {
    func decode<T:JSONDecodable>() throws -> [T] {
        
        return try map({try T(json: $0)})
        
    }
}

class HomeDatasource: Datasource, JSONDecodable {
    
    
    let users: [User]
    let tweets: [Tweet]
    
    required init(json: JSON) throws {
        
        guard let userJsonArray = json["users"].array, let tweetJsonArray = json["tweets"].array else {
            throw NSError(domain: "com.letsbuildthatapp", code: 1, userInfo: [NSLocalizedDescriptionKey: "Parsing Json valid."])
        }
        
//        self.users = userJsonArray.map({User(json: $0)})
//        self.tweets = tweetJsonArray.map({Tweet(json: $0)})
        
        self.users = try userJsonArray.decode()
        self.tweets = try tweetJsonArray.decode()
        
//        [1, 2].decode()
        
    }
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [UserHeader.self]
    }
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return [UserFooter.self]
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [UserCell.self, TweetCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        
        if indexPath.section == 1 {
            return tweets[indexPath.item]
        }
        
        return users[indexPath.item]
    }
    
    override func numberOfSections() -> Int {
        return 2
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        
        if section == 1 {
            return tweets.count
        }
        
        return users.count
    }
    
}

