//
//  WebService.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/5/10.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import Foundation

public class WebServices: NSObject {
    
    let sessionManager = AFHTTPSessionManager()
//    let requestSerializer = AFHTTPRequestSerializer()
//    let responseSerializer = AFHTTPResponseSerializer()
//    var timeOutInterval: TimeInterval = 30
//
//    var runningTasks: [URLSessionDataTask] = [URLSessionDataTask]()
//    var waitingTasks: [(() -> Void)] = []
//
//    //Locked queue used when update access token, access token refresh call should be called only once at a time
//    private var _isUpdatingAccessToken = false
//

    // Initializer
    public override init() {
        super.init()
        
        let setArr = NSSet(objects: "text/html", "application/json", "text/json")
        sessionManager.responseSerializer.acceptableContentTypes = setArr as? Set<String>
        
        // add HttpHeader
        sessionManager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        sessionManager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        
        token = userDefault.object(forKey: "token") as! String
        sessionManager.requestSerializer.setValue(bearereToken + token, forHTTPHeaderField: "X-Authorization")
        
        sessionManager.requestSerializer.willChangeValue(forKey: "timeoutInterval")
        sessionManager.requestSerializer.timeoutInterval = 30.0
        sessionManager.requestSerializer.didChangeValue(forKey: "timeoutInterval")
        
    }
 
    func request(methodType: HTTPMethod, urlString: String, parameters: [String : AnyObject]?, resultBlock:@escaping (Any?, Error?)->()) {
        
        //If the request succeeds, then the error is nil.
        let successBlock = { (task: URLSessionDataTask, responseObj: Any?) in
            resultBlock(responseObj, nil)
        }
        
        //If the request succeeds, then the error is nil.
        let failureBlock = { (task: URLSessionDataTask?, error: Error) in
            resultBlock(nil, error)
        }
        
        // request type
        if methodType == HTTPMethod.GET {
            
            sessionManager.get(urlString, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
        } else {
            sessionManager.post(urlString, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)

        }
    }
}
