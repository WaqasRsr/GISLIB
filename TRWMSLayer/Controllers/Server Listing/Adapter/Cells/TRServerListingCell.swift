//
//  TRMapListingCell.swift
//  TRWMSLayer
//
//  Created by Zuhair Hussain on 17/02/2020.
//  Copyright © 2020 Waqas Rasheed. All rights reserved.
//

import UIKit

class TRServerListingCell: UICollectionViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgCover: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgCover.layer.cornerRadius = 4
    }

}
