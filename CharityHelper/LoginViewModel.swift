//
//  LoginViewModel.swift
//  CharityHelper
//
//  Created by Fayez Altamimi on 26/08/2017.
//  Copyright © 2017 Fayez Altamimi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LoginViewModel : BasicViewModel {
    
    
    let URLExtension = "api/Users/login"
    
    
    func login(userLogin : UserLogin, success:@escaping (UserData) -> Void, myFailure:@escaping (String) -> Void ,failure:@escaping (Error) -> Void)   {
        

        let parameters : [String : String] =  ["username": userLogin.username, "password": userLogin.password]
        
        let httpHelper = HttpHelper()
        
        httpHelper.requestPOSTURL(URL + URLExtension, params: parameters as [String : AnyObject], headers: nil, success: {
            (JSONResponse) -> Void in
            
            let userData = UserData(username: JSONResponse["Username"].stringValue, password: JSONResponse["Password"].stringValue, name: JSONResponse["Name"].stringValue, mail: JSONResponse["Email"].stringValue, phone: JSONResponse["PhoneNumber"].stringValue, id: JSONResponse["ID"].intValue )
            
            success(userData)
            
            
        }, myFailure: {
            (description) -> Void in
            
            myFailure(description)
            
            
        }) {
            (error) -> Void in
            
            failure(error)
                        
        }
        
    }
    
}
