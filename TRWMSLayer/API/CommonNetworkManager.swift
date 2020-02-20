//
//  CommonNetworkManager.swift
//  TRWMSLayer
//
//  Created by Muhammad Arslan Khalid on 17/02/2020.
//  Copyright © 2020 Waqas Rasheed. All rights reserved.
//

import UIKit
import OAuthSwift
let CommonNetworkApis = CommonNetworkManager.sharedInstance

class CommonNetworkManager: NSObject {
    
    static let sharedInstance = CommonNetworkManager()
    
}

//MARK:- Network Calls
extension CommonNetworkManager
{
    func loginInAppToGetAccessToken(ouathInfo:OAuth2Swift,userName:String, password:String,completion:@escaping (_ accessToken:String?,_ refreshAccessToken:String?,_ error:ErrorModel?)->Void)
    {
        
        let _ = ouathInfo.authorize(username: userName, password: password, scope: "openid email mobile groups profile offline_access") { result in
            switch (result)
            {
            case .success(let (_, response, _)):
                if let jsonResponce = response?.data
                {
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: jsonResponce, options: JSONSerialization.ReadingOptions.allowFragments)
                        
                        let parseJson = jsonResult as! [String:Any]
                        
                        
                        
                        if let access_token = parseJson["access_token"] as? String
                        {
                            Network.accessToken = access_token
                            Network.refreshAccessToken = parseJson["refresh_token"] as? String
                            completion(Network.accessToken, Network.refreshAccessToken,nil)
                        }
                        else
                        {
                            completion(nil,nil,ErrorModel(errorTitle: "GIS", errorDescp: "Auth token not found", error: nil))
                        }
                        
                        
                        
                    }
                    catch {
                        
                        completion(nil,nil,ErrorModel(errorTitle: "GIS", errorDescp: error.localizedDescription, error: nil))
                        
                    }
                }
                else{
                    
                    completion(nil,nil,ErrorModel(errorTitle: "GIS", errorDescp: "Server not responding", error: nil))
                }
                break;
            case .failure(let error):
                let errorDic = error.errorUserInfo;
                let errorCustom = self.outhErrorHandler(dic: errorDic);
                
                if(errorCustom.code == 401)
                {
                    completion(nil,nil,ErrorModel(errorTitle: "GIS", errorDescp:  errorCustom.errorStr, error: nil, errorCode: 401))
                    
                    
                }
                if(errorCustom.code == 400)
                {
                    completion(nil,nil,ErrorModel(errorTitle: "GIS", errorDescp:  errorCustom.errorStr, error: nil, errorCode: 400))
                }
                else
                {
                    completion(nil,nil,ErrorModel(errorTitle: "GIS", errorDescp: error.localizedDescription, error: nil))
                }
                break;
            }
        }
        
    }
    
    private func outhErrorHandler(dic: [String:Any]?) -> (code:Int,errorStr:String)
    {
        if let _ = dic
        {
            if let m = dic!["error"] as? NSError
            {
                print(m.localizedDescription)
                print(m.code);
                return (code:m.code,errorStr:m.localizedDescription)
            }
        }
        
        return (code:0,errorStr:"Unknown error");
    }
}
