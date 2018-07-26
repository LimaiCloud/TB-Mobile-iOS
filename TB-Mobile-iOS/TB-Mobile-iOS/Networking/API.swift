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

// index
let alphabets = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","#"]

// default tabbar item imageArr
let norArr: [String] = ["首页-默认状态", "通讯录-默认状态", "应用-默认状态", "我的-默认状态"]
// select tabbar item imageArr
let selArr: [String] = ["首页-点击状态", "通讯录-点击状态", "应用-点击状态", "我的-点击状态"]

/**
 *  Global variable --- API URL
 */
// root URL
let rootURL = UrlManager.manager()["base"]!
// login URL
let loginURL = "/api/auth/login"
// acquire device list
let prefixURL = "/api/"
let suffixURL = "/devices?limit=10&textSearch="
let devicesListURL = "/api/tenant/devices?limit=10&textSearch="
// detail device
let websocktURL = "/api/ws/plugins/telemetry?token="

// Bearere Token
let bearereToken = "Bearer "
// token
var token = ""

// tenant
var tenantURL = "/api/tenant/"
var dataBoardURL = "/dashboards"
// dashboard
var dataURL = "/api/tenant/dashboards?limit=10&textSearch="
// customer
var customerURL = "/api/customer/"
let userURL = "/users?limit=10"

// Bugly
let buglyId = "bb68180a7a"

// addressbook
let addressUrl = UrlManager.manager()["contacts"]!
let userToken = "/users?token="

// serverTime
let serverTimeURL = "/api/dashboard/serverTime"
// broadcast
let noticeUrl = UrlManager.manager()["notice"]!
let broadcastURL = "/qiyue/wp-json/wp/v2/posts"

// loading js
let webUrl = "\(rootURL)/static/bundle.897b646d204a361b42e8.js"
