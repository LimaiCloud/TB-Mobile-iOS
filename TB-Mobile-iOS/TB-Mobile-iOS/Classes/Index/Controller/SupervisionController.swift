//
//  SupervisionController.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/9/10.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit

class SupervisionController: BaseViewController, UITableViewDelegate, UITableViewDataSource, SYMoreButtonDelegate, DialogDelegate, CreateSupDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var typeArray: [String] = NSArray() as! [String]
    // SYMoreButtonView
    var buttonView = SYMoreButtonView()
    @IBOutlet weak var topView: UIView!
    
    // title
    var titleName = ""
    
    // status Array
    var dataSource = NSMutableArray()
    // info
    var infoArr = NSMutableArray()
    
    var boardsId = ""
    var index = 0
    
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
        self.setNavTitle(titleName)
        self.typeArray = []
        
        // create right button
        self.setRightTitleOnTargetNav(self, action: #selector(createSupervision), title: "", image: "新建")
        
        // register cell
        self.registerCell()
        
        self.requestData()
        
    }
    
    // register cell
    func registerCell() {
        // register NIB
        let nib = UINib(nibName: "SupervisionCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "SupervisionCell")
        
    }
    
    // create right button
    @objc func createSupervision() {
        // create supversion
        let createVC = CreateSupController(nibName: "CreateSupController", bundle: nil)
        createVC.moduleArray = self.typeArray
        createVC.boardsId = self.boardsId
        createVC.idArray = self.dataSource
        createVC.delegate = self
        self.navigationController?.pushViewController(createVC, animated: true)
    }
    
    // change status button
    @objc func changeStatusAction(_ sender: BtnIndexpath) {
        let dialogVC = DialogController(nibName: "DialogController", bundle: nil)
        // status title
        dialogVC.moduleArray = self.typeArray
        dialogVC.idArray = self.dataSource
        // current boardsId
        dialogVC.boardsId = self.boardsId
        // current statusId
        dialogVC.currentId = self.dataSource[index] as! String
        let model = self.infoArr[sender.btnIndexPath.row] as! BoardsListModel
        // current cardsId
        dialogVC.cardsId = model._id!
        dialogVC.boardModel = model 
        // delegate
        dialogVC.delegate = self
        
        dialogVC.modalPresentationStyle = UIModalPresentationStyle(rawValue: 6)!
        dialogVC.modalTransitionStyle = UIModalTransitionStyle(rawValue: 2)!
        
        self.present(dialogVC, animated: true, completion: nil)
    }
    
    // create SYMoreButtonView
    func createSYMoreButtonView() {
        buttonView = SYMoreButtonView(frame: CGRect(x: 15, y: 0, width: kScreen_W - 30, height: 40))
        self.topView .addSubview(buttonView)
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
    
    // Network Requests
    func requestData() {
        
        // show MBProgressHUD
        hudManager.showHud(self)
        
        httpHeader = "Authorization"
        token = userDefault.object(forKey: "boardsToken") as! String
        
        let manager = WebServices()
        
        let apiUrl = apiBoards + boardsId + list
        
        manager.request(methodType: .GET, urlString: apiUrl, parameters: nil) { (result, error) in
            // hidden MBProgressHUD
            self.hudManager.hideHud(self)
            
            if (error == nil) {
                let json = JSON(result as Any)
                let dataArr = json.array
                for infoDic in dataArr! {
                    let model = BoardsModel(jsonData: infoDic)
                    // add dataSource
                    self.dataSource.add(model._id!)
                    self.typeArray.append(model.title!)
                }
                self.createSYMoreButtonView()
                self.tableView.reloadData()

            }else{
                print("%@", error!)
                self.hudManager.showTips("请求失败", view: self.view)
            }
        }
    }
    
    func boardsListData() {
        // remove all objects
        self.infoArr.removeAllObjects()
        
        httpHeader = "Authorization"
        token = userDefault.object(forKey: "boardsToken") as! String
        
        let manager = WebServices()
        // avoid array index crossing
        if (index < self.dataSource.count) {
            // show MBProgressHUD
            hudManager.showHud(self)
            
            let statusId = self.dataSource.object(at: index) as! String
            let apiUrl = apiBoards + boardsId + list + statusId + carsList
            
            manager.request(methodType: .GET, urlString: apiUrl, parameters: nil) { (result, error) in
                // hidden MBProgressHUD
                self.hudManager.hideHud(self)
                
                if (error == nil) {
                    let json = JSON(result as Any)
                    print("json--------%@", json)
                    let dataArr = json.array
                    for infoDic in dataArr! {
                        let model = BoardsListModel(jsonData: infoDic)
                        // add dataSource
                        self.infoArr.add(model)
                    }
                   
                    // reloadData
                    self.tableView.reloadData()
                }else{
                    print("%@", error!)
                    self.hudManager.showTips("请求失败", view: self.view)
                }
            }
        }else {
            // reloadData
            self.tableView.reloadData()
        }
    }
    
    // UITableViewDataSource, UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.infoArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SupervisionCell", for: indexPath) as! SupervisionCell
        let model = self.infoArr[indexPath.row] as! BoardsListModel
        cell.setUpValues(model)
        
        // button action
        cell.changeStatusBtn.addTarget(self, action: #selector(changeStatusAction(_:)), for: .touchUpInside)
        cell.changeStatusBtn.btnIndexPath = indexPath
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let detailVC = DetailSupervisionController(nibName: "DetailSupervisionController", bundle: nil)
        detailVC.boardsId = self.boardsId
        detailVC.statusId =  self.dataSource.object(at: index) as! String
        let model = self.infoArr[indexPath.row] as! BoardsListModel
        detailVC.cardsId = model._id!
        detailVC.titleName = model.title!
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = self.infoArr[indexPath.row] as! BoardsListModel
        let width = kScreen_W - 125
        let height = StringUtil.getLabelHight(model.title!, fontSize: 16, width: width) + 65
        if (height > 106) {
            return height
        }
        return 106
    }
    
    
    // SYMoreButtonDelegate
    func sy_buttonClick(_ index: Int) {
        self.index = index
        // request listData
        self.boardsListData()
    }
    
    // DialogDelegate
    func updateStatus(_ selectTitle: String, statusId: String) {
        // update data
        self.boardsListData()
    }
    
    // CreateSupDelegate
    func updateViews() {
        // update data
        self.boardsListData()
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
