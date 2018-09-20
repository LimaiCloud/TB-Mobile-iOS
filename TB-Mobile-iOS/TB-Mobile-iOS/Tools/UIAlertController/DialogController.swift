//
//  DialogController.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/9/18.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit

protocol DialogDelegate {
    
    func updateStatus()
}

class DialogController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var typeLab: UILabel!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var spliteLab: UILabel!
    
    // title array
    var moduleArray: [String] = NSArray() as! [String]
    // id array
    var idArray = NSArray()
    // record button indexpath
    var beforeBtn:BtnIndexpath! = nil
    var indexPath: NSIndexPath! = nil
    // is selected button
    var isSelected = false
    // boardsId
    var boardsId = ""
    var cardsId = ""
    // current status
    var currentId = ""
    // BoardsListModel
    var boardModel:BoardsListModel!
    
    // alert
    let manager = HUDManager()
    
    // delegate
    var delegate: DialogDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.customView()
    }
    
    // set up
    func customView() {
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.confirmBtn.backgroundColor = UIColor.hexStringToColor(hexString: "3783d2")
        self.typeLab.textColor = UIColor.hexStringToColor(hexString: "999999")
        self.spliteLab.backgroundColor = UIColor.hexStringToColor(hexString: "dddddd")
        // register cell
        self.registerCell()
        
    }
    
    // register cell
    func registerCell() {
        // register NIB
        let nib = UINib(nibName: "DialogCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DialogCell")
        
    }
    

    // UIButton action
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // confirm
    @IBAction func confirmAction(_ sender: UIButton) {
        if (self.beforeBtn == nil) {
            self.manager.showTips("请选择状态", view: self.view)
        }else {
            // change status
            self.requestData()
        }
    }
    
    // change Status
    // Network Requests
    func requestData() {
        
        // show MBProgressHUD
        self.manager.showHud(self)
        
        httpHeader = "Authorization"
        token = userDefault.object(forKey: "boardsToken") as! String
        
        let manager = WebServices()
        
        let statusId = self.idArray[indexPath.row] as! String
        let apiUrl = apiBoards + boardsId + list + currentId + carsList + boardModel._id!
        let dic = ["title": boardModel.title!, "description": boardModel.description!, "listId": statusId] as [String : AnyObject]
        
        manager.request(methodType: .PUT, urlString: apiUrl, parameters: dic) { (result, error) in
            // hidden MBProgressHUD
            self.manager.hideHud(self)
            
            if (error == nil) {
                let json = JSON(result as Any)
                print("json---------%@", json)
                if (self.delegate != nil) {
                    self.delegate?.updateStatus()
                }
                self.dismiss(animated: true, completion: nil)

            }else{
                print("%@", error!)
                self.manager.showTips("更改失败", view: self.view)
            }
        }
    }
    
    // selectBtn action
    @objc func selectBtnAction(_ sender: BtnIndexpath) {
        sender.setImage(UIImage(named: "选择"), for: .normal)
        // record indexPath
        self.indexPath = sender.btnIndexPath! as NSIndexPath
        
        if ((self.beforeBtn) != nil) {
            if (self.beforeBtn.btnIndexPath.row == sender.btnIndexPath.row) {
                self.isSelected = !self.isSelected;
                if (self.isSelected == true) {
                    sender.setImage(UIImage(named: "未选择"), for: .normal)
                } else {
                    sender.setImage(UIImage(named: "选择"), for: .normal)
                }
            } else {
                self.beforeBtn.setImage(UIImage(named: "未选择"), for: .normal)
                self.isSelected = false;
            }
            
        }
        self.beforeBtn = sender;
    }
    
    // UITableViewDataSource, UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moduleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DialogCell", for: indexPath) as! DialogCell
        if (moduleArray[indexPath.row] == "进行中" || moduleArray[indexPath.row] == "完成" || moduleArray[indexPath.row] == "暂不处理") {
            cell.iconImg.image = UIImage(named: moduleArray[indexPath.row])
        }
        cell.titleLab.text = moduleArray[indexPath.row]
        cell.selectBtn.btnIndexPath = indexPath
        cell.selectBtn.addTarget(self, action: #selector(selectBtnAction(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
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
