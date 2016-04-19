//
//  FigofyButton.swift
//  Figofy
//
//  Created by Mohammed Joseph Petrelli Salameh on 28/01/16.
//  Copyright © 2016 Tommy. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class FigofyButton: UIButton {
    
    //let figofyColor = UIColor(red: 51/255, green: 51/255, blue: 153/255, alpha: 1)
    
    @IBInspectable var buttonColor: UIColor = UIColor.whiteColor()
    @IBInspectable var txtColor: UIColor = UIColor.blueColor()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

    override func awakeFromNib() {
        layer.cornerRadius = frame.size.width / 2.0
        layer.backgroundColor = buttonColor.CGColor
        layer.borderWidth = 2
        layer.borderColor = UIColor(red: 255/255, green: 128/255, blue: 0/255, alpha: 1  ).CGColor
        setTitleColor(txtColor, forState: .Normal)
        clipsToBounds = true
    }
    
    
    
    
}