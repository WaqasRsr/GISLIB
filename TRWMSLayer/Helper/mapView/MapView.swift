//
//  MapView.swift
//  TRWMSLayer
//
//  Created by Waqas Rasheed on 12/02/2020.
//  Copyright © 2020 Waqas Rasheed. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class MapView: UIView {
    
    @IBOutlet weak var TRMapView: GMSMapView!
    
    var contentView: UIView!
    
    //@IBOutlet weak var btnAdd: UIButton!
    
    //    var nibName: String {
    //        return String(describing: FloatingAddButton.self)
    //    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
//    
    func loadViewFromNib() {
        
        if isReg {
            let bundle = Bundle(for: type(of: self))
            contentView = bundle.loadNibNamed("MapView", owner: self, options: nil)?.first as? UIView
            //let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
            //contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView
            
            //contentView = Bundle.main.loadNibNamed("MapView", owner: self, options: nil)?.first as? UIView
            
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            contentView.frame = bounds
            addSubview(contentView)
            
            layoutIfNeeded()
        }
        
        
    }
    
    lazy var isReg: Bool = {
        
        GMSServices.provideAPIKey("AIzaSyC4E3bb-_zlksV2ZjdLWlh-fmLEbtoNFXI")
        return true
    }()
    
}
