//
//  UIAlertBlock.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/7/24.
//  Copyright © 2017年 qtz. All rights reserved.
//

import Foundation
import UIKit

public extension UIAlertController {
      
    class func okAlert(
        presentController: UIViewController!,
        title: String!,
        message: String!,
        okButtonTitle: String? = "确定",
        okHandler: ((UIAlertAction) -> Void)!) {
        
        let alert = UIAlertController(title: title!, message: message!, preferredStyle: UIAlertControllerStyle.alert)
        if okButtonTitle != nil {
            alert.addAction(UIAlertAction(title: okButtonTitle!, style: UIAlertActionStyle.default, handler: okHandler))
            
        }
        presentController!.present(alert, animated: true, completion: nil)
        
    }
    
    class func showAlert(
        presentController: UIViewController!,
        title: String!,
        message: String!,
        cancelButtonTitle: String? = "取消",
        okButtonTitle: String? = "确定",
        
        okHandler: ((UIAlertAction) -> Void)!) {
        let alert = UIAlertController(title: title!, message: message!, preferredStyle: UIAlertControllerStyle.alert)
        if cancelButtonTitle != nil {
            alert.addAction(UIAlertAction(title: cancelButtonTitle!, style: UIAlertActionStyle.default, handler: nil))
        }
        
        if okButtonTitle != nil {
            alert.addAction(UIAlertAction(title: okButtonTitle!, style: UIAlertActionStyle.default, handler: okHandler))
            
        }
        presentController!.present(alert, animated: true, completion: nil)
    }
}
