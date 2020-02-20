//
//  GISServerModel.swift
//  TRWMSLayer
//
//  Created by Muhammad Arslan Khalid on 17/02/2020.
//  Copyright © 2020 Waqas Rasheed. All rights reserved.
//

import UIKit
import SwiftyJSON
class GISServerModel: NSObject {

    var featureServerURL: String?
    var changedDate: String?
    var createdDate: String?
    var createdBy, proxyURL, changedBy: String?
    var name, datumDescription: String?
    var attributes: String?
    var disabled: Bool?
    var id: Int?
    var url: String?
    
    init(json:JSON) {
        self.featureServerURL = json["featureServerURL"].string
        self.changedDate = json["changedDate"].string
        self.createdDate = json["createdDate"].string
        self.createdBy = json["createdBy"].string
        self.proxyURL = json["proxyURL"].string
        self.changedBy = json["changedBy"].string
        self.name = json["name"].string
        self.datumDescription = json["datumDescription"].string
        self.attributes = json["attributes"].string
        self.disabled = json["disabled"].bool
        self.id = json["id"].int
        self.url = json["url"].string
    }
    
    
}
