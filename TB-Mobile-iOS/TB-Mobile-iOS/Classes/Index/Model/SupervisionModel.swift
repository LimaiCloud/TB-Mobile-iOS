//
//  SupervisionModel.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/10/8.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import Foundation

struct SupervisionModel {
    var title: String?
    var _id: String?
    var createdAt: String?
    var dateLastActivity: String?
    var description: String?
    
    init(jsonData: JSON) {
        title    = jsonData["title"].stringValue
        _id = jsonData["_id"].stringValue
        dateLastActivity    = jsonData["dateLastActivity"].stringValue
        createdAt = jsonData["createdAt"].stringValue
        description = jsonData["description"].stringValue
    }
}
