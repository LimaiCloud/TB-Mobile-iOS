//
//  BoardListController.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/9/17.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit

class BoardListController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

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
        self.setNavTitle("任务督办")
        
        // register cell
        self.registerCell()
        self.requestData()
    }
    
    // register cell
    func registerCell() {
        // register NIB
        let nib = UINib(nibName: "DashboardCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DashboardCell")
        
    }
    
    // Network Requests
    func requestData() {
        
        // show MBProgressHUD
        hudManager.showHud(self)
        
        httpHeader = "Authorization"
        token = userDefault.object(forKey: "boardsToken") as! String
        
        let manager = WebServices()
        
        let uid = userDefault.object(forKey: "userId") as! String
        let apiUrl = apiUsers + uid + boardsList
//        let dic = ["action": "takeOwnership"] as [String : AnyObject]
        
        manager.request(methodType: .GET, urlString: apiUrl, parameters: nil) { (result, error) in
            // hidden MBProgressHUD
            self.hudManager.hideHud(self)
            
            if (error == nil) {
                let json = JSON(result as Any)
                let dataArr = json.array
                for infoDic in dataArr! {
                    let model = BoardsModel(jsonData: infoDic)
                    // add dataSource
                    self.dataSource.add(model)
                }
                self.tableView.reloadData()

            }else{
                print("%@", error!)
                self.hudManager.showTips("请求失败", view: self.view)
            }
        }
    }
    
    // UITableViewDataSource, UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardCell", for: indexPath) as! DashboardCell
        let model = dataSource[indexPath.row] as! BoardsModel
        cell.titleLab.text = model.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Supervision
        let superVC = SupervisionController(nibName: "SupervisionController", bundle: nil)
        let model = dataSource[indexPath.row] as! BoardsModel
        superVC.boardsId = model._id!
        self.navigationController?.pushViewController(superVC, animated: true)
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
