//
//  IndexViewController.swift
//  TB-Mobile-iOS
//
//
//  Created by dongmingming on 2018/4/20.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit
import SDCycleScrollView

class IndexViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, FunctionCellDelegate, SDCycleScrollViewDelegate {

    @IBOutlet weak var tableView: UITableView!
        
    @IBOutlet weak var cycleScrollView: SDCycleScrollView!
    var mar = SXMarquee()
    var broadCast = ""
    var link = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
      self.tableView.reloadData()

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.customView()
    }

    
    // set up
    func customView() {

        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        let imArr = ["banner-1","banner-2"]
        
        cycleScrollView.localizationImageNamesGroup = imArr
        cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        cycleScrollView.autoScrollTimeInterval = 2

        self.usersLoginRequest()
        
    }
    
    // Network Requests
    func requestData() {
        
        // show MBProgressHUD
        hudManager.showHud(self)
        
        httpHeader = "X-Authorization"
        token = userDefault.object(forKey: "token") as! String

        let manager = WebServices()
       
        let apiUrl = noticeUrl + broadcastURL
        manager.request(methodType: .GET, urlString: apiUrl, parameters: nil) { (result, error) in
            // hidden MBProgressHUD
            self.hudManager.hideHud(self)

            if (error == nil) {
                let json = JSON(result as Any)
                let dataArr = json.array
                for infoDic in dataArr! {
                    let contentDic = infoDic["title"].dictionary
                    self.broadCast = (contentDic!["rendered"]?.string)!
                    self.link = infoDic["link"].string!
                }
                
                self.tableView.reloadData()
                
            }else {
                print("%@", error!)
                self.hudManager.showTips("请求失败", view: self.view)
            }
        }
    }
    
    /////////////////// supersivion platform  users login ////////////////
    func usersLoginRequest() {
        let dic = ["username": "liuxudong", "password": "asdf@123"] as [String : AnyObject]
        print("------%@", usersLogin)
        AppService.shareInstance.request(methodType: .POST, urlString: usersLogin, parameters: dic) { (result, error) in
            if (error == nil) {
                // hidden MBProgressHUD
                self.hudManager.hideHud(self)

                let json = JSON(result as Any)
                boardsToken = json["token"].string!
                userId = json["id"].string!
                // save rootURL
                userDefault.setValue(boardsToken, forKey: "boardsToken")
                userDefault.setValue(userId, forKey: "userId")
                userDefault.synchronize()
                print("======%@", boardsToken)
            }else {
                // false
                self.hudManager.showTips("请求失败", view: self.view)
                print("%@", error!)
            }
        }
    }
    
    // device monitor action
    @objc func deviceMonitorAction(_ sender: UIButton) {
        let deviceMonitor = DeviceMonitorController(nibName: "DeviceMonitorController", bundle: nil)
        self.navigationController?.pushViewController(deviceMonitor, animated: true)
    }
    
    // dataBoard Action
    @objc func dataBoardAction(_ sender: UIButton) {
//        let dashBoard = DashBoardsController(nibName: "DashBoardsController", bundle: nil)
//        self.navigationController?.pushViewController(dashBoard, animated: true)
        let analyzeVC = AnalyzeDataController(nibName: "AnalyzeDataController", bundle: nil)
        self.navigationController?.pushViewController(analyzeVC, animated: true)
    }
    
    // alarm Action
    @objc func alarmAction(_ sender: UIButton) {
        let alarmVC = WarningController(nibName: "WarningController", bundle: nil)
        self.navigationController?.pushViewController(alarmVC, animated: true)
    }
    
    // message Action
    @objc func messageAction(_ sender: UIButton) {
        let message = MessageViewController(nibName: "MessageViewController", bundle: nil)
        self.navigationController?.pushViewController(message, animated: true)
    }
    
    // UITableViewDataSource, UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "BroadcastCell", for: indexPath) as! BroadcastCell
            
            mar = SXMarquee(frame: CGRect(x: 0, y: 0, width: kScreen_W - 120, height: 30), speed: SXMarqueeSpeedLevel(rawValue: 10)!, msg: self.broadCast)
            mar.changeLabel(UIFont.systemFont(ofSize: 15.0))
            cell.messageView.addSubview(self.mar)
            mar.start()
            mar.isUserInteractionEnabled = false
            return cell
        }else if (indexPath.row == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
            // device monitor
            cell.deviceButton.addTarget(self, action: #selector(deviceMonitorAction(_:)), for: .touchUpInside)
            // dataBoard
            cell.dataButton.addTarget(self, action: #selector(dataBoardAction(_:)), for: .touchUpInside)
            // latest message
            cell.messageButton.addTarget(self, action: #selector(messageAction(_:)), for: .touchUpInside)
            // alarmButton
            cell.alarmButton.addTarget(self, action: #selector(alarmAction(_:)), for: .touchUpInside)

            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FunctionCell", for: indexPath) as! FunctionCell
            cell.delegate = self 
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return 60
        }else if (indexPath.row == 1) {
            return 120
        }
        return 380
    }
    
    // UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            if (self.link != "") {
                let boardVC = BoardCastController(nibName: "BoardCastController", bundle: nil)
                boardVC.webUrl = self.link
                self.navigationController?.pushViewController(boardVC, animated: true)
            }
        }
    }
    
    // FunctionCellDelegate
    func functionCell(_ funcCell: FunctionCell, didSelectItemAt indexPath: IndexPath) {
        
        if (indexPath.item == 0) {
            // BoardListController
            let boardsVC = BoardListController(nibName: "BoardListController", bundle: nil)
            self.navigationController?.pushViewController(boardsVC, animated: true)
        }else if (indexPath.item == 1) {
            // monitoring
            let monitorVC = MonitoringController(nibName: "MonitoringController", bundle: nil)
            self.navigationController?.pushViewController(monitorVC, animated: true)
            
        }
    }

    // --- SDCycleScrollViewDelegate
    
    
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
