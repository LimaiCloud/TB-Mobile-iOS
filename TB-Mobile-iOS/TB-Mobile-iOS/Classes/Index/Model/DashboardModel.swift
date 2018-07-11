//
//  DashboardModel.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/6/19.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit

struct DashboardModel {
    var title: String?
    var name: String?
    var tenantId: TenantModel
    var createdTime: String?
    
    init(jsonData: JSON) {
        title    = jsonData["title"].stringValue
        name = jsonData["name"].stringValue
        createdTime = jsonData["createdTime"].stringValue
        tenantId = TenantModel(jsonData: jsonData["tenantId"])
        
    }
}
