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
        
        // request data
        self .requestData()
    }
    
    // Network Requests
    func requestData() {
        
        // show MBProgressHUD
        hudManager.showHud(self)
        
        rootURL = userDefault.object(forKey: "rootAddress") as! String
        let apiURL = rootURL + dataURL
        
        let manager = WebServices()
        
        manager.request(methodType: .GET, urlString: apiURL, parameters: nil) { (result, error) in
            if (error == nil) {
                // hidden MBProgressHUD
                self.hudManager.hideHud(self)
                
                let json = JSON(result as Any)
                let dataArr = json["data"].array!
                for infoDic in dataArr {
                    let model = DeviceModel(jsonData: infoDic)
                    self.dataSource.add(model)
                }
                self.tableView.reloadData()
                print(json)
                
            }else {
                print("error----------", error!)
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
        cell.titleLab.text = model.title
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
