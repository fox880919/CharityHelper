//
//  CoverOCR.swift
//  CharityHelper
//
//  Created by Fayez Altamimi on 29/08/2017.
//  Copyright © 2017 Fayez Altamimi. All rights reserved.
//

import Foundation

class CoverOCR{
    
    var _result : String!
    
    init(result: String!) {
        _result = result
    }
    
    var result: String {
        get{
            return _result
        }
    }
}
