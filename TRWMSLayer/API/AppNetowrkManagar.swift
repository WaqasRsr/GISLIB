//
//  AppNetowrkManagar.swift
//  TRWMSLayer
//
//  Created by Muhammad Arslan Khalid on 14/02/2020.
//  Copyright © 2020 Waqas Rasheed. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import OAuthSwift


let Network = AppNetowrkManagar.sharedInstance
class AppNetowrkManagar: NSObject {
    
    static let sharedInstance = AppNetowrkManagar()
    var accessToken:String!
    var refreshAccessToken:String!
    var oauthswift:OAuth2Swift!
    var isCallingRefreshToken = false
}


//MARK:- Restfull Api
extension AppNetowrkManagar
{
    func asyncCallRestFullApi(baseUrl:String!, pathUrl:String ,parameter:[String:Any]?,serviceMethod:ServiceType, success:@escaping(_ json:JSON) -> Void, failure:@escaping (_ errorMode:ErrorModel) -> Void, tokenRefresh:@escaping (_ isSuccess:Bool)->Void)
    {
        guard let urlStr = (baseUrl + pathUrl).encodeUrl
            else
        {
            failure(ErrorModel(errorTitle: "URL Error", errorDescp: "Url is not correct", error: nil))
            return
        }
        
        var headers: HTTPHeaders  = HTTPHeaders()
        
        if AppUtility.hasValidText(self.accessToken)
        {
            headers["Authorization"] = "Bearer \(self.accessToken!)"
        }
        else
        {
            failure(ErrorModel(errorTitle: "Xeena", errorDescp: "Token Error", error: nil))
            return
        }
        
        headers["Content-Type"] = "application/json"
        
        
        
        
        AF.request(urlStr, method:HTTPMethod(rawValue: serviceMethod.rawValue), parameters:parameter ,encoding:JSONEncoding.default,headers:headers)
            .responseString(completionHandler: { (dataStr) in
                print(dataStr)
            })
            .responseJSON { (response) in
                
                switch response.result
                {
                case .success:
                    
                    let httpResponse = response.response
                    if httpResponse?.statusCode != 200  //!=200
                    {
                        if self.isCallingRefreshToken == false
                        {
                            self.isCallingRefreshToken = true
                            self.refreshOuth2Token(baseUrl: baseUrl, pathUrl: pathUrl, parameter: parameter, serviceMethod: serviceMethod, success: success, failure: failure, tokenRefresh: tokenRefresh)
                        }
                        else
                        {
                            self.asyncCallRestFullApi(baseUrl: baseUrl, pathUrl: pathUrl, parameter: parameter, serviceMethod: serviceMethod, success: success, failure: failure, tokenRefresh: tokenRefresh)
                        }
                    }
                    else
                    {
                        if let res = response.value
                        {
                            
                            let jsonVal = JSON(res)
                            
                            if jsonVal["success"].boolValue == true
                            {
                                DispatchQueue.main.async {
                                    success(jsonVal)
                                }
                                
                            }
                            else if jsonVal.array?.first?["x"].double != nil
                            {
                                DispatchQueue.main.async {
                                    success(jsonVal)
                                }
                            }
                                
                            else
                            {
                                if let message =  jsonVal["error"].string
                                {
                                    failure(ErrorModel(errorTitle: "Xeena", errorDescp:message, error: nil, errorCode: jsonVal["code"].int ?? 0))
                                }
                                else if let message = jsonVal["response"].string
                                {
                                    failure(ErrorModel(errorTitle: "Xeena", errorDescp:message, error: nil, errorCode: jsonVal["code"].int ?? 0))
                                }
                                else
                                {
                                    failure(ErrorModel(errorTitle: "Xeena", errorDescp:"something went wrong", error: nil, errorCode: jsonVal["code"].int ?? 0))
                                }
                                
                            }
                            
                            
                            
                        }
                        else
                        {
                            failure(ErrorModel(errorTitle: "Xeena", errorDescp: "Got Response Nil", error: nil))
                        }
                    }
                    
                    
                    
                    break;
                case .failure(let error):
                    failure(ErrorModel(errorTitle: "Xeena", errorDescp: error.localizedDescription, error: error))
                    break;
                }
                
        }
        
    }
}


//MARK:- Refresh Access Token
extension AppNetowrkManagar
{
    func refreshOuth2Token(baseUrl:String!, pathUrl:String ,parameter:[String:Any]?,serviceMethod:ServiceType, success:@escaping(_ json:JSON) -> Void, failure:@escaping (_ errorMode:ErrorModel) -> Void, tokenRefresh:@escaping (_ isSuccess:Bool)->Void )
    {
        
        let refreshToken = self.refreshAccessToken!
        
        oauthswift.renewAccessToken(withRefreshToken: refreshToken) { result in
            
            switch(result)
            {
            case .success(let (_, response, _)):
                
                
                if let jsonResponce = response?.data
                {
                    do {
                        let jsonResp = try JSONSerialization.jsonObject(with: jsonResponce, options: JSONSerialization.ReadingOptions.allowFragments)
                        let parseJson = jsonResp as! [String:Any]
                        if let access_token = parseJson["access_token"] as? String
                        {
                            
                            
                            self.accessToken = access_token;
                            if let refresh_token = parseJson["refresh_token"] as? String
                            {
                                self.refreshAccessToken = refresh_token;
                            }
                            tokenRefresh(true)
                            self.asyncCallRestFullApi(baseUrl: baseUrl, pathUrl: pathUrl, parameter: parameter, serviceMethod: serviceMethod, success: success, failure: failure,tokenRefresh: tokenRefresh)
                        }
                        else
                        {
                            tokenRefresh(false)
                        }
                        
                        
                        
                    } catch(let error) {
                        tokenRefresh(false)
                        print(error.localizedDescription)
                    }
                    
                }
                
                
                self.isCallingRefreshToken = false
                break;
            case .failure(let error ):
                
                self.isCallingRefreshToken = false
                print(error.localizedDescription);
                tokenRefresh(false)
                break;
            }
            
        }
    }
}

public struct ErrorModel {
    
    var errorTitle:String?
    var errorDescp:String?
    var error:Error?
    var errorCode:Int!
    var errorDic: [String:Any]?
    
    
    init(errorTitle:String, errorDescp:String, error:Error?, errorCode:Int = 0, errorDic: [String:Any]? = nil) {
        self.errorTitle = errorTitle
        self.errorDescp = errorDescp
        self.error = error
        self.errorCode = errorCode
        self.errorDic = errorDic
    }
}




enum ServiceType:String {
    case POST = "POST"
    case GET = "GET"
    case PUT = "PUT"
    case DELETE = "DELETE"
}


extension String
{
    var encodeUrl:String? {
        
        if let urlStr = self.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        {
            return urlStr
        }
        return nil
    }
}

public typealias serviceCompletionerHandler = (_ result:JSON?,_ error:ErrorModel? ) ->Void
