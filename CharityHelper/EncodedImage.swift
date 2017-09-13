//
//  EncodedImage.swift
//  CharityHelper
//
//  Created by Fayez Altamimi on 29/08/2017.
//  Copyright © 2017 Fayez Altamimi. All rights reserved.
//

import Foundation

class EncodedImage{
    
    private var _encodedString: String!
    
    init(encodedIamge : String!){
    
        _encodedString = encodedIamge
    
    }
    
    
    var encodedString : String {
        
        get {
            return _encodedString
        }
    }
    
    
    
    
}
