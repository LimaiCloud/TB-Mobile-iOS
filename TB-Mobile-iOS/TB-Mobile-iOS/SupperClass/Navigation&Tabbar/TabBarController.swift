//
//  TabBarController.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/4/4.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
   
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // selected colort
        let selDic = NSMutableDictionary()
        selDic[NSAttributedStringKey.foregroundColor] = UIColor.hexStringToColor(hexString: "29ddd7")
        selDic[NSAttributedStringKey.font] = UIFont.systemFont(ofSize: 11.0)
        item.setTitleTextAttributes(selDic as? [NSAttributedStringKey : Any] , for: .selected)
        
    }
    func animationWithIndex(_ index: NSInteger) {
        let tabbarbuttonArray = NSMutableArray()

        for tabBarButton in self.tabBar.subviews {
            if ((tabBarButton as UIView) .isKind(of: NSClassFromString("UITabBarButton")!)) {
                tabbarbuttonArray.add(tabBarButton)
            }
        }
        let pulse = CABasicAnimation(keyPath: "transform.scale") 
        pulse.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pulse.duration = 0.3;
        pulse.repeatCount = 1;
        pulse.autoreverses = true
        pulse.fromValue = NSNumber(value: 0.7)
        pulse.toValue = NSNumber(value: 1.3)
        let tabView = tabbarbuttonArray[index] as! UIView
        tabView.layer.add(pulse, forKey: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
