//
//  TenantModel.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/5/11.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import Foundation

struct TenantModel {
    var entityType: String?
    var id: String?
    
    init(jsonData: JSON) {
        entityType    = jsonData["entityType"].stringValue
        id = jsonData["id"].stringValue
        
    }
}
