//
//  TRMapListingCell.swift
//  TRWMSLayer
//
//  Created by Zuhair Hussain on 17/02/2020.
//  Copyright © 2020 Waqas Rasheed. All rights reserved.
//

import UIKit

class TRDataSetCell: UICollectionViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var viewGradient: GradientView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewContainer.layer.cornerRadius = 4
        viewContainer.layer.borderColor = UIColor(red: 229 / 255, green: 229 / 255, blue: 229 / 255, alpha: 1).cgColor
        viewContainer.layer.borderWidth = 1
        
        viewGradient.layer.cornerRadius = 4
    }

}
