//
//  TabBarController.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/4/4.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

   var selDic = NSMutableDictionary()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialization controller
        self.setUpChildVC()
    }
   
    // initialization controller
    func setUpChildVC() {
        let childArr =  self.childViewControllers
        
        let indexVC = childArr[0]
        let addressVC = childArr[1]
        let applicaVC = childArr[2]
        let hompageVC = childArr[3]
        
        // index
        var image:UIImage = UIImage(named: norArr[0])!
        var selectedimage:UIImage = UIImage(named: selArr[0])!
        image = image.withRenderingMode(UIImageRenderingMode.alwaysOriginal);
        selectedimage = selectedimage.withRenderingMode(UIImageRenderingMode.alwaysOriginal);
        indexVC.tabBarItem.image = image
        indexVC.tabBarItem.selectedImage = selectedimage
        // addressbook
        var addImage:UIImage = UIImage(named: norArr[1])!
        var addSelmage:UIImage = UIImage(named: selArr[1])!
        addImage = addImage.withRenderingMode(UIImageRenderingMode.alwaysOriginal);
        addSelmage = addSelmage.withRenderingMode(UIImageRenderingMode.alwaysOriginal);
        addressVC.tabBarItem.image = addImage
        addressVC.tabBarItem.selectedImage = addSelmage
        // application
        var appImage:UIImage = UIImage(named: norArr[2])!
        var appSelImage:UIImage = UIImage(named: selArr[2])!
        appImage = appImage.withRenderingMode(UIImageRenderingMode.alwaysOriginal);
        appSelImage = appSelImage.withRenderingMode(UIImageRenderingMode.alwaysOriginal);
        applicaVC.tabBarItem.image = appImage
        applicaVC.tabBarItem.selectedImage = appSelImage
        // mine
        var homeImage:UIImage = UIImage(named: norArr[3])!
        var homeSelImage:UIImage = UIImage(named: selArr[3])!
        homeImage = homeImage.withRenderingMode(UIImageRenderingMode.alwaysOriginal);
        homeSelImage = homeSelImage.withRenderingMode(UIImageRenderingMode.alwaysOriginal);
        hompageVC.tabBarItem.image = homeImage
        hompageVC.tabBarItem.selectedImage = homeSelImage
        
        // default color
        let norDic = NSMutableDictionary()
        norDic[NSAttributedStringKey.foregroundColor] = UIColor.hexStringToColor(hexString: itemTitleNorColor)
                
        self.tabBar.clipsToBounds = true
        
        // ViewController
        indexVC.tabBarItem.setTitleTextAttributes(selDic as? [NSAttributedStringKey : Any], for: .selected)
        addressVC.tabBarItem.setTitleTextAttributes(norDic as? [NSAttributedStringKey : Any], for: .normal)
        applicaVC.tabBarItem.setTitleTextAttributes(norDic as? [NSAttributedStringKey : Any], for: .normal)
        hompageVC.tabBarItem.setTitleTextAttributes(norDic as? [NSAttributedStringKey : Any], for: .normal)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // selected colort
        selDic[NSAttributedStringKey.foregroundColor] = UIColor.hexStringToColor(hexString: itemTitleSelColor)
        selDic[NSAttributedStringKey.font] = UIFont.systemFont(ofSize: 11.0)
        item.setTitleTextAttributes(selDic as? [NSAttributedStringKey : Any] , for: .selected)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    //  In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
