//
//  BoardsListModel.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/9/17.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import Foundation
import UIKit

struct BoardsListModel {
    var title: String?
    var _id: String?
    var boardId: String?
    var createdAt: String?
    var updatedAt: String?
    var description: String?
    
    init(jsonData: JSON) {
        title    = jsonData["title"].stringValue
        _id = jsonData["_id"].stringValue
        boardId    = jsonData["boardId"].stringValue
        createdAt = jsonData["createdAt"].stringValue
        updatedAt    = jsonData["updatedAt"].stringValue
        description = jsonData["description"].stringValue
    }
}
