//
//  TRMapListingController.swift
//  TRWMSLayer
//
//  Created by Zuhair Hussain on 17/02/2020.
//  Copyright © 2020 Waqas Rasheed. All rights reserved.
//

import UIKit

class TRServerListingController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var adapter: TRServerListingAdapter!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adapter = TRServerListingAdapter(collectionView)
        navigationController?.isNavigationBarHidden = true
    }
    
    

    public init() {
        let bundle = Bundle(for: type(of: self))
        super.init(nibName: "TRServerListingController", bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        if let navigationController = self.navigationController, navigationController.viewControllers.count > 1 {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
        
    }
    

}