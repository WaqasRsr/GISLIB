//
//  TWMSLayerModel.swift
//  TRWMSLayer
//
//  Created by Muhammad Arslan Khalid on 14/02/2020.
//  Copyright © 2020 Waqas Rasheed. All rights reserved.
//

import UIKit
import SwiftyJSON

class TWMSLayerModel: NSObject {
    
    var controls: String?
    var maxZoom: Int?
    var maxY, maxX: Double?
    var descp: String?
    var units: String?
    var userSubject: String?
    var changedDate: String?
    var srs: String?
    var changedBy: String?
    var id: Int?
    var height: Double?
    var minZoom: Int?
    var label: String?
    var url, maxResolution: String?
    var isDefault: Bool?
    var createdDate: String?
    var minY: Double?
    var minX: Double?
    var createdBy: String?
    var scales:String?
    var width: Double?
    var name: String?
    var parameters: String?
    var layers: [Layer]?
    var baseLayers: [BaseLayer]?
    
    
    var isBaseLayerExpended = false
    
    init(json:JSON) {
        self.controls = json["controls"].string
        self.maxZoom = json["maxZoom"].int
        self.maxY = json["maxY"].double
        self.maxX = json["maxX"].double
        self.descp = json["description"].string
        self.units = json["units"].string
        self.userSubject = json["userSubject"].string
        self.changedDate = json["changedDate"].string
        self.srs = json["srs"].string
        self.changedBy = json["changedBy"].string
        if let arr = json["layers"].array { self.layers = arr.map { (data) -> Layer in
            Layer(json: data)
            }}
        self.id = json["id"].int
        self.height = json["height"].double
        self.minZoom = json["minZoom"].int
        self.label = json["label"].string
        self.url = json["url"].string
        self.maxResolution = json["maxResolution"].string
        self.isDefault = json["isDefault"].bool
        self.createdDate = json["createdDate"].string
        self.minY = json["minY"].double
        if let arr = json["baseLayers"].array {self.baseLayers = arr.map({ (data) -> BaseLayer in
            BaseLayer(json: data)
        })}
        self.minX = json["minX"].double
        self.createdBy = json["createdBy"].string
        self.scales = json["scales"].string
        self.width = json["width"].double
        self.name = json["name"].string
        self.parameters = json["parameters"].string
        
    }
    
    
}

class Layer: NSObject {
    
    var defaultActive: Bool?
    var displayOrder: Int?
    var layerDescription: String?
    var useSingleTile: Bool?
    var userSubject: String?
    var legendURL: String?
    var catalogAttribute: String?
    var changedDate: String?
    var featureAttribute: String?
    var changedBy: String?
    var featureType, geomName: String?
    var id: Int?
    var layerType: String?
    var label: String?
    var geometryExpr, catalogName: String?
    var queryable: Bool?
    var pollInterval: String?
    var isDefault: Bool?
    var createdDate: String?
    var rendered: Bool?
    var createdBy: String?
    var name: String?
    var style, featureCatalog: String?
    var attributes: [Attribute]?
    var cqlFilter, layerOpacity, featureTypesWithLegendGraphics, wfsFilter: String?
    var mapServer: MapServer?
    var bounds: BoundsModel?
    var map: TWMSLayerModel?
    
    
    var isSelected = false
    
    init(json:JSON) {
        
        self.defaultActive = json["defaultActive"].bool
        self.displayOrder = json["displayOrder"].int
        self.layerDescription = json["layerDescription"].string
        self.useSingleTile = json["useSingleTile"].bool
        self.userSubject = json["userSubject"].string
        self.legendURL = json["legendURL"].string
        self.catalogAttribute = json["catalogAttribute"].string
        self.changedDate = json["changedDate"].string
        self.featureAttribute = json["featureAttribute"].string
        self.changedBy = json["changedBy"].string
        self.featureType = json["featureType"].string
        self.geomName = json["geomName"].string
        self.id = json["id"].int
        self.map = TWMSLayerModel(json: json["map"])
        self.layerType = json["layerType"].string
        self.mapServer =  MapServer(json: json["mapServer"])
        self.label = json["label"].string
        self.geometryExpr = json["geometryExpr"].string
        self.catalogName = json["catalogName"].string
        self.queryable = json["queryable"].bool
        self.pollInterval = json["pollInterval"].string
        self.isDefault = json["isDefault"].bool
        self.createdDate = json["createdDate"].string
        self.rendered = json["rendered"].bool
        self.createdBy = json["createdBy"].string
        self.bounds = BoundsModel(json: json["bounds"])
        self.name = json["name"].string
        self.style = json["style"].string
        self.featureCatalog = json["featureCatalog"].string
        if let arr = json["attributes"].array{self.attributes = arr.map({ (data) -> Attribute in
            Attribute(json: data)
        })}
        self.cqlFilter = json["cqlFilter"].string
        self.layerOpacity = json["layerOpacity"].string
        self.featureTypesWithLegendGraphics = json["featureTypesWithLegendGraphics"].string
        self.wfsFilter = json["wfsFilter"].string
    }
    
    static func == (lhs: Layer, rhs: Layer) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func != (lhs: Layer, rhs: Layer) -> Bool {
        return lhs.id != rhs.id
    }
}





class Attribute {
    var isGeometry, nullable: Bool?
    var displayName: String?
    var attributeDescription: String?
    var type: String?
    var maxOccures: Int?
    var changedDate: String?
    var createdDate:String?
    var createdBy: String?
    var minOccures: Int?
    var changedBy: String?
    var name: String?
    var id: Int?
    var value: String?
    init(json:JSON) {
        self.isGeometry = json["isGeometry"].bool
        self.nullable = json["nullable"].bool
        self.displayName = json["displayName"].string
        self.attributeDescription = json["attributeDescription"].string
        self.type = json["type"].string
        self.maxOccures = json["maxOccures"].int
        self.changedDate = json["changedDate"].string
        self.createdDate = json["createdDate"].string
        self.minOccures = json["minOccures"].int
        self.changedBy = json["changedBy"].string
        self.name = json["name"].string
        self.id = json["id"].int
        self.value = json["value"].string
    }
}

class MapServer {
    
    var featureServerURL: String?
    var changedDate: String?
    var createdDate: String?
    var createdBy: String?
    var proxyURL: String?
    var changedBy: String?
    var name, mapServerDescription: String?
    var attributes: String?
    var disabled: Bool?
    var id: Int?
    var url: String?
    init(json:JSON) {
        
        self.featureServerURL = json["featureServerUrl"].string
        self.changedDate = json["changedDate"].string
        self.createdDate = json["createdDate"].string
        self.createdBy = json["createdBy"].string
        self.proxyURL = json["proxyURL"].string
        self.changedBy = json["changedBy"].string
        self.name = json["name"].string
        self.mapServerDescription = json["mapServerDescription"].string
        self.disabled = json["disabled"].bool
        self.id = json["id"].int
        self.url = json["url"].string
        
    }
    
}

class BoundsModel
{
    var minY:Double!
    var minX:Double!
    var SRS:String!
    var maxY:Double!
    var maxX:Double!
    
    init(json:JSON) {
        self.minX = json["minX"].double
        self.minY = json["minY"].double
        self.SRS = json["SRS"].string
        self.maxY = json["maxY"].double
        self.maxX = json["maxX"].double
    }
}


class BaseLayer {
    var layerType: String?
    var apiKey: String?
    var displayOrder: Int?
    var baseLayerDescription, label: String?
    var url: String?
    var changedDate: String?
    var sortKey: String?
    var createdDate: String?
    var rendered: Bool?
    var createdBy: String?
    var changedBy: String?
    var featureType: String?
    var name: String?
    var id: Int?
    var maps: [TWMSLayerModel]?
    
    var isSelected = false
    
    init(json:JSON) {
        self.layerType = json["layerType"].string
        if let arr = json["maps"].array {self.maps = arr.map({ (data) -> TWMSLayerModel in
            TWMSLayerModel(json: data)
        })}
        self.apiKey = json["apiKey"].string
        self.displayOrder = json["displayOrder"].int
        self.baseLayerDescription = json["baseLayerDescription"].string
        self.label = json["label"].string
        self.url = json["url"].string
        self.changedDate = json["changedDate"].string
        self.sortKey = json["sortKey"].string
        self.createdDate = json["createdDate"].string
        self.rendered = json["rendered"].bool
        self.createdBy = json["createdBy"].string
        self.changedBy = json["changedBy"].string
        self.featureType = json["featureType"].string
        self.name = json["name"].string
        self.id = json["id"].int
    }
    
}


extension Array where Element: BaseLayer {
    var isAllSelected: Bool {
        set {
            for m in self {
                m.isSelected = newValue
            }
        }
        get {
            let f = self.filter { $0.isSelected == false }
            return f.count == 0
        }
        
    }
}

extension TWMSLayerModel {
  func selectedLayers() -> [Layer] {
    let filtered = layers?.filter({ $0.isSelected })
    return filtered ?? []
  }
  func selectedBaseLayers() -> [BaseLayer] {
    let filtered = baseLayers?.filter({ $0.isSelected })
    return filtered ?? []
  }
}
