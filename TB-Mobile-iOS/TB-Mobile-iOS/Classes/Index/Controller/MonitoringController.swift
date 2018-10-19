//
//  MonitoringController.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/10/16.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit

class MonitoringController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var dataSource = NSMutableArray()
    
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
        self.setNavTitle("视频监控")
        // register cell
        self.registerCell()
        
        // request accessToken
        self.requestAccessToken()
    }
    
    // request accessToken
    func requestAccessToken() {
        self.hudManager.showHud(self)
        let dic = ["appKey": fluoriteKey, "appSecret": fluoriteSecret] as [String : AnyObject]
        
        FormService.shareInstance.request(methodType: .POST, urlString: fluoriteToken, parameters: dic) { (result, error) in
            if (error == nil) {
                // hidden MBProgressHUD
                self.hudManager.hideHud(self)
                
                let json = JSON(result as Any)
                // code 200
                let code = json["code"].string
                if (code == "200") {
                    let dataDic = json["data"].dictionary!

                    // expireTime
                    let expireTime = dataDic["expireTime"]?.double
                    let fluoriteToken = dataDic["accessToken"]?.string!
                    // save rootURL
                    userDefault.set(expireTime, forKey: "expireTime")
                    userDefault.setValue(fluoriteToken, forKey: "accessToken")
                    userDefault.synchronize()
                    
                    // device list
                    self.requestDeviceList()
                }
            }else {
                // false
                self.hudManager.hideHud(self)
                self.hudManager.showTips("请求失败", view: self.view)
                print("%@", error!)
            }
        }
    }
    
    // device list
    func requestDeviceList() {
        // remove allobjects
        self.dataSource.removeAllObjects()
        
        let accessToken = userDefault.object(forKey: "accessToken")
        let dic = ["accessToken": accessToken, "pageStart": 0, "pageSize": 10] as [String : AnyObject]
        FormService.shareInstance.request(methodType: .POST, urlString: fluoriteDeviceList, parameters: dic) { (result, error) in
            if (error == nil) {
                // hidden MBProgressHUD
                self.hudManager.hideHud(self)
                
                let json = JSON(result as Any)
                // code 200
                let code = json["code"].string
                if (code == "200") {
                    let dataArr = json["data"].array!
                    for infoDic in dataArr {
                        let model = FluoriteModel(jsonData: infoDic)
                        self.dataSource.add(model)
                    }
                   self.tableView.reloadData()
                }
            }else {
                // false
                self.hudManager.hideHud(self)
                self.hudManager.showTips("请求失败", view: self.view)
                print("%@", error!)
            }
        }
    }
    
    // register cell
    func registerCell() {
        // register NIB
        let nib = UINib(nibName: "DashboardCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DashboardCell")
        
    }

    // UITableViewDataSource, UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardCell", for: indexPath) as! DashboardCell
        let model = dataSource[indexPath.row] as! FluoriteModel
        cell.titleLab.text = model.deviceName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let startVC = StartMonitorController(nibName: "StartMonitorController", bundle: nil)
        let model = dataSource[indexPath.row] as! FluoriteModel
        startVC.deviceSerial = model.deviceSerial!
        self.navigationController?.pushViewController(startVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
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
