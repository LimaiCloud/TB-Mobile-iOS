//
//  StringUtil.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/4/4.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit

class StringUtil: NSObject {

    // Change line and word spacing.
    class func changeSpaceForLabel(_ string: String) -> NSAttributedString {
    
        let paraph = NSMutableParagraphStyle()
        paraph.lineSpacing = 2
        let attributes = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0), NSAttributedStringKey.paragraphStyle: paraph]
       return NSAttributedString(string: string, attributes: attributes)
        
    }
    
    class func getStringSize(_ string: String, fontSize: CGFloat) -> CGSize {
        let font = UIFont.systemFont(ofSize: fontSize)
        let size = string.size(withAttributes: [NSAttributedStringKey.font: font])
        return size
    }
    
    class func getLabelHight(_ string: String, fontSize: CGFloat, width: CGFloat) -> CGFloat {
        let contentLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 0))
        contentLabel.numberOfLines = 0
        contentLabel.font = UIFont.systemFont(ofSize: fontSize)
        contentLabel.lineBreakMode = NSLineBreakMode.byTruncatingTail
        
        let paraph = NSMutableParagraphStyle()
        paraph.lineSpacing = 2
        let attributes = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: fontSize), NSAttributedStringKey.paragraphStyle: paraph]
        contentLabel.attributedText = NSAttributedString(string: string, attributes: attributes)
        
        contentLabel.text = string
        contentLabel.sizeToFit()
        
        return contentLabel.frame.height
    }
    
    class func getTextViewHight(_ string: String, fontSize: CGFloat, width: CGFloat) -> CGFloat {
        let contentLabel = UITextView(frame: CGRect(x: 0, y: 0, width: width, height: 0))
        contentLabel.font = UIFont.systemFont(ofSize: fontSize)
        contentLabel.text = string
        contentLabel.sizeToFit()
        
        return contentLabel.frame.height
    }
    
}

extension String {
    func stringByAddingPercentEncodingForRFC3986() -> String? {
        //        let item0 = ["="   ,  "&"  ,  "<"   , ">"   , "/" ]
        //        let item1 = ["%3D" , "%26" , "%3C" , "%3E" , "%2F"]
        //        var replaceString = self
        //        for i in 0 ..< item0.count {
        //            replaceString = replaceString.stringByReplacingOccurrencesOfString(item0[i], withString: item1[i], options: .LiteralSearch, range: nil)
        //        }
        //        return replaceString
        
        //        let unreserved = "-._~/?:"
        let unreserved = ""
        let allowed = NSMutableCharacterSet.alphanumeric()
        allowed.addCharacters(in: unreserved)
        return addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)
    }
    func stringByUrlEncoding() -> String? {
        let item0 = ["="   ,  "&"  ,  "<"   , ">"   , "/"  , ":"   , "?"]
        let item1 = ["%3D" , "%26" , "%3C" , "%3E" , "%2F" , "%3A" , "%3F"]
        var replaceString = self
        for i in 0 ..< item0.count {
            replaceString = replaceString.replacingOccurrences(of: item0[i], with: item1[i], options: .literal, range: nil)
        }
        return replaceString
    }
    func stringByAddingPercentEncodingForASCII() -> String? {
        let item0 = ["%x20", "%x0A", "%x22"]
        let item1 = [" ",    "\n",   "\""]
        var replaceString = self
        for i in 0 ..< item0.count {
            replaceString = replaceString.replacingOccurrences(of: item0[i], with: item1[i], options: .literal, range: nil)
        }
        return replaceString
    }
    func handleLsQueryJson() -> String {
        let item0 = ["%x7B", "%x7D", "%x5B", "%x5D",  "%x20",  "%x22", "%x3A", "%x2C"];
        let item1 = ["{",    "}",    "[",    "]",     " ",     "\"",    ":",   ","];
        var replaceString = self
        for i in 0 ..< item0.count {
            replaceString = replaceString.replacingOccurrences(of: item0[i], with: item1[i], options: .literal, range: nil)
        }
        return replaceString.removingPercentEncoding!
        //        return replaceString.stringByRemovingPercentEncoding!
    }
    
    func stringByUrlEncodingOfOA() -> String? {
        let item0 = ["<"   , ">"   , "%x3A"]
        let item1 = ["%3C" , "%3E" , ":"]
        var replaceString = self
        for i in 0 ..< item0.count {
            replaceString = replaceString.replacingOccurrences(of: item0[i], with: item1[i], options: .literal, range: nil)
        }
        return replaceString
    }
}
