//
//  GradientView.swift
//  Xeena
//
//  Created by Zuhair Hussain on 20/06/2019.
//  Copyright © 2019 Target. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    
    var view: UIView!
    
    private var gradientStartColor = UIColor.clear
    private var gradientEndColor = UIColor.black
    
    @IBInspectable var startColor: UIColor {
        set {
            gradientStartColor = newValue
            setGradient()
        }
        get {
            return gradientStartColor
        }
    }
    
    @IBInspectable var endColor: UIColor {
        set {
            gradientEndColor = newValue
            setGradient()
        }
        get {
            return gradientEndColor
        }
    }
    
    
    func setGradient() {
        
        let gradient = CAGradientLayer()
        
        gradient.frame = view?.bounds ?? CGRect.zero
        gradient.colors = [gradientStartColor.cgColor, gradientEndColor.cgColor]
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 1, y: 1)
        
        
        view?.layer.sublayers = []
        view?.layer.insertSublayer(gradient, at: 0)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            
            let gradient = CAGradientLayer()
            
            gradient.frame = self.view?.bounds ?? CGRect.zero
            gradient.colors = [self.gradientStartColor.cgColor, self.gradientEndColor.cgColor]
            gradient.startPoint = CGPoint.zero
            
            gradient.endPoint = CGPoint(x: 1, y: 1)
            
            self.view?.layer.sublayers = []
            self.view?.layer.insertSublayer(gradient, at: 0)
        }
    }
    
    
    
    // MARK: - View Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    func xibSetup() {
        backgroundColor = .clear
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        addSubview(view)
        view.backgroundColor = UIColor.clear
        setGradient()
        
        
        
        
        view.layoutIfNeeded()
        
    }
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return nibView
    }
}
