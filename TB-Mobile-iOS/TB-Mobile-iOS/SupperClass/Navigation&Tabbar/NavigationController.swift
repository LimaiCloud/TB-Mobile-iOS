//
//  NavigationController.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/4/4.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController, UINavigationBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // navigationBar
        if (self.responds(to: #selector(getter: edgesForExtendedLayout))) {
            self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        }
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if (self.viewControllers.count > 0) {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
    }

    override func popViewController(animated: Bool) -> UIViewController? {
        return super.popViewController(animated: true)
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //  Dispose of any resources that can be recreated.
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
