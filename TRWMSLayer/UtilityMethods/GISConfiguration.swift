//
//  GISConfiguration.swift
//  TRWMSLayer
//
//  Created by Waqas Rasheed on 20/02/2020.
//  Copyright © 2020 Waqas Rasheed. All rights reserved.
//

import OAuthSwift

public class GISTRWMSLayer {
    
    static private let scheme = "https://"
    
    static var domain:String = ""
    static var gisSubDomain: String = "" //map api zeena etc
    
    static private let ssoSubDomain: String = "sso"
    static var SSO_URL: String {
        return "\(GISTRWMSLayer.scheme)" + GISTRWMSLayer.ssoSubDomain + "." + "\(GISTRWMSLayer.domain)"
    }
    
    static var oauthswift: OAuth2Swift!
    
    static public func configur(domain: String, gisSubDomain: String) {
        
        GISTRWMSLayer.domain = domain
        GISTRWMSLayer.gisSubDomain = gisSubDomain
        
        GISTRWMSLayer.oauthswift = OAuth2Swift(
            consumerKey: "mobile-app", //meera-dx
            consumerSecret: "ZXhhbXBsZS1hcHAtc2VjcmV1",
            authorizeUrl: GISTRWMSLayer.SSO_URL + "/auth",
            accessTokenUrl: GISTRWMSLayer.SSO_URL + "/token",
            responseType: "code"
        )
    }
    //    public init(domain: String, gisSubDomain: String) {
    //
    //        self.domain = domain
    //        self.gisSubDomain = gisSubDomain
    //
    //        self.oauthswift = OAuth2Swift(
    //            consumerKey: "mobile-app", //meera-dx
    //            consumerSecret: "ZXhhbXBsZS1hcHAtc2VjcmV1",
    //            authorizeUrl: SSO_URL + "/auth",
    //            accessTokenUrl: SSO_URL + "/token",
    //            responseType: "code"
    //        )
    //
    //    }
    
    static var gisBaseURL: String! {
        
        return "\(GISTRWMSLayer.scheme)" + GISTRWMSLayer.gisSubDomain + "." + GISTRWMSLayer.domain
    }
    
    
}
