//
//  SideMenuOptionCell.swift
//  SideMenu
//
//  Created by Zuhair Hussain on 13/02/2020.
//  Copyright © 2020 Zuhair Hussain. All rights reserved.
//

import UIKit

class SideMenuOptionCell: UITableViewCell {

    
    @IBOutlet weak var imgIconCheckMark: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
