//
//  SideMenuController.swift
//  SideMenu
//
//  Created by Zuhair Hussain on 13/02/2020.
//  Copyright © 2020 Zuhair Hussain. All rights reserved.
//

import UIKit

class SideMenuController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cstTableViewLeading: NSLayoutConstraint!
    
    var adapter: SideMenuAdapter!
    
    var didChange: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter = SideMenuAdapter(tableView, didChange: didChange)
        cstTableViewLeading.constant = (UIScreen.main.bounds.width * -0.7)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cstTableViewLeading.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
            self.view.layoutIfNeeded()
        }
    }
    
    
    init(valueDidChange didChange: @escaping () -> Void) {
        let bundle = Bundle(for: type(of: self))
        super.init(nibName: "SideMenuController", bundle: bundle)
        
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
        self.didChange = didChange
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    deinit {
        print("[SideMenuController] deinit")
    }
    
    
    @IBAction func didTapDoneButton(_ sender: UIButton) {
        
        cstTableViewLeading.constant = (UIScreen.main.bounds.width * -0.7)
        UIView.animate(withDuration: 0.3, animations: {
            self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            self.view.layoutIfNeeded()
        }) { (_) in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    
    

}
