//
//  API.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/4/4.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import Foundation
import UIKit

/**
 *  This file is Global variable
 */

// Screen width
let kScreen_W = UIScreen.main.bounds.size.width
// Screen height
let kScreen_H = UIScreen.main.bounds.size.height

let appDelegate = UIApplication.shared.delegate as! AppDelegate

let userDefault = UserDefaults.standard


/**
 *  Global variable --- color
 */

// The background color of the line
let spliteBgColor = "dddddd"
// tabbar item title  normal color
let itemTitleNorColor = "888888"
// tabbar item title  selected color
let itemTitleSelColor = "3783d2"

/**
 *  Global variable --- Array
 */

// default tabbar item imageArr
let norArr: [String] = ["首页-默认状态", "通讯录-默认状态", "应用-默认状态", "我的-默认状态"]
// select tabbar item imageArr
let selArr: [String] = ["首页-点击状态", "通讯录-点击状态", "应用-点击状态", "我的-点击状态"]

/**
 *  Global variable --- API URL
 */
// root URL
var rootURL = ""
// login URL
let loginURL = "/api/auth/login"
// getDeviceType
let deviceURL = "/api/device/types"

// Bearere Token
let bearereToken = "Bearer "
// token
var token = ""
//
