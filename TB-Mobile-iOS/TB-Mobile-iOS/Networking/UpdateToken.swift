//
//  UpdateToken.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/7/13.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import Foundation
import JWTDecode

public class UpdateToken: NSObject {
    
    // refresh token
    class func refreshToken() {
        var userStr = userDefault.object(forKey: "username") as! String
        let pwdStr = userDefault.object(forKey: "password") as! String
        // Stitching parameters
        if (!userStr.contains("@limaicloud.com")  && !userStr.contains("@qq.com")) {
            userStr = userStr + "@limaicloud.com"
        }
                
        let dic = ["username": userStr, "password": pwdStr] as [String : AnyObject]
        
        let apiURL = rootURL + loginURL
        AppService.shareInstance.request(methodType: .POST, urlString: apiURL, parameters: dic) { (result, error) in
            if (error == nil) {
                
                let json = JSON(result as Any)
                token = json["token"].string!
                
                // the token that will be decoded
                do {
                    let jwt = try decode(jwt: token)
//                    print("payload---------%@", jwt)
//                    print("=======%@", jwt.claim(name: "tenantId").string!)
                    let tenantId = jwt.claim(name: "tenantId").string!
                    let customerId = jwt.claim(name: "customerId").string!
                    userDefault.setValue(customerId, forKey: "customerId")
                    userDefault.setValue(tenantId, forKey: "tenantId")
                    let scopes = jwt.claim(name: "scopes").array!
                    userDefault.setValue(scopes[0], forKey: "scopes")
                    let sub = jwt.claim(name: "sub").string!
                    userDefault.setValue(sub, forKey: "sub")
                    let exp = jwt.claim(name: "exp").double
                    userDefault.setValue(exp, forKey: "exp")
//                    print("scopes: %@", scopes[0])
                }catch {
                    print("Failed to decode JWT: \(error)")
                    
                }
                
                // save rootURL
                userDefault.set(rootURL, forKey: "rootAddress")
                userDefault.setValue(token, forKey: "token")
                userDefault.synchronize()
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshToken"), object: self)
                
            }else {
                print("=======%@", error!)
            }
        }
    }
}
