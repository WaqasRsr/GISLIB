//
//  HelperTRWMSLayer.swift
//  TRWMSLayer
//
//  Created by Muhammad Arslan Khalid on 14/02/2020.
//  Copyright © 2020 Waqas Rasheed. All rights reserved.
//

import UIKit

class HelperTRWMSLayer: NSObject {
    
    static var shared = HelperTRWMSLayer()
    var trwslayerData :TWMSLayerModel!
    
}


extension HelperTRWMSLayer
{
    func getTrwslLayerData(baseURL:String,completion:@escaping (_ error:ErrorModel?) -> Void, tokenRefresh:@escaping (_ isSuccess:Bool)->Void)
    {
        Network.asyncCallRestFullApi(baseUrl: baseURL, pathUrl: "/service/map/active?activeOnly=true", parameter: nil, serviceMethod: ServiceType.GET, success: { (json) in
            self.trwslayerData = TWMSLayerModel(json: json["data"][0])
            completion(nil)
        }, failure: { (error) in
            completion(error)
        }) { (isSuces) in
            tokenRefresh(isSuces)
        }
    }
    
    func getMapsList(baseURL:String,pathURL:String,completion:@escaping(_ result:[TWMSLayerModel]?,_ error:ErrorModel?) -> Void,tokenRefresh:@escaping (_ isSuccess:Bool)->Void)
    {
        Network.asyncCallRestFullApi(baseUrl: baseURL, pathUrl: pathURL, parameter: nil, serviceMethod: ServiceType.GET, success: { (json) in
            
            var result = [TWMSLayerModel]()
            if let mapData = json["data"].array
            {
                result = mapData.map({ (mapJson) -> TWMSLayerModel in
                    TWMSLayerModel(json: mapJson)
                })
            }
            completion(result,nil)
        }, failure: { (error) in
            completion(nil,error)
        }) { (isSuces) in
            tokenRefresh(isSuces)
        }
    }
    
    func getServersData(baseURL:String,pathURL:String,completion:@escaping(_ result:[GISServerModel]?,_ error:ErrorModel?) -> Void,tokenRefresh:@escaping (_ isSuccess:Bool)->Void)
    {
        Network.asyncCallRestFullApi(baseUrl: baseURL, pathUrl: pathURL, parameter: nil, serviceMethod: ServiceType.GET, success: { (json) in
            
            var result = [GISServerModel]()
            if let mapData = json["data"].array
            {
                result = mapData.map({ (serverJson) -> GISServerModel in
                    GISServerModel(json: serverJson)
                })
            }
            completion(result,nil)
        }, failure: { (error) in
            completion(nil,error)
        }) { (isSuces) in
            tokenRefresh(isSuces)
        }
    }
    
    func getDataSets(baseURL:String,pathURL:String,completion:@escaping(_ result:[Layer]?,_ error:ErrorModel?) -> Void,tokenRefresh:@escaping (_ isSuccess:Bool)->Void)
    {
        Network.asyncCallRestFullApi(baseUrl: baseURL, pathUrl: pathURL, parameter: nil, serviceMethod: ServiceType.GET, success: { (json) in
            
            var result = [Layer]()
            if let mapData = json["data"].array
            {
                result = mapData.map({ (mapLayerJson) -> Layer in
                    Layer(json: mapLayerJson)
                })
            }
            completion(result,nil)
        }, failure: { (error) in
            completion(nil,error)
        }) { (isSuces) in
            tokenRefresh(isSuces)
        }
    }
    
}
