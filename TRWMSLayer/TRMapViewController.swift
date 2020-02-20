//
//  TRMapViewController.swift
//  TRWMSLayer
//
//  Created by Waqas Rasheed on 12/02/2020.
//  Copyright © 2020 Waqas Rasheed. All rights reserved.
//

import UIKit
import GoogleMaps
import OAuthSwift 
import MBProgressHUD

public class TRMapViewController: UIViewController {
    
    @IBOutlet weak var topBar:QaisTopBar!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    var isHidderTopBar: Bool = false;
    
    var url:URL!
    private var baseURL:String!
    var casheLayer = [TRTileLayer]()
    
    public init() {
        
        let bundle = Bundle(for: TRMapViewController.self)
        super.init(nibName: "TRMapViewController", bundle: bundle)
        
        self.baseURL = GISTRWMSLayer.gisBaseURL
        //Network.oauthswift = oauthswift
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 01) {
            self.getDataForLayers()
        }
    }
    
    public init(baseURL:String,oauthswift: OAuth2Swift) {
        
        let bundle = Bundle(for: TRMapViewController.self)
        super.init(nibName: "TRMapViewController", bundle: bundle)
        
        self.baseURL = baseURL
        Network.oauthswift = oauthswift
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 01) {
            self.setTopBarGUI()
            self.getDataForLayers()
            
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTopBarGUI()
    {
        if(isHidderTopBar == true)
        {
            navHeight.constant = 0;
            topBar.isHidden = true;
            return;
        }
        
        self.topBar.lblNavHeading.text = "Map"
        
        self.topBar.btnBack.addTarget(self, action: #selector(self.btnBackPressed(_:)), for: UIControl.Event.touchUpInside)
        
        AppUtility.setNavHeightForIPhoneX(navHightRef: self.navHeight)
        
    }
    
    @IBAction func btnBackPressed(_ sender: Any) {
        
        if presentingViewController == nil {
            self.navigationController?.popViewController(animated: true);
        }
        else {
            self.dismiss(animated: true, completion: nil);
        }
    }
    
    
    @IBOutlet weak var mpView: MapView!
    var layerMap: GMSMapView {
        return mpView.TRMapView
    }
    
    public override func loadView() {
        super.loadView()
        
    }
    override public func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        layerMap.camera = GMSCameraPosition(latitude: 23.5880, longitude: 58.3829, zoom: 12)
        //addTiles()
        
        //self.loginInApp()
        assert(self.baseURL != nil)
        
        self.setTopBarGUI()
    }
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func didTapMenuButton(_ sender: UIButton) {
        
        let controller = SideMenuController {
            
            print("Value Did Change")
            let mainSelectedLayer = HelperTRWMSLayer.shared.trwslayerData.selectedLayers()
            let baseSelectedLayer = HelperTRWMSLayer.shared.trwslayerData.selectedBaseLayers()
            
            self.layerMap.clear()
            
            var queryObj = [QueryString]()
            
            for n in mainSelectedLayer {
                
                let clayer = self.casheLayer.filter { (model) -> Bool in
                    return model.id == n.id
                }
                
                if clayer.count > 0 {
                    
                    self.drawCasheLayers(chLayers: clayer)
                }
                else {
                    let obj = QueryString(wmsServer: n.mapServer!.url!, wfsServer: n.mapServer!.featureServerURL, layerName: n.name!, id: n.id!, attribute: nil)
                    queryObj.append(obj)
                }
            }
            
            for n in baseSelectedLayer {
                
                let clayer = self.casheLayer.filter { (model) -> Bool in
                    return model.id == n.id
                }
                
                //let obj = QueryString(wmsServer: n.mapServer!.url!, wfsServer: n.mapServer!.featureServerURL!, layerName: n.name!, id: n.id!, attribute: nil)
                //queryObj.append(obj)
            }
            
            if queryObj.count > 0 {
                self.drawAllLayers(queryObjecst: queryObj)
            }
            
        }
        
        self.present(controller, animated: true, completion: nil)
    }
}
extension TRMapViewController {
    
    func drawAllLayers(queryObjecst: [QueryString]) {
        
        let ESPG = "3857"
        
        for n in 0..<queryObjecst.count {
            
            let qs = queryObjecst[n]
            
            let wsmPath = "\(qs.wmsServer)SERVICE=WMS&VERSION=1.30&REQUEST=GetMap&layers=\(qs.layerName)&width=256&height=256&srs=EPSG:\(ESPG)&format=image/png8&transparent=true&id=\(qs.ID)&LayerName=\(qs.layerName)&Attribute=\(qs.attribute ?? "")"
            
            drawLayerOnMapWithPath(path: wsmPath,layerID: qs.ID)
            
            let wfsPath = "\(qs.wmsServer)SERVICE=WMS&VERSION=1.30&REQUEST=GetMap&layers=\(qs.layerName)&width=256&height=256&srs=EPSG:\(ESPG)&format=image/png8&transparent=true&id=\(qs.ID)&LayerName=\(qs.layerName)&Attribute=\(qs.attribute ?? "")"
            
            drawLayerOnMapWithPath(path: wfsPath,layerID: qs.ID)
        }
        
    }
    
    func drawLayerOnMapWithPath(path: String, layerID: Int) {
        
        let urls = { (x: UInt, y: UInt, zoom: UInt) -> URL in
            
            let bbox = self.bboxFromXYZ(x: x, y: y, z: zoom)
            let BOX = "\(bbox.left),\(bbox.bottom),\(bbox.right),\(bbox.top)"
            
            let newPath = path + "&BBOX=\(BOX)"
            
            return URL(string: newPath)!
        }
        
        // Create the GMSTileLayer
        let layer = GMSURLTileLayer(urlConstructor: urls)
        
        let cusLayer = TRTileLayer()
        cusLayer.id = layerID
        cusLayer.isSelected = true
        cusLayer.layer = layer
        
        layer.map = self.layerMap
        
        if !casheLayer.contains(cusLayer) {
            casheLayer.append(cusLayer)
        }
    }
    
    func drawCasheLayers(chLayers: [TRTileLayer]) {
        
        if chLayers.count > 0 {
            
            chLayers[0].layer.map = self.layerMap
        }
        
        
        /*for layer_ in chLayers {
         
         layer_.map = self.layerMap
         }*/
    }
}
extension TRMapViewController {
    func addTiles() {
        // Implement GMSTileURLConstructor
        let urls = { (x: UInt, y: UInt, zoom: UInt) -> URL in
            let bbox = self.bboxFromXYZ(x: x, y: y, z: zoom)
            let path = "https://demoreach.digitalenergycloud.com/geoserver/wfs?service=WMS&version=1.1.1&request=GetMap&layers=filespace:OmanRoadWGS&bbox=\(bbox.left),\(bbox.bottom),\(bbox.right),\(bbox.top)&width=256&height=256&srs=EPSG:900913&format=image/png&transparent=true"
            return URL(string: path)!
        }
        // Create the GMSTileLayer
        let layer = GMSURLTileLayer(urlConstructor: urls)
        //layer.tileSize = 256 // its standard.
        layer.map = self.layerMap
    }
    
    
    //"https://demoreach.digitalenergycloud.com/geoserver/wfs?service=WMS&version=1.1.1&request=GetMap&layers=filespace:OmanRoadWGS&bbox=%f,%f,%f,%f&width=256&height=256&srs=EPSG:900913&format=image/png&transparent=true"
}

//MARK:- utility Methods
extension TRMapViewController {
    
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
            
            self.getDataForLayers()
            
        }
    }
    
    
    private func getDataForLayers()
    {
        guard  AppUtility.hasValidText(Network.accessToken) else {
            return
        }
        
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        HelperTRWMSLayer.shared.getTrwslLayerData(baseURL: self.baseURL, completion: { (error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            guard let error = error else {
                
                return
            }
            
            Alert.showServerErrors(controller: self, errorModel: error)
            
        }) { (isSuccess) in
            
        }
    }
    
    func xOfColumn(column: UInt, zoom: UInt) -> Double {
        let x = Double(column);
        let z = Double(zoom);
        return x / pow(2.0, z) * 360.0 - 180;
    }
    func yOfRow(row: UInt, zoom: UInt) -> Double {
        let y = Double(row);
        let z = Double(zoom);
        let n = Double.pi - 2.0 * Double.pi * y / pow(2.0, z);
        return 180.0 / Double.pi * atan(0.5 * (exp(n) - exp(-n)));
    }
    func MercatorXofLongitude(lon: Double) -> Double {
        return  lon * 20037508.34 / 180;
    }
    func MercatorYofLatitude(lat: Double) -> Double {
        var y = log(tan((90 + lat) * Double.pi / 360)) / (Double.pi / 180);
        y = y * 20037508.34 / 180;
        return y
    }
    func bboxFromXYZ(x: UInt, y: UInt, z: UInt) -> BBox {
        // BBOX in spherical mercator
        let bbox = BBox(
            left: MercatorXofLongitude(lon: xOfColumn(column: x, zoom: z)),
            right: MercatorXofLongitude(lon: xOfColumn(column: x+1, zoom: z)),
            bottom: MercatorYofLatitude(lat: yOfRow(row: y+1, zoom: z)),
            top: MercatorYofLatitude(lat: yOfRow(row: y, zoom: z)))
        return bbox
    }
}
struct BBox{
    let left: Double;
    let  right: Double;
    let  bottom: Double;
    let  top: Double;
}
