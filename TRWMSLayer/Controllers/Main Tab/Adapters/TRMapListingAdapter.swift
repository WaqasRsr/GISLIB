//
//  TRMapListingAdapter.swift
//  TRWMSLayer
//
//  Created by Zuhair Hussain on 17/02/2020.
//  Copyright © 2020 Waqas Rasheed. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class TRMapListingAdapter: NSObject {
    
    weak var collectionView: UICollectionView!
    var bundle: Bundle!
    var parent: UIViewController? {
        return self.collectionView.viewContainingController()
    }
    
    var data: [TWMSLayerModel]  = [] {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    init(_ collectionView: UICollectionView) {
        super.init()
        
        self.collectionView = collectionView
        configure()
    }
    func configure() {
        bundle = Bundle(for: type(of: self))
        
        collectionView.register(UINib(nibName: "TRMapListingCell", bundle: bundle), forCellWithReuseIdentifier: "Cell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
}

extension TRMapListingAdapter: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = (UIScreen.main.bounds.width - 30) / 2
        return CGSize(width: w, height: w + 54)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TRMapListingCell
        cell.lblTitle.text = data[indexPath.row].name
        cell.lblDate.text = data[indexPath.row].createdDate?.dateValue(format: "yyyy-MM-dd'T'HH:mm:ss")?.stringValue(format: "dd MMM, yyyy", timeZone: .current)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let mapCtrl = TRMapViewController()
        parent?.navigationController?.pushViewController(mapCtrl, animated: true)
    }
}
