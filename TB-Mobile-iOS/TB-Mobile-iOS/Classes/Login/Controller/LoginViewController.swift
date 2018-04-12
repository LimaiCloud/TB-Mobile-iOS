//
//  LoginViewController.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/4/12.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usersTF: UITextField!
    
    @IBOutlet weak var pwdTF: UITextField!
    @IBOutlet weak var splite1Lab: UILabel!
    @IBOutlet weak var splite2Lab: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    // UIView Constraint
    @IBOutlet weak var viewTopConstrant: NSLayoutConstraint!
    // UIButton top Constraint
    @IBOutlet weak var btnTopConstrant: NSLayoutConstraint!
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
        if (!self.usersTF.text!.isEmpty && !self.pwdTF.text!.isEmpty) {
          
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
