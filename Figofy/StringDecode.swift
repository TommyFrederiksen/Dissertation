//
//  StringDecode.swift
//  Figofy
//
//  Created by Janus Ringling on 09/05/2016.
//  Copyright © 2016 Tommy. All rights reserved.
//

import Foundation

func decodeBase64StringToImage(strEncodedData: String?) -> UIImage {
    if let data = strEncodedData{
        let image = NSData(base64EncodedString: data, options: .IgnoreUnknownCharacters)
        return UIImage(data: image!)!
    }
    else
    {
        return UIImage(named: "Figofy_app_trans")!
    }
    
}