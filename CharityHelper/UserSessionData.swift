//
//  User.swift
//  CharityHelper
//
//  Created by Fayez Altamimi on 21/08/2017.
//  Copyright © 2017 Fayez Altamimi. All rights reserved.
//

import Foundation

class UserSessionData: NSObject, NSCoding{
    
    private var _username: String!
    private var _id: Int!
    
    init(username: String?, id: Int? ){
        
        self._username = username ?? ""
        self._id = id ?? 0
    }
    
    var username: String {
        get {
            return self._username
        }
    }
    
    var id: Int {
        get {
            return self._id
        }
    }
    
    required init(coder decoder: NSCoder) {
        _username = decoder.decodeObject(forKey: "username") as? String ?? ""
        _id = decoder.decodeObject(forKey: "id") as? Int ?? 0
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(_username, forKey: "username")
        coder.encode(_id, forKey: "id")
    }
    
    
}
