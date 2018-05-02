//
//  BaseViewController.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/4/4.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    // alert
    let Manager = HUDManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        let viewControllers = self.navigationController?.viewControllers
        if ((viewControllers?.count)! > 1) {
            self.navigationItem.hidesBackButton = false
            // left button
            self.setLeftButton()
            // gesture action
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(backSwipGesture))
            gesture.direction = .left
            self.view.addGestureRecognizer(gesture)
            // Turn on screen edge gestures
            self.navigationController?.interactivePopGestureRecognizer?.delegate = nil;
            
        }else {
            self.navigationItem.hidesBackButton = true
        }
         self.navigationController?.navigationBar.barTintColor = UIColor.hexStringToColor(hexString: "ffffff")
    }

    // back action
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    // swip gesture
    @objc func backSwipGesture(_ gesture: UISwipeGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //  navigationItem
    func setNavTitle(_ title: String) {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        titleLabel.text = title
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 18.0)
        self.navigationItem.titleView = titleLabel
    }
    
    // set up left button
    func setLeftButton() {
        // create UIButton
        let backBtn = UIButton(type: .custom)
        backBtn.frame = CGRect(x: 0, y: 0, width: 19, height: 25)
        backBtn.setImage(UIImage(named: "ic_back"), for: .normal)
        backBtn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        // UIBarButtonItem
        let leftItem = UIBarButtonItem(customView: backBtn)
        self.navigationItem.leftBarButtonItem = leftItem
    }
    // right action
    func setRightTitleOnTargetNav(_ controller: Any, action: Selector, title: String, image: String) {
        // create right Button
        let rigthBtn = UIButton(type: .custom)
        rigthBtn.addTarget(controller, action: action, for: .touchUpInside)
        rigthBtn.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        rigthBtn.setImage(UIImage(named:image), for: .normal)
        rigthBtn.setTitle(title, for: .normal)
        rigthBtn.setTitleColor(UIColor.white, for: .normal)
        rigthBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        // UIBarButtonItem
        let rigthItem = UIBarButtonItem(customView: rigthBtn)
        self.navigationItem.rightBarButtonItem = rigthItem
    }
    
    // Prompt box class
    func alertManager()->HUDManager {
        return Manager
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
