//
//  HttpHelper.swift
//  CharityHelper
//
//  Created by Fayez Altamimi on 25/08/2017.
//  Copyright © 2017 Fayez Altamimi. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON

class HttpHelper : NSObject
{
    
    func requestImage(imageUrl : String!, success:@escaping (UIImage) -> Void, myFailure: @escaping (String) -> Void , failure:@escaping (Error) -> Void)
    {
        Alamofire.request(imageUrl).responseData { (response) in
            if response.error == nil {
                print(response.result)
                
                // Show the downloaded image:
                if let data = response.data {
                    
                    let image = UIImage(data: data)
                    
                    success(image!)
                }
                else
                {
                    myFailure("No image")
                }
            }
            else
            {
                let error : Error = response.result.error!

                failure(error)
            }

        }
    }
    
    func requestPOSTURL(_ strURL : String, params : [String : AnyObject]?, headers : [String : String]?, success:@escaping (JSON) -> Void, myFailure: @escaping (String) -> Void , failure:@escaping (Error) -> Void){
        
        Alamofire.request(strURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in

            if responseObject.result.isSuccess {
                
                print(responseObject.result.value!)
            
                if(responseObject.description.contains("Error:") || responseObject.description.contains("An error has occurred."))
                {
                    var errorMessage = responseObject.description.replacingOccurrences(of: "SUCCESS: Error:", with: "")
                    
                    errorMessage = errorMessage.replacingOccurrences(of: "SUCCESS:", with: "")
                    
                    myFailure(errorMessage)
                }
                    
                else{
                    
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
                    
                }
            }
            
            if responseObject.result.isFailure {
                
                let error : Error = responseObject.result.error!
                failure(error)            
            }
        }
    }
    
     func requestGETURL(_ strURL: String, success:@escaping (JSON) -> Void, myFailure: @escaping (String) -> Void , failure:@escaping (Error) -> Void) {
        Alamofire.request(strURL).responseJSON { (responseObject) -> Void in
            print(responseObject)
            if responseObject.result.isSuccess {
                
                if(responseObject.description.contains("Error:"))
                {
                    
                    myFailure(responseObject.description.replacingOccurrences(of: "SUCCESS: Error:", with: ""))
                }
                    
                else{
                    
                    let resJson = JSON(responseObject.result.value!)
                    success(resJson)
                }
            }
            if responseObject.result.isFailure {
                
                let error : Error = responseObject.result.error!
                
                failure(error)
            }
        }
    }
    
    
 
}



