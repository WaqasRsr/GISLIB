//
//  QaisTopBar.swift
//  QaisApp
//
//  Created by Muhammad Arslan Khalid on 03/11/2018.
//  Copyright © 2018 Target. All rights reserved.
//

import UIKit

class QaisTopBar: UIView {

    
    @IBOutlet weak var btnBack:UIButton!
    @IBOutlet weak var lblNavHeading:UILabel!
    @IBOutlet weak var btnRight: UIButton!
    
    
    var navHeding:String!
    {
        didSet{
            self.lblNavHeading.text = navHeding
        }
    }
    
    
    var view: UIView!
    
    
    
    
    
    override init(frame: CGRect) {
        // 1. setup any properties here
        
        
        // 2. call super.init(frame:)
        super.init(frame: frame)
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        
        
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        
        
        
        // 3. Setup view from .xib file
        xibSetup()
        
    }
    
    
    private func xibSetup() {
        view = loadViewFromNib()
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
        
        self.view.backgroundColor = AppCustomColor.PrimaryColor
    }
    
    func setBackgroundColor(color:UIColor = AppCustomColor.PrimaryColor)
    {
        self.view.backgroundColor = color
    }
    
   private func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "QaisTopBar", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    
    func addLeftBtnTarget(_ target: Any?, action: Selector)
    {
        self.btnBack.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
    }
    
    func setBackImage(_ backImgStr:String)
    {
        self.btnBack.setImage(UIImage(named: backImgStr), for: UIControl.State.normal)
    }
    
    func setRightImage(_ backImgStr:String)
    {
        self.btnRight.setImage(UIImage(named: backImgStr), for: UIControl.State.normal)
    }
    
    func setData(title:String,_ target: Any?, action: Selector)
    {
        self.lblNavHeading.text = title
        self.btnBack.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
    }

}
