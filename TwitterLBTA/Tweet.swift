//
//  Tweet.swift
//  TwitterLBTA
//
//  Created by John Nik on 5/1/17.
//  Copyright © 2017 johnik703. All rights reserved.
//

import Foundation
import SwiftyJSON
import TRON

struct Tweet: JSONDecodable {
    
    let user: User
    let message: String
    
    init(json: JSON) {
        
        let userJson = json["user"]
        self.user = User(json: userJson)
        
        self.message = json["message"].stringValue
        
        
    }
    
}
