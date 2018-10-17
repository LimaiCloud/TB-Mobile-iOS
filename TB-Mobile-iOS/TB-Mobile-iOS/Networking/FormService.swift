//
//  FormService.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/10/16.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import Foundation
import AFNetworking

class FormService: AFHTTPSessionManager {
    
    static let shareInstance: FormService = {
        let manager = FormService()
        
        let setArr = NSSet(objects: "text/html", "application/json", "text/json")
        manager.responseSerializer.acceptableContentTypes = setArr as? Set<String>
        
        // add HttpHeader
        manager.requestSerializer.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")        

        manager.requestSerializer.willChangeValue(forKey: "timeoutInterval")
        manager.requestSerializer.timeoutInterval = 30.0
        manager.requestSerializer.didChangeValue(forKey: "timeoutInterval")
        return manager
    }()
    
    /**
     A method of opening to the outside world is defined to make requests for network data.
     
     - parameter methodType:        request type(GET / POST)
     - parameter urlString:         url address
     - parameter parameters:
     The parameter required to send a network                  request is a dictionary.
     
     - parameter resultBlock:       The completed callback.
     
     - parameter responseObject:    Callback parameters to return the requested   data.
     
     - parameter error:             If the request succeeds, then the error is nil.
     
     */
    
    func request(methodType: HTTPMethod, urlString: String, parameters: [String : AnyObject]?, resultBlock:@escaping (Any?, Error?)->()) {
        
        // If the request succeeds, then the error is nil.
        let successBlock = { (task: URLSessionDataTask, responseObj: Any?) in
            resultBlock(responseObj, nil)
        }
        
        // If the request succeeds, then the error is nil.
        let failureBlock = { (task: URLSessionDataTask?, error: Error) in
            resultBlock(nil, error)
        }
        
        // request type
        if methodType == HTTPMethod.GET {
            
            get(urlString, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
        } else if methodType == HTTPMethod.POST {
            post(urlString, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
        }else {
            put(urlString, parameters: parameters, success: successBlock, failure: failureBlock)
        }
    }
}
