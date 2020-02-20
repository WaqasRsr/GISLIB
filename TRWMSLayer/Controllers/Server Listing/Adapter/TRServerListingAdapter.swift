//
//  TRMapListingAdapter.swift
//  TRWMSLayer
//
//  Created by Zuhair Hussain on 17/02/2020.
//  Copyright © 2020 Waqas Rasheed. All rights reserved.
//

import UIKit

class TRServerListingAdapter: NSObject {
    
    weak var collectionView: UICollectionView!
    var bundle = Bundle()
    
    var data: [GISServerModel]  = [] {
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
        
        collectionView.register(UINib(nibName: "TRDataSetCell", bundle: bundle), forCellWithReuseIdentifier: "Cell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
}

extension TRServerListingAdapter: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = (UIScreen.main.bounds.width - 40) / 3
        return CGSize(width: w, height: w + 44)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TRDataSetCell
        
        cell.lblTitle.text = data[indexPath.row].name
        
        
        if indexPath.row % 4 == 0 {
            
            cell.viewGradient.startColor = UIColor(red: 242 / 255, green: 176 / 255, blue: 173 / 255, alpha: 1)
            cell.viewGradient.endColor = UIColor(red: 241 / 255, green: 162 / 255, blue: 219 / 255, alpha: 1)
            
        } else if indexPath.row % 4 == 1 {
            
            cell.viewGradient.startColor = UIColor(red: 107 / 255, green: 169 / 255, blue: 192 / 255, alpha: 1)
            cell.viewGradient.endColor = UIColor(red: 191 / 255, green: 241 / 255, blue: 219 / 255, alpha: 1)
            
        } else if indexPath.row % 4 == 2 {
            
            cell.viewGradient.startColor = UIColor(red: 200 / 255, green: 231 / 255, blue: 249 / 255, alpha: 1)
            cell.viewGradient.endColor = UIColor(red: 171 / 255, green: 197 / 255, blue: 248 / 255, alpha: 1)
            
        } else  {
            
            cell.viewGradient.startColor = UIColor(red: 255 / 255, green: 170 / 255, blue: 120 / 255, alpha: 1)
            cell.viewGradient.endColor = UIColor(red: 204 / 255, green: 87 / 255, blue: 72 / 255, alpha: 1)
            
        }
        
        
        return cell
    }
}
