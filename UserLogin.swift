//
//  LoginJson.swift
//  CharityHelper
//
//  Created by Fayez Altamimi on 25/08/2017.
//  Copyright © 2017 Fayez Altamimi. All rights reserved.
//

import Foundation

import Alamofire

class UserLogin {
    
    private var _username: String!
    private var _password: String!

    
    init(username : String!, password : String!) {
        
        self._username = username
        self._password = password
    }
    
    
    var username: String {
        get {
            return self._username
        }
    }
    
    var password: String {
        get {
            return self._password
        }
    }
    
}
