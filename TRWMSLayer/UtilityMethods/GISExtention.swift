//
//  GISExtention.swift
//  TRWMSLayer
//
//  Created by Waqas Rasheed on 17/02/2020.
//  Copyright © 2020 Waqas Rasheed. All rights reserved.
//

import Foundation
import UIKit

extension UIColor
{
    
    static func colorWithRGB(_ red:CGFloat,_ green:CGFloat, _ blue:CGFloat, opacity:CGFloat) -> UIColor
    {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: opacity);
    }
    
    static func AppLightGreyColor() -> UIColor
    {
        return UIColor.colorWithRGB(231, 230, 231, opacity: 1.0)
    }
    
    static func AppDarkGreyColor() -> UIColor
    {
        return UIColor.colorWithRGB(139, 138, 139, opacity: 1.0)
    }
    
    static func AppTextLightGreyColor() -> UIColor
    {
        return UIColor.colorWithRGB(195, 194, 195, opacity: 1.0)
    }
    
    static var AppLightOrangeColor:UIColor {
        
        return UIColor.colorWithRGB(240, 160, 129, opacity: 1.0)
    }
    
    
    
    static var AppRedColor:UIColor {
        
        return UIColor.colorWithRGB(188, 16, 16, opacity: 1.0)
    }
    
    convenience init(hexString:String) {
        let hexString:NSString =
            hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) as NSString
        
        //hexString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let scanner            = Scanner(string: hexString as String)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return NSString(format:"#%06x", rgb) as String
    }
    
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    static var AppOrangeColor:UIColor {
        
        return UIColor(hexString: "FF5722")
    }
    
}
