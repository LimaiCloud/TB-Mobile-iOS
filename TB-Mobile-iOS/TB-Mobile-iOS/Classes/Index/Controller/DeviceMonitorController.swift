//
//  DeviceMonitorController.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/5/11.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit

class DeviceMonitorController: BaseViewController, UITableViewDataSource, UITableViewDelegate, SYMoreButtonDelegate{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    // dataSource
    var dataSource =  NSMutableArray()
    var typeArray: [String] = NSArray() as! [String]
    // SYMoreButtonView
    var buttonView = SYMoreButtonView()
    
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
        self.setNavTitle("设备监控")
        self.typeArray = ["全部"]
        // create right button
        self.setRightTitleOnTargetNav(self, action: #selector(createContact), title: "", image: "search")
        
        // register cell
        self.registerCell()
        
        // Network Requests
        self.requestData()

        
    }
    
    // Network Requests
    func requestData() {
        
        // show MBProgressHUD
        hudManager.showHud(self)
        
        rootURL = userDefault.object(forKey: "rootAddress") as! String
        let apiURL = rootURL + devicesListURL
        
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
                    // add buttonView.titles
//                    self.buttonView.titles.append(model.type!)
                    self.typeArray.append(model.type!)
                }

                print("---------%@", self.dataSource)
                print("=========%@", self.buttonView.titles)
                // create SYMoreButtonView
                self.createSYMoreButtonView()
                
                self.tableView.reloadData()

            }else {
                
            }
        }
    }
    
    
    // create SYMoreButtonView
    func createSYMoreButtonView() {
        buttonView = SYMoreButtonView(frame: CGRect(x: 0, y: 0, width: kScreen_W - 30, height: 40))
        self.topView .addSubview(buttonView)
//        buttonView.titles = ["全部", "注塑机", "冲压机", "注塑机", "冲压机", "注塑机", "冲压机"]
        buttonView.titles = self.typeArray
        buttonView.showline = true
        buttonView.showlineAnimation = true
        buttonView.indexSelected = 0
    
        buttonView.colorNormal = UIColor.hexStringToColor(hexString: "666666");
        buttonView.colorSelected = UIColor.hexStringToColor(hexString: "3783d2")
        buttonView.colorline = UIColor.hexStringToColor(hexString: "3783d2")
        buttonView.delegate = self
        buttonView.reloadData()
       
    }
    
    // register cell
    func registerCell() {
        // register NIB
        let nib = UINib(nibName: "DeviceMonitorCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DeviceMonitorCell")
      
    }
    
    // create right button
    @objc func createContact() {
        
    }

    // UITableViewDataSource, UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceMonitorCell", for: indexPath) as! DeviceMonitorCell
        let model = self.dataSource[indexPath.row] as! DeviceModel
        cell.setupModel(model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailMonitorController(nibName: "DetailMonitorController", bundle: nil)
        let model = self.dataSource[indexPath.row] as! DeviceModel
        detailVC.titleStr = model.name!
        detailVC.entityId = model.id.id!
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 95
    }
    
    // SYMoreButtonDelegate
    func sy_buttonClick(_ index: Int) {
      print("-----%d", index)
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    //  MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
