//
//  HUDManager.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/4/4.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit

class HUDManager: NSObject {

    // show MBProgressHUD
    func showHud(_ controller: UIViewController) {
        MBProgressHUD.showAdded(to: controller.view, animated: true)
    }
    // hide MBProgressHUD
    func hideHud(_ controller: UIViewController) {
        MBProgressHUD.hide(for: controller.view, animated: true)
    }
    
    // Prompt box
    func showTips(_ message: String, view: UIView) {
        if (message.isEmpty) {
            return;
        }else{
            let window = UIApplication.shared.keyWindow
            let showview = UIView()
            showview.backgroundColor = UIColor(red: 37 / 255.0, green: 37 / 255.0, blue: 37 / 255.0, alpha: 0.8)
            showview.frame = CGRect(x: 1.0, y: 1.0, width: 1.0, height: 1.0)
            showview.alpha = 1.0
            showview.layer.cornerRadius = 4.0
            showview.layer.masksToBounds = true
            window?.addSubview(showview)
            
            let label = UILabel()
            let font = UIFont.systemFont(ofSize: 15.0)
            let size = message.size(withAttributes: [NSAttributedStringKey.font: font])
            label.frame = CGRect(x: 10, y: 10, width: size.width, height: size.height)
            
            label.text = message
            label.numberOfLines = 0;
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.textColor = UIColor.white
            label.textAlignment = NSTextAlignment.center
            label.backgroundColor = UIColor.clear
            label.font = UIFont.systemFont(ofSize: 15.0)
            showview.addSubview(label)

            showview.frame = CGRect(x: (kScreen_W - size.width - 20) / 2, y: (kScreen_H - size.height) / 2, width: size.width + 20, height: size.height + 20)
            UIView.animate(withDuration: 3.0, animations: { 
                showview.alpha = 0
            }, completion: { (Bool) in
                showview.removeFromSuperview()
            })
            
        }
    }
}
