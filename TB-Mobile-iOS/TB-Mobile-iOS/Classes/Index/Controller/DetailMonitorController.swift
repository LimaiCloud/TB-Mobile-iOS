//
//  DetailMonitorController.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/6/26.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit
import Starscream

class DetailMonitorController: BaseViewController, WebSocketDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var titleStr = ""
    var apiUrl = ""
    var socket: WebSocket!
    var entityId = ""
    // dataSource
    var dataSource =  NSMutableArray()
    var infoArray = NSMutableArray()
    var infoDic = NSMutableDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.customView()
    }

    // set up
    func customView() {
        
        // title
        self.setNavTitle(titleStr)
       
        // register cell
        let nib = UINib(nibName: "DetailMonitorCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DetailMonitorCell")
        tableView.backgroundColor = UIColor.hexStringToColor(hexString: "f7f7f7")
        self.view.backgroundColor = UIColor.hexStringToColor(hexString: "f7f7f7")
            
        token = userDefault.object(forKey: "token") as! String
        let urlArr = rootURL.components(separatedBy: "//")
        
        apiUrl = "ws://\(urlArr.last!)" + websocktURL + token
        let request = URLRequest(url: URL(string: apiUrl)!)
        socket = WebSocket(request: request)
        socket.delegate = self
        //you could do onPong as well.
        socket.connect()
        
    }
    
    // WebSocketDelegate
    func websocketDidConnect(socket: WebSocketClient) {
        print("websocket is connected")
        token = userDefault.object(forKey: "token") as! String
        
        socket.write(string: "{\"tsSubCmds\":[{\"entityType\":\"DEVICE\",\"entityId\":\"\(entityId)\",\"scope\":\"10\",\"cmdId\":2}],\"historyCmds\":[],\"attrSubCmds\":[]}")
        
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("websocket is disconnected: \(String(describing: error?.localizedDescription))")
      
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("got some text: \(text)")
        dataSource.removeAllObjects()
        infoArray.removeAllObjects()
        socket.disconnect()
        let jsonData:Data = text.data(using: .utf8)!
        
        let jsonDic = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if ((jsonDic as! NSDictionary).object(forKey: "data") is NSNull) {
            print("data is null")
        }else {
            let dataDic = (jsonDic as! NSDictionary).object(forKey: "data") as! NSDictionary
            for (key,value): (Any, Any) in dataDic {
                print("key: %@ ---- value: %@", key, value)
                dataSource.add(key)
            }
            if (dataSource.count > 0) {
                for i in 0..<dataSource.count {
                    let value = dataDic.object(forKey: dataSource[i])
                    let dataArr = NSMutableArray()
                    for dataValue in value as! NSArray {
                        dataArr.add(dataValue)
                    }
                    infoDic.setValue(dataArr, forKey: dataSource[i] as! String)
                }
            } 
        }
        self.tableView.reloadData()
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("got some data: \(data.count)")
    }
    
    // UITableViewDataSource, UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        if (dataSource.count > 0) {
            return dataSource.count
        }
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (dataSource.count > 0) {
            let countArr = infoDic.object(forKey: dataSource[section]) as? NSArray
            return countArr!.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailMonitorCell", for: indexPath) as! DetailMonitorCell
        if (dataSource.count > 0) {
            if (indexPath.row == 0) {
                cell.keyLab.text = dataSource[indexPath.section] as? String
            }
            let countArr = infoDic.object(forKey: dataSource[indexPath.section]) as? NSArray
            let valueArr = countArr![indexPath.row] as? NSArray
            if (valueArr!.count > 0) {
                cell.timeLab.text = DateConvert.changeDateFormatter("\(valueArr![0])")
                cell.countLab.text = valueArr![1]  as? String
            }
        }else {
            cell.timeLab.text = "暂无数据"
            cell.spliteLab.backgroundColor = UIColor.white
        }
        
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreen_W, height: 15))
        headerView.backgroundColor = UIColor.hexStringToColor(hexString: "f7f7f7")
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (dataSource.count > 0) {
            return 60
        }
        return 200
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
