//
//  UrlManager.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/7/23.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import Foundation

class UrlManager {
    class func manager() -> [String: String] {
        let fileManager = FileManager.default
        let paths = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)
        let documentsDirectory = paths.first! + "/Caches/"
        let plistPath = documentsDirectory + "address.plist"
        if !fileManager.fileExists(atPath: plistPath) {
            let resourcePath = Bundle.main.path(forResource: "address", ofType: "plist")
            let mainBundleFile = NSData.init(contentsOfFile: resourcePath!)! as Data
            fileManager.createFile(atPath: plistPath, contents: mainBundleFile, attributes: nil)
        }
        let dict = NSDictionary(contentsOfFile: plistPath) as! [String: String]
        return dict
    }
    
    // fluorite config
    class func fluoriteManager() -> [String: String] {
        let fileManager = FileManager.default
        let paths = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)
        let documentsDirectory = paths.first! + "/Caches/"
        let plistPath = documentsDirectory + "fluoriteConfig.plist"
        if !fileManager.fileExists(atPath: plistPath) {
            let resourcePath = Bundle.main.path(forResource: "fluoriteConfig", ofType: "plist")
            let mainBundleFile = NSData.init(contentsOfFile: resourcePath!)! as Data
            fileManager.createFile(atPath: plistPath, contents: mainBundleFile, attributes: nil)
        }
        let dict = NSDictionary(contentsOfFile: plistPath) as! [String: String]
        return dict
    }
}
