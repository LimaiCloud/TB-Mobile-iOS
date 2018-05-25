//
//  DeviceModel.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/5/11.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import Foundation

struct DeviceModel {
    var entityType: String?
    var type: String?
    var tenantId: TenantModel
    
    init(jsonData: JSON) {
        entityType    = jsonData["entityType"].stringValue
        type = jsonData["type"].stringValue
        tenantId = TenantModel(jsonData: jsonData["tenantId"])

    }
    
}
