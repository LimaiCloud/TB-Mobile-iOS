//
//  DashBoardsController.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/6/15.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit

class DashBoardsController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    // dataSource
    var dataSource =  NSMutableArray()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        
        let exp = userDefault.object(forKey: "exp") as! Double
        let currentTime = DateConvert.currentTimeFormatter()
        if currentTime > exp {
            // token exptime
            UpdateToken.refreshToken()
            NotificationCenter.default.addObserver(self, selector: #selector(updateToken(_:)), name: NSNotification.Name(rawValue: "refreshToken"), object: nil)
        }else {
            // Network Requests
            self.requestData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.customView()
    }
    
    // set up
    func customView() {
        
        // title
        self.setNavTitle("数据看板")
        // register cell
        let nib = UINib(nibName: "DashboardCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DashboardCell")
   
    }
    
    @objc func updateToken(_ notification: Notification) {
        // Network Requests
        self.requestData()
    }
    
    // Network Requests
    func requestData() {
        
        // show MBProgressHUD
        hudManager.showHud(self)
        self.dataSource.removeAllObjects()
        
        rootURL = userDefault.object(forKey: "rootAddress") as! String
        var scope = userDefault.object(forKey: "scopes") as! String
        let customerId = userDefault.object(forKey: "customerId") as! String
        var apiURL = ""
        if (scope == "CUSTOMER_USER") {
            scope = "customer"
            apiURL = rootURL + prefixURL + scope + "/\(customerId)/" + suffixURL
            
        }else if (scope == "TENANT_ADMIN") {
            scope = "tenant"
            apiURL = rootURL + prefixURL + scope + suffixURL
            
        }
//        let apiURL = rootURL + devicesListURL
        
        let manager = WebServices()
        
        manager.request(methodType: .GET, urlString: apiURL, parameters: nil) { (result, error) in
            if (error == nil) {
                // hidden MBProgressHUD
                self.hudManager.hideHud(self)
                
                let json = JSON(result as Any)
                let dataArr = json["data"].array
                for deviceInfo in dataArr! {
                    let model = DeviceModel(jsonData: deviceInfo)
                    // add dataSource
                    self.dataSource.add(model)
                }
                
                print("---------%@", self.dataSource)
                self.tableView.reloadData()
                
            }else {
                self.hudManager.showTips("请求失败", view: self.view)
                print("%@", error!)
            }
        }
    }

    // UITableViewDataSource, UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardCell", for: indexPath) as! DashboardCell
        let model = self.dataSource[indexPath.row] as! DeviceModel
        cell.titleLab.text = model.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailDashBoardController(nibName: "DetailDashBoardController", bundle: nil)
        let model = self.dataSource[indexPath.row] as! DeviceModel
        detailVC.titleStr = model.name!
        detailVC.entityId = model.id.id!
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
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
