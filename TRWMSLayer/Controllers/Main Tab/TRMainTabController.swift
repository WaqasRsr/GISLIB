//
//  TRMainTabController.swift
//  TRWMSLayer
//
//  Created by Zuhair Hussain on 17/02/2020.
//  Copyright © 2020 Waqas Rasheed. All rights reserved.
//

import UIKit
import MBProgressHUD
import OAuthSwift

public class TRMainTabController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var btnMaps: UIButton!
    @IBOutlet weak var btnDataSets: UIButton!
    @IBOutlet weak var btnServers: UIButton!
    
    @IBOutlet weak var collectionViewMaps: UICollectionView!
    @IBOutlet weak var collectionViewDataSets: UICollectionView!
    @IBOutlet weak var collectionViewServers: UICollectionView!
    
    var adapterMaps: TRMapListingAdapter!
    var adapterDataSets: TRDataSetAdapter!
    var adapterServers: TRServerListingAdapter!
    
    var baseURL = GISTRWMSLayer.gisBaseURL! //"https://map.demo-aws.meeraspace.com"
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        assert(GISTRWMSLayer.domain.count != 0,"not called the GISTRWMSLayer.configure")
        
        adapterMaps = TRMapListingAdapter(collectionViewMaps)
        adapterDataSets = TRDataSetAdapter(collectionViewDataSets)
        adapterServers = TRServerListingAdapter(collectionViewServers)
       
    }
    
    public init() {
        
        let bundle = Bundle(for: type(of: self))
        super.init(nibName: "TRMainTabController", bundle: bundle)
        
        self.baseURL = GISTRWMSLayer.gisBaseURL
        Network.oauthswift = GISTRWMSLayer.oauthswift
        
        self.loginInApp()
    }
    
    /*public init(baseURL:String,oauthswift: OAuth2Swift) {
        
        let bundle = Bundle(for: type(of: self))
        super.init(nibName: "TRMainTabController", bundle: bundle)
        
        self.baseURL = baseURL
        Network.oauthswift = oauthswift
    }*/
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Actions
extension TRMainTabController {
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        if let navigationController = self.navigationController, navigationController.viewControllers.count > 1 {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func didTapMapsButton(_ sender: UIButton) {
        btnMaps.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        btnDataSets.setTitleColor(UIColor(red: 170 / 255, green: 170 / 255, blue: 170 / 255, alpha: 1), for: .normal)
        btnServers.setTitleColor(UIColor(red: 170 / 255, green: 170 / 255, blue: 170 / 255, alpha: 1), for: .normal)
        
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        
    }
    @IBAction func didTapDataSetsButton(_ sender: UIButton) {
        
        btnMaps.setTitleColor(UIColor(red: 170 / 255, green: 170 / 255, blue: 170 / 255, alpha: 1), for: .normal)
        btnDataSets.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        btnServers.setTitleColor(UIColor(red: 170 / 255, green: 170 / 255, blue: 170 / 255, alpha: 1), for: .normal)
        
        scrollView.setContentOffset(CGPoint(x: scrollView.frame.width, y: 0), animated: true)
    }
    @IBAction func didTapServersButton(_ sender: UIButton) {
        
        btnMaps.setTitleColor(UIColor(red: 170 / 255, green: 170 / 255, blue: 170 / 255, alpha: 1), for: .normal)
        btnDataSets.setTitleColor(UIColor(red: 170 / 255, green: 170 / 255, blue: 170 / 255, alpha: 1), for: .normal)
        btnServers.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        
        scrollView.setContentOffset(CGPoint(x: scrollView.frame.width * 2, y: 0), animated: true)
    }
    
}

// MARK: - Tap Handlers
extension TRMainTabController {
    
    func getMapsList() {
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        HelperTRWMSLayer.shared.getMapsList(baseURL: self.baseURL, pathURL: "/service/map/active", completion: { (result, error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            
            guard let result = result else {
                Alert.showServerErrors(controller: self, errorModel: error!)
                return
            }
            print(result.count)
            self.adapterMaps.data = result
            
        }) { (isSuccess) in
            
        }
    }

    func  getMapServers() {
        HelperTRWMSLayer.shared.getServersData(baseURL: self.baseURL, pathURL: "/service/entity/MapServer", completion: { (result, error) in
            guard let result = result else {
                Alert.showServerErrors(controller: self, errorModel: error!)
                return
            }
            self.adapterServers.data = result
            
        }) { (isSucces) in
            
        }
    }

    func getDataSets() {
        HelperTRWMSLayer.shared.getDataSets(baseURL: self.baseURL, pathURL: "/service/entity/MapLayer", completion: { (result, error) in
            guard let result = result else {
                Alert.showServerErrors(controller: self, errorModel: error!)
                return
            }
            self.adapterDataSets.data = result
            
        }) { (isSucces) in
            
        }
    }

    
    
}

//MARK:- Login Method
extension TRMainTabController {
    
    //private func loginInApp(userName:String = "usman.aleem@targetofs.com", password:String = "Helpdesk@111")
    //private func loginInApp(userName:String = "targetmohsin@gmail.com", password:String = "password")
    
    private func loginInApp(userName:String = "targetmohsin@gmail.com", password:String = "password")
    {
        
        guard  Network.oauthswift != nil else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        CommonNetworkApis.loginInAppToGetAccessToken(ouathInfo: Network.oauthswift, userName: userName, password: password) { (accessToken, refreshAccessToken, error) in
            
            MBProgressHUD.hide(for: self.view, animated: true)
            
            guard error == nil else {
                Alert.showServerErrors(controller: self, errorModel: error!)
                return
            }
            
            self.getMapsList()
            self.getDataSets()
            self.getMapServers()
        }
    }
}
