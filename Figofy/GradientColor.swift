//
//  GradientColor.swift
//  Figofy
//
//  Created by Mohammed Joseph Petrelli Salameh on 27/01/16.
//  Copyright © 2016 Tommy. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class GradientColor: UIView {
    
    @IBInspectable var topColor: UIColor = UIColor.blueColor()
    @IBInspectable var bottomColor: UIColor = UIColor.blackColor()
    @IBInspectable var opacity: CGFloat = 1
    @IBInspectable var topBottomFlip: Bool = false
    
    var colors = [CGColor]()
    
    override func drawRect(rect: CGRect) {
        
        let currentContext = UIGraphicsGetCurrentContext()
        
        if topBottomFlip == true {
            colors = [bottomColor.colorWithAlphaComponent(opacity).CGColor, topColor.colorWithAlphaComponent(opacity).CGColor]
        }else {
            colors = [topColor.colorWithAlphaComponent(opacity).CGColor, bottomColor.colorWithAlphaComponent(opacity).CGColor]
        }
        
        let locations: [CGFloat] = [0.0, 1.0]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let gradient = CGGradientCreateWithColors(colorSpace, colors, locations)
        
        let startPoint: CGPoint = CGPointMake(rect.width/1.5, 0)
        
        let endPoint: CGPoint = CGPointMake(rect.width/1.5, rect.height)
        
        CGContextDrawLinearGradient(currentContext, gradient, startPoint, endPoint, .DrawsBeforeStartLocation)
        
    }
    
    
    
}