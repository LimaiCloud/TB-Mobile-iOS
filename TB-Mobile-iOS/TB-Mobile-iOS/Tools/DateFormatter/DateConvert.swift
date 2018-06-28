//
//  DateConvert.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/6/27.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import Foundation

class DateConvert: NSObject {
    // dataFormater
    class func changeDateFormatter(_ timeStr: String)-> String {
        //converted to timeInterval
        let timeInterval:TimeInterval = TimeInterval(timeStr)!
        let date = NSDate(timeIntervalSince1970: timeInterval / 1000)
        // dateFormatter
        let dateFormatter = DateFormatter()
        // solve time bug
        let locale = NSLocale(localeIdentifier: "en_US")
        dateFormatter.locale = locale as Locale!
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date as Date)
    }
}