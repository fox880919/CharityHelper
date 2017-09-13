//
//  UserRegisteration.swift
//  CharityHelper
//
//  Created by Fayez Altamimi on 21/08/2017.
//  Copyright © 2017 Fayez Altamimi. All rights reserved.
//

import Foundation

class UserRegisteration {
    
    
    fileprivate var _username: String!
    
    fileprivate var _password: String!
    
    fileprivate var _shopName: String!
    
    fileprivate var _email: String!
    
    fileprivate var _phoneNumber: String!

    
    init(username: String, password: String, shopName: String, email: String, phoneNumber: String){
        
        self._username = username
        self._password = password
        self._shopName = shopName
        self._email = email
        self._phoneNumber = phoneNumber
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
    
    var shopName: String {
        get {
            return self._shopName
        }
    }
    
    var email: String {
        get {
            return self._email
        }
    }
    
    var phoneNumber: String {
        get {
            return self._phoneNumber
        }
    }
    


}
