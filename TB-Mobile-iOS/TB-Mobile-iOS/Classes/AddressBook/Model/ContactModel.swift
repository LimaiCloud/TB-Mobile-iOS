//
//  ContactModel.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/7/5.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import Foundation

struct ContactModel {
    var account: String?
    var password: String?
    var role: String?
    var title: String?
    var name: String?
    var company: String?
    var tel: String?
    var email: String?
    var uid: String?
    
    init(jsonData: JSON) {
        account    = jsonData["account"].stringValue
        password = jsonData["password"].stringValue
        role = jsonData["role"].stringValue
        title = jsonData["title"].stringValue
        name = jsonData["name"].stringValue
        company = jsonData["company"].stringValue
        tel = jsonData["tel"].stringValue
        email = jsonData["email"].stringValue
        uid = jsonData["uid"].stringValue
    }
}
