//
//  GISConstants.swift
//  TRWMSLayer
//
//  Created by Waqas Rasheed on 17/02/2020.
//  Copyright © 2020 Waqas Rasheed. All rights reserved.
//

import Foundation
import UIKit


class GISConstants: NSObject {
    
    
    static var navigationBarHeight: CGFloat {
        var topSafeArea = GISConstants.safeArea.top
        if topSafeArea < 20 {
            topSafeArea = 20
        }
        return topSafeArea + 44
    }
    
    static var safeArea: UIEdgeInsets {
        var padding: UIEdgeInsets = UIEdgeInsets.zero
        if #available(iOS 11.0, *) {
            //if let _ = (UIApplication.shared.delegate as? AppDelegate)?.window?.safeAreaInsets {
                padding = UIEdgeInsets(top: 44, left: 0, bottom: 34, right: 0)
            //}
        }
        return padding
    }
}

