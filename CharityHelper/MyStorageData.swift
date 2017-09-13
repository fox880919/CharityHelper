//
//  MyStorageData.swift
//  CharityHelper
//
//  Created by Fayez Altamimi on 27/08/2017.
//  Copyright © 2017 Fayez Altamimi. All rights reserved.
//

import Foundation

class MyStorageData {
    
    static let defaults = UserDefaults.standard
    
    
    static func setStoredUser(userSessionData: UserSessionData)
    {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: userSessionData)
        
        defaults.set(encodedData, forKey: "User")
        
    }
    
    static func removeStoredUser()
    {
        defaults.removeObject(forKey: "User")

    }
    
    static func getStoredUser() -> UserSessionData?
    {
        if let encodedData = defaults.data(forKey: "User")
        {
            
            if let userSessionData = NSKeyedUnarchiver.unarchiveObject(with: encodedData) as? UserSessionData
            {
                return userSessionData

            }
        }
        
        return nil
    }
}
