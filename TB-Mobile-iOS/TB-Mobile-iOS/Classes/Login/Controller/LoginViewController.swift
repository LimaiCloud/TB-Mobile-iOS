//
//  LoginViewController.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/4/12.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var usersTF: UITextField!
    
    @IBOutlet weak var pwdTF: UITextField!
    @IBOutlet weak var splite1Lab: UILabel!
    @IBOutlet weak var splite2Lab: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    // UIView Constraint
    @IBOutlet weak var viewTopConstrant: NSLayoutConstraint!
    // UIButton top Constraint
    @IBOutlet weak var btnTopConstrant: NSLayoutConstraint!
    // Click on the image to configuration
    @IBOutlet weak var settingImgView: UIImageView!
    // alert
     let manager = HUDManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // setup color
        self.setupColor()
        
       
    }

    // setup color
    func setupColor() {
        splite1Lab.backgroundColor = UIColor.hexStringToColor(hexString: spliteBgColor)
        splite2Lab.backgroundColor = UIColor.hexStringToColor(hexString: spliteBgColor)
        
    
    }
    
    // setting button action
    @IBAction func handleSettingAction(_ sender: UIButton) {
        let alertController = UIAlertController(title: "APP配置",
                                                message: "请输入用您的网址", preferredStyle: .alert)
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "请输入用您的网址"
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        let okAction = UIAlertAction(title: "确定", style: .default, handler: {
            action in
            // require textField value
            rootURL = alertController.textFields![0].text!
            print("IP地址：\(rootURL)")
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // login Button
    @IBAction func loginAction(_ sender: UIButton) {
        if (self.usersTF.text!.isEmpty) {
            // alert: userName can't be empty
            self.manager.showTips("用户名不能为空", view: self.view)
            return
        }
        
        if (self.pwdTF.text!.isEmpty) {
            // alert: passWord can't be empty
            self.manager.showTips("密码不能为空", view: self.view)
            return
        }
        
        if (rootURL.isEmpty) {
            // alert: rootURL can't be empty
            self.manager.showTips("您尚未配置你的网址，点击图片进行配置", view: self.view)
            return
        }
        
        if (!self.usersTF.text!.isEmpty && !self.pwdTF.text!.isEmpty && !rootURL.isEmpty) {
            usersTF.resignFirstResponder()
            pwdTF.resignFirstResponder()
            // show MBProgressHUD
            self.manager.showHud(self)
            // Remove the blank space
            let userStr = self.usersTF.text!.trimmingCharacters(in: .whitespaces)
            let pwdStr  = self.pwdTF.text!.trimmingCharacters(in: .whitespaces)
            // Stitching parameters
            let dic = ["username": userStr, "password": pwdStr] as [String : AnyObject]
            // Determine whether contains http
            if (!rootURL.contains("http://")) {
                rootURL = "http://" + rootURL
            }
            
            let apiURL = rootURL + loginURL
            AppService.shareInstance.request(methodType: .POST, urlString: apiURL, parameters: dic) { (result, error) in
                if (error == nil) {
                    // hidden MBProgressHUD
                    self.manager.hideHud(self)
                    
                    let json = JSON(result as Any)
                    token = json["token"].string!
                    // save rootURL
                    userDefault.set(rootURL, forKey: "rootAddress")
                    userDefault.setValue(token, forKey: "token")
                    
                    userDefault.synchronize()
                    

                    print(json)
                    print("-----%@", json["refreshToken"])
                    
                    self.performSegue(withIdentifier: "rootViewController", sender: nil)

                }else {
                    // false
                    self.manager.hideHud(self)
                    self.manager.showTips("网络连接失败", view: self.view)
                    print("%@", error!)
                }
            }
        }
    }
    
    // UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Below the 5s device
        if (kScreen_H <= 568) {
            UIView.animate(withDuration: 0.3) {
                // update Constant
                self.viewTopConstrant.constant = 18;
                self.btnTopConstrant.constant = 8;
            }
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField .isEqual(usersTF)) {
            usersTF.text = textField.text
        }
        if (textField .isEqual(pwdTF)) {
            pwdTF.text = textField.text
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Below the 5s device
        if (kScreen_H <= 568) {
            UIView.animate(withDuration: 0.3) {
                // recover constant
                self.viewTopConstrant.constant = 40;
                self.btnTopConstrant.constant = 60;
            }
        }
        // resign textfield responder
        usersTF.resignFirstResponder()
        pwdTF.resignFirstResponder()
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
