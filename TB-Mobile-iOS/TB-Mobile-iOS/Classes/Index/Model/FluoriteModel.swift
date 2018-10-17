//
//  FluoriteModel.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/10/16.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import Foundation

struct FluoriteModel {
    var deviceSerial: String?
    var deviceName: String?
    var deviceType: String?
    var deviceVersion: String?
    
    init(jsonData: JSON) {
        deviceSerial    = jsonData["deviceSerial"].stringValue
        deviceName = jsonData["deviceName"].stringValue
        deviceType    = jsonData["deviceType"].stringValue
        deviceVersion = jsonData["deviceVersion"].stringValue
    }
}
