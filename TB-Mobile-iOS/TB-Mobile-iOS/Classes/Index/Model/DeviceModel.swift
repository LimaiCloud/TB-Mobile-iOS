//
//  DeviceModel.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/5/11.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import Foundation

struct DeviceModel {
    var name: String?
    var type: String?
    var title: String?
    var tenantId: TenantModel
    var id: TenantModel
    var customerId: TenantModel
    
    init(jsonData: JSON) {
        name    = jsonData["name"].stringValue
        type = jsonData["type"].stringValue
        title = jsonData["title"].stringValue
        tenantId = TenantModel(jsonData: jsonData["tenantId"])
        id = TenantModel(jsonData: jsonData["id"])
        customerId = TenantModel(jsonData: jsonData["customerId"])

    } 
}
