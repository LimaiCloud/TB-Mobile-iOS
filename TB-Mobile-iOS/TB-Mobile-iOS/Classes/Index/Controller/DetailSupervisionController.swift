//
//  DetailSupervisionController.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/10/8.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit

class DetailSupervisionController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var dataSource = NSMutableArray()
    
    // title
    var titleName = ""
    
    var boardsId = ""
    var statusId = ""
    var cardsId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.customView()
    }

    // set up
    func customView() {
        
        // title
        self.setNavTitle(titleName)
        
        // register cell
        self.registerCell()
        
        self.requestData()
    }
    
    // register cell
    func registerCell() {
        // register NIB
        let nib = UINib(nibName: "DetailSupCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DetailSupCell")
        
    }
    
    func requestData() {
        // remove all objects
        self.dataSource.removeAllObjects()
        
        httpHeader = "Authorization"
        token = userDefault.object(forKey: "boardsToken") as! String
        
        let manager = WebServices()
        // show MBProgressHUD
        hudManager.showHud(self)
        
        let apiUrl = apiBoards + boardsId + list + statusId + carsList + cardsId
        
        manager.request(methodType: .GET, urlString: apiUrl, parameters: nil) { (result, error) in
            // hidden MBProgressHUD
            self.hudManager.hideHud(self)
            
            if (error == nil) {
                let json = JSON(result as Any)
                print("json--------%@", json)
                let model = SupervisionModel(jsonData: json)
                self.dataSource.add(model)
                
                // reloadData
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailSupCell", for: indexPath) as! DetailSupCell
        let model = self.dataSource[indexPath.row] as! SupervisionModel
        cell.setUpValues(model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return kScreen_H - 64
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
