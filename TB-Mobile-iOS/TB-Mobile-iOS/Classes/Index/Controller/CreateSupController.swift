//
//  CreateSupController.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/10/9.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit

protocol CreateSupDelegate {
    
    func updateViews()
}

class CreateSupController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, DialogDelegate {

    @IBOutlet weak var tableView: UITableView!
    var cell = CreateSupCell()
    
    var moduleArray: [String] = NSArray() as! [String]
    var boardsId = ""
    // id array
    var idArray = NSArray()
    // statusId
    var statusId = ""
    
    // delegate
    var delegate: CreateSupDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.customView()
    }

    // set up
    func customView() {
        
        // title
        self.setNavTitle("创建督办")
        
        // register cell
        self.registerCell()
      
    }
    
    // register cell
    func registerCell() {
        // register NIB
        let nib = UINib(nibName: "CreateSupCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CreateSupCell")
        
    }
    
    // UITableViewDataSource, UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: "CreateSupCell", for: indexPath) as! CreateSupCell
        cell.titleTF.delegate = self
        cell.descTF.delegate = self
        
        cell.selectBtn.addTarget(self, action: #selector(selectBtnAction(_:)), for: .touchUpInside)
        cell.createBtn.addTarget(self, action: #selector(createBtnAction(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return kScreen_H - 64
    }
    
    // UIButton action
    @objc func selectBtnAction(_ sender: UIButton) {
        let dialogVC = DialogController(nibName: "DialogController", bundle: nil)
        // status title
        dialogVC.moduleArray = self.moduleArray
        dialogVC.isCreate = "createSup"
        dialogVC.idArray = self.idArray
        // delegate
        dialogVC.delegate = self
        
        dialogVC.modalPresentationStyle = UIModalPresentationStyle(rawValue: 6)!
        dialogVC.modalTransitionStyle = UIModalTransitionStyle(rawValue: 2)!
        
        self.present(dialogVC, animated: true, completion: nil)
    }
    
    // create button
    @objc func createBtnAction(_ sender: UIButton) {
        
        self.createSupData()
    }
    
    func createSupData() {
        
        httpHeader = "Authorization"
        token = userDefault.object(forKey: "boardsToken") as! String
        
        let manager = WebServices()
        // show MBProgressHUD
        hudManager.showHud(self)
        
        let uid = userDefault.object(forKey: "userId") as! String

        let apiUrl = apiBoards + boardsId + list + statusId + carsList
        let dic = ["title": cell.titleTF.text!, "description": cell.descTF.text!, "authorId": uid, "swimlaneId": statusId] as [String : AnyObject]
        
        manager.request(methodType: .POST, urlString: apiUrl, parameters: dic) { (result, error) in
            // hidden MBProgressHUD
            self.hudManager.hideHud(self)
            
            if (error == nil) {
                let json = JSON(result as Any)
                print("json--------%@", json)
                if (self.delegate != nil) {
                    self.delegate?.updateViews()
                }
                self.navigationController?.popViewController(animated: true)
            }else{
                print("%@", error!)
                self.hudManager.showTips("请求失败", view: self.view)
            }
        }
    }
    
    // UITextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField.isEqual(cell.titleTF)) {
            cell.titleTF.text = textField.text
        }else if (textField.isEqual(cell.descTF)) {
            cell.descTF.text = textField.text
        }
    }
    
    // DialogDelegate
    func updateStatus(_ selectTitle: String, statusId: String) {
        
        cell.selectBtn.setTitle(selectTitle, for: .normal)
        self.statusId = statusId
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
