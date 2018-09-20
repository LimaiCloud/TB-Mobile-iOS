//
//  BoardsModel.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/9/17.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import Foundation
import UIKit

struct BoardsModel {
    var title: String?
    var _id: String?
    
    init(jsonData: JSON) {
        title    = jsonData["title"].stringValue
        _id = jsonData["_id"].stringValue
       
    }
}
