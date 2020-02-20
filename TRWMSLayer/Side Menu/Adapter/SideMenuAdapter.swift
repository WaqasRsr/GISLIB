//
//  SideMenuAdapter.swift
//  SideMenu
//
//  Created by Zuhair Hussain on 13/02/2020.
//  Copyright © 2020 Zuhair Hussain. All rights reserved.
//

import UIKit

class SideMenuAdapter: NSObject {
    
    weak var tableView: UITableView!
    var didChange: (() -> Void)?

    var bundle = Bundle()
    
    // MARK - Initializers
    init(_ tableView: UITableView, didChange: (() -> Void)?) {
        super.init()
        
        self.tableView = tableView
        self.didChange = didChange
        configure()
    }
    
    func configure() {
        
        bundle = Bundle(for: type(of: self))
        
        
        tableView.register(UINib(nibName: "SideMenuOptionHeader", bundle: bundle), forHeaderFooterViewReuseIdentifier: "Header")
        tableView.register(UINib(nibName: "SideMenuOptionCell", bundle: bundle), forCellReuseIdentifier: "Cell")
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
}


// MARK - Actions
extension SideMenuAdapter {
    @objc func didTapHeaderButton(_ sender: UIButton) {
        
        
        if sender.tag >= (HelperTRWMSLayer.shared.trwslayerData?.layers?.count ?? 0) {
            let isExpended = HelperTRWMSLayer.shared.trwslayerData?.isBaseLayerExpended ?? false
            HelperTRWMSLayer.shared.trwslayerData.isBaseLayerExpended = !isExpended
        } else if sender.tag >= 0 {
            let isSelected = HelperTRWMSLayer.shared.trwslayerData?.layers?[sender.tag].isSelected ?? false
            HelperTRWMSLayer.shared.trwslayerData?.layers?[sender.tag].isSelected = !isSelected
            
            didChange?()
        }
        tableView.reloadSections([sender.tag], with: .fade)
        
    }
    @objc func didTapHeaderCheckMarkButton(_ sender: UIButton) {
        
        

        if sender.tag >= (HelperTRWMSLayer.shared.trwslayerData?.layers?.count ?? 0) {
            let isSelected = HelperTRWMSLayer.shared.trwslayerData?.baseLayers?.isAllSelected ?? false
            HelperTRWMSLayer.shared.trwslayerData.baseLayers?.isAllSelected = !isSelected
        } else if sender.tag >= 0 {
            let isSelected = HelperTRWMSLayer.shared.trwslayerData?.layers?[sender.tag].isSelected ?? false
            HelperTRWMSLayer.shared.trwslayerData?.layers?[sender.tag].isSelected = !isSelected
        }

        didChange?()
        
        
        tableView.reloadData()
    }
}


// MARK - TableView DataSource and Delegate
extension SideMenuAdapter: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        if (HelperTRWMSLayer.shared.trwslayerData?.baseLayers?.count ?? 0) == 0 {
            return (HelperTRWMSLayer.shared.trwslayerData?.layers?.count ?? 0)
        }
        return (HelperTRWMSLayer.shared.trwslayerData?.layers?.count ?? 0) + 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section >= (HelperTRWMSLayer.shared.trwslayerData?.layers?.count ?? 0) {
            let isExpended = HelperTRWMSLayer.shared.trwslayerData?.isBaseLayerExpended ?? false
            return isExpended ? (HelperTRWMSLayer.shared.trwslayerData.baseLayers?.count ?? 0) : 0
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header") as! SideMenuOptionHeader
        
        if section >= (HelperTRWMSLayer.shared.trwslayerData?.layers?.count ?? 0) {

            let isAllSelected = HelperTRWMSLayer.shared.trwslayerData.baseLayers?.isAllSelected ?? false
            view.lblTitle.text = "Base Maps"
            view.imgArrow.isHidden = false
            view.imgIconCheckMark.image = isAllSelected ? UIImage(named: "check", in: bundle, compatibleWith: nil) : UIImage(named: "uncheck", in: bundle, compatibleWith: nil)
            
        } else {
            
            let isAllSelected = HelperTRWMSLayer.shared.trwslayerData?.layers?[section].isSelected ?? false
            view.lblTitle.text = HelperTRWMSLayer.shared.trwslayerData?.layers?[section].label
            view.imgArrow.isHidden = true
            view.imgIconCheckMark.image = isAllSelected ? UIImage(named: "check", in: bundle, compatibleWith: nil) : UIImage(named: "uncheck", in: bundle, compatibleWith: nil)
        }
        
        view.btnHeader.addTarget(self, action: #selector(didTapHeaderButton(_:)), for: .touchUpInside)
        view.btnCheckMark.addTarget(self, action: #selector(didTapHeaderCheckMarkButton(_:)), for: .touchUpInside)
        view.btnHeader.tag = section
        view.btnCheckMark.tag = section
        
        return view
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SideMenuOptionCell
        cell.lblTitle.text = HelperTRWMSLayer.shared.trwslayerData.baseLayers?[indexPath.row].name
        
        let isAllSelected = HelperTRWMSLayer.shared.trwslayerData.baseLayers?.isAllSelected ?? false
        if isAllSelected {
            cell.imgIconCheckMark.image = UIImage(named: "check", in: bundle, compatibleWith: nil)
        } else {
            cell.imgIconCheckMark.image = HelperTRWMSLayer.shared.trwslayerData.baseLayers?[indexPath.row].isSelected == true ? UIImage(named: "check", in: bundle, compatibleWith: nil) : UIImage(named: "uncheck", in: bundle, compatibleWith: nil)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let isSelected = HelperTRWMSLayer.shared.trwslayerData.baseLayers?[indexPath.row].isSelected ?? false
        HelperTRWMSLayer.shared.trwslayerData.baseLayers?[indexPath.row].isSelected = !isSelected

        didChange?()
        
        tableView.reloadData()
    }
    
    
}



class HeaderModel {
    var title = ""
    var isSelected = false
    var isExpended = false
    var options = [OptionModel]()
    
    init() {}
    init(title: String, options: [String]) {
        self.title = title
        
        for o in options {
            self.options.append(OptionModel(title: o))
        }
    }
    
}


class OptionModel {
    var title = ""
    var isSelected = false
    
    init(title: String) {
        self.title = title
    }
}
