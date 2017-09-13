//
//  Base64Manager.swift
//  CharityHelper
//
//  Created by Fayez Altamimi on 28/08/2017.
//  Copyright © 2017 Fayez Altamimi. All rights reserved.
//

import Foundation

import UIKit

class Base64Manager{
    

    
    static func encodeImage (image : UIImage) -> String
    {        
        UIImageJPEGRepresentation(image, 0.5)

        let imageData = UIImageJPEGRepresentation(image, 0.5)
        

        
        let strBase64 = imageData?.base64EncodedString(options: .init(rawValue: 0))
        
        return strBase64!
    }
    
    static func decodeString (strBase64 : String) -> UIImage
    {
        let dataDecoded : Data = Data(base64Encoded: strBase64, options: .ignoreUnknownCharacters)!

        let decodedimage:UIImage = UIImage(data: dataDecoded)!

        return decodedimage
    }
}
