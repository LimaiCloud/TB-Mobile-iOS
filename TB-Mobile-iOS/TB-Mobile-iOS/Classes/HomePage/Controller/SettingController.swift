//
//  SettingController.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/7/3.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit

class SettingController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let dataSource = ["版本", "插件"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.customView()
    }
    
    // set up
    func customView() {
        
        // title
        self.setNavTitle("设置")
        
        // register cell
        let nib = UINib(nibName: "SettingCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "SettingCell")
        let btnNib = UINib(nibName: "ButtonCell", bundle: nil)
        tableView.register(btnNib, forCellReuseIdentifier: "ButtonCell")
        
        tableView.backgroundColor = UIColor.hexStringToColor(hexString: "f7f7f7")
        self.view.backgroundColor = UIColor.hexStringToColor(hexString: "f7f7f7")

    }

    // UITableViewDataSource, UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return dataSource.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingCell
            
            cell.titleLab.text = self.dataSource[indexPath.row]
            if (indexPath.row == 1) {
                cell.imgIcon.image = UIImage(named: "插件")
            }
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell", for: indexPath) as! ButtonCell
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 1) {
            // logout
            let alertController = UIAlertController(title: "退出登录",
                                                    message: "您确定要退出登录吗", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            
            let okAction = UIAlertAction(title: "确定", style: .default, handler: {
                action in
               
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let loginVC = storyBoard.instantiateViewController(withIdentifier: "LoginViewController")
                userDefault.removeObject(forKey: "username")
                userDefault.removeObject(forKey: "password")
                userDefault.synchronize()
                self.present(loginVC, animated: true, completion: nil)
            })
            
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreen_W, height: 15))
        headerView.backgroundColor = UIColor.hexStringToColor(hexString: "f7f7f7")
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 15
        }
        return 100
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
