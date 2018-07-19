//
//  AddressViewController.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/4/23.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit

class AddressViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    // save allKeys
    var allKeys = NSMutableArray()
    // save contact
    var addressDic = NSMutableDictionary()
    
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
        self.setNavTitle("通讯录")
        // create right button
        self.setRightTitleOnTargetNav(self, action: #selector(createContact), title: "", image: "添加联系人")
        // index
        self.tableView.sectionIndexColor = UIColor.hexStringToColor(hexString: "808080")
                
    }
    
    // create contact
    @objc func createContact() {
        
    }

    @objc func updateToken(_ notification: Notification) {
        // Network Requests
        self.requestData()
    }
    
    // request data
    func requestData() {
        // show hudmanager
        self.alertManager().showHud(self)
        self.allKeys.removeAllObjects()
        self.addressDic.removeAllObjects()
        
        token = userDefault.object(forKey: "token") as! String

        let addressUrl = contactURL + token
        AppService.shareInstance.request(methodType: .GET, urlString: addressUrl, parameters: nil) { (result, error) in
            if (error == nil) {
                // cancle
                self.alertManager().hideHud(self)
                // success
                let json = JSON(result as Any)
                let stateCode = json["code"]
                // code 1 ---> success
                if (stateCode.intValue == 1) {
                    let infoArr = json["data"].array
                    for dic in infoArr! {
                        // model
                        let model = ContactModel(jsonData: dic)
                        let nameStr = dic["name"].string
                        
                        let captilIndex = self.getFirstLetterFromString(nameStr!)
                        // save all keys
                        if (self.allKeys.count == 0) {
                            self.allKeys.add(captilIndex)
                            // save model
                            let infoArr = NSMutableArray()
                            infoArr.add(model)
                            self.addressDic.setValue(infoArr, forKey: captilIndex)
                        }else {
                            // contain of keys
                            if (self.allKeys.contains(captilIndex)) {
                                let infoArr = self.addressDic.object(forKey: captilIndex) as! NSMutableArray
                                infoArr.add(model)
                            }else {
                                self.allKeys.add(captilIndex)
                                let infoArr = NSMutableArray()
                                infoArr.add(model)
                                self.addressDic.setValue(infoArr, forKey: captilIndex)
                            }
                        }
                    }
                    // Ascending order
                    let arr = self.allKeys.sorted { (obj1, obj2) -> Bool in
                        if ((obj1 as! String) < (obj2 as! String)) {
                            return true
                        }else{
                            return false
                        }
                    }
                    self.allKeys = NSMutableArray(array: arr)
                    // refresh tableView
                    self.tableView.reloadData()
                }
            }else {
                // error
                self.alertManager().hideHud(self)
                self.alertManager().showTips("请求失败", view: self.view)
                print("%@", error!)
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.allKeys.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = self.allKeys[section] as! String
        let infoArr = self.addressDic.object(forKey: key) as! NSMutableArray
        return infoArr.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressBookCell", for: indexPath) as! AddressBookCell

        let key = self.allKeys[indexPath.section] as! String

        let infoArr = self.addressDic.object(forKey: key) as! NSMutableArray
        let model = infoArr[indexPath.row] as! ContactModel
        
        cell.setupUI(model)
        return cell
    }
    
    // right index
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return alphabets
    }

    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        var count = 0
        for header in alphabets {
            if (header == title) {
                return count
            }
            count += 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.allKeys[section] as? String
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect.zero)
        let titleLab = UILabel(frame: CGRect(x: 15, y: 0, width: 30, height: 15))
        titleLab.textColor = UIColor.hexStringToColor(hexString: "3783d2")
        titleLab.text = allKeys[section] as? String
        headerView.addSubview(titleLab)
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func getFirstLetterFromString(_ changeStr: String)-> String {
        let str = NSMutableString.init(string: changeStr)
        
        CFStringTransform(str, nil, kCFStringTransformMandarinLatin, false)
        
        CFStringTransform(str,nil, kCFStringTransformStripDiacritics,false);
        
        let strPinYin = str.capitalized
      
        let index = strPinYin.index(strPinYin.startIndex, offsetBy: 1)
//        strPinYin.index(before: index)
        return strPinYin.substring(to: index)
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
