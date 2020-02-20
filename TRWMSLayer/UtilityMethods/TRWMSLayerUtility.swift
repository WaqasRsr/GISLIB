//
//  TRWMSLayerUtility.swift
//  TRWMSLayer
//
//  Created by Muhammad Arslan Khalid on 14/02/2020.
//  Copyright © 2020 Waqas Rasheed. All rights reserved.
//

import UIKit

let AppUtility = TRWMSLayerUtility.sharedInstance

class TRWMSLayerUtility: NSObject {

    static let sharedInstance = TRWMSLayerUtility()
    
    func hasValidText(_ text:String?) -> Bool
    {
        if let data = text
        {
            if data == "nil"
            {
                return false
            }
            let str = data.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            if str.count>0
            {
                return true
            }
            else
            {
                return false
            }
        }
        else
        {
            return false
        }
        
    }
}

extension TRWMSLayerUtility {
    
    func setNavHeightForIPhoneX(navHightRef navRef: NSLayoutConstraint)
    {
        if(AppUtility.isIPhoneX() == true)
        {
            //navRef.constant = 88;
            navRef.constant = GISConstants.navigationBarHeight
        }
    }
    
    func isIPhoneX() -> Bool
    {
        var iphoneX = false
        if Device.IS_IPHONE_X_OR_XS || Device.IS_IPHONE_XR_OR_XS_MAX
        {
            iphoneX = true
        }
        
        return iphoneX;
    }
}

struct Alert
{

   private static func displayAlertActionSheet(withTitle title: String?, andMessage message: String!,_ delegate:UIViewController!) {
    
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil));
        DispatchQueue.main.async {
            delegate.present(alert, animated: true, completion: nil);
        }
    }
    
    static func showServerErrors(controller:UIViewController, errorModel:ErrorModel)
    {
        displayAlertActionSheet(withTitle: errorModel.errorTitle, andMessage: errorModel.errorDescp, controller)
    }
    
   static func showAlert(title:String?, descp:String?,controller:UIViewController)
    {
        displayAlertActionSheet(withTitle: title, andMessage: descp, controller)
    }
}

struct AppCustomColor {
    static let PrimaryColor  = UIColor(hexString: "6A2FB1")
    static let PrimaryDarkColor  = UIColor(hexString: "541DA3")
    static let CRPrimaryColor = UIColor(hexString: "00AA45")
}

struct Device {
    // iDevice detection code
    static let IS_IPAD             = UIDevice.current.userInterfaceIdiom == .pad
    static let IS_IPHONE           = UIDevice.current.userInterfaceIdiom == .phone
    static let IS_RETINA           = UIScreen.main.scale >= 2.0
    
    static let SCREEN_WIDTH        = Int(UIScreen.main.bounds.size.width)
    static let SCREEN_HEIGHT       = Int(UIScreen.main.bounds.size.height)
    static let SCREEN_MAX_LENGTH   = Int( max(SCREEN_WIDTH, SCREEN_HEIGHT) )
    static let SCREEN_MIN_LENGTH   = Int( min(SCREEN_WIDTH, SCREEN_HEIGHT) )
    
    static let IS_IPHONE_4_OR_LESS = IS_IPHONE && SCREEN_MAX_LENGTH  < 568
    static let IS_IPHONE_5         = IS_IPHONE && SCREEN_MAX_LENGTH == 568
    static let IS_IPHONE_GREATER_5        = IS_IPHONE && SCREEN_MAX_LENGTH > 568
    static let IS_IPHONE_6         = IS_IPHONE && SCREEN_MAX_LENGTH == 667
    static let IS_IPHONE_6P        = IS_IPHONE && SCREEN_MAX_LENGTH == 736
    static let IS_IPHONE_X         = IS_IPHONE && SCREEN_MAX_LENGTH == 812
    static let IS_IPHONE_X_OR_XS    = UIDevice.current.userInterfaceIdiom == .phone && SCREEN_MAX_LENGTH == 812
    static let IS_IPHONE_XR_OR_XS_MAX = UIDevice.current.userInterfaceIdiom == .phone && SCREEN_MAX_LENGTH == 896
}
