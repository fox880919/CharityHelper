//
//  RegisterationJson.swift
//  CharityHelper
//
//  Created by Fayez Altamimi on 25/08/2017.
//  Copyright © 2017 Fayez Altamimi. All rights reserved.
//

import Foundation

class UserData : UserLogin {
    
    
    private var _name: String!
    
    private var _email: String!
    
    private var _phone: String!
    
    private var _id: Int!
    
    init(username : String!, password : String!, name : String!, mail : String!, phone : String!, id: Int!)  {
        
        super.init(username: username, password: password)
        
        self._name = name
        self._email = mail
        self._phone = phone
        self._id = id

    }
    
    
    var name: String {
        get {
            return self._name
        }
    }
    
    var email: String {
        get {
            return self._email
        }
    }
    
    var phone: String {
        get {
            return self._phone
        }
    }
    
    var id  : Int {
        get {
            return self._id
        }
    }

}
