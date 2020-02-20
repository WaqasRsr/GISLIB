//
//  TRTileLayer.swift
//  TRWMSLayer
//
//  Created by Waqas Rasheed on 17/02/2020.
//  Copyright © 2020 Waqas Rasheed. All rights reserved.
//

import Foundation
import GoogleMaps

class TRTileLayer: GMSSyncTileLayer {
    
    var id: Int!
    var isSelected = true
    var layer: GMSTileLayer!
    
    
    override func requestTileFor(x: UInt, y: UInt, zoom: UInt, receiver: GMSTileReceiver) {
        
    }
    
    static func == (lhs: TRTileLayer, rhs: TRTileLayer) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func != (lhs: TRTileLayer, rhs: TRTileLayer) -> Bool {
        return lhs.id != rhs.id
    }
    
}

struct QueryString {
    
    var wmsServer = "https://was.dev.meeraspace.com/geoserver/wms?"
    var wfsServer: String? = "https://was.dev.meeraspace.com/geoserver/wfs?"
    var layerName = "filespace:osmalkhuwair"
    let ESPG = "3857"
    var ID = 7279
    var attribute: String? = "osm_id"
    
    //let featureType = "filespace:osmalkhuwair"
    
    init() {
        
    }
    
    init(wmsServer: String, wfsServer: String?, layerName: String, id: Int, attribute: String?) {
        
        self.wmsServer = wmsServer
        self.wfsServer = wfsServer
        self.layerName = layerName
        self.ID = id
        self.attribute = attribute
    }
}
