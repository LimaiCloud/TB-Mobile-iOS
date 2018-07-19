//
//  DetailDashBoardController.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/6/28.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit
import Starscream

class DetailDashBoardController: BaseViewController, WebSocketDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
   
    var socket: WebSocket!
    var apiUrl = ""
    var titleStr = ""
    var entityId = ""
    // dataSource
    var dataSource =  NSMutableArray()
    var infoDic = NSMutableDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.customView()
    }
    
    // set up
    func customView() {
        
        // title
        self.setNavTitle(titleStr)
        
        // register cell
        let nib = UINib(nibName: "DetailDashboardCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DetailDashboardCell")
        
        token = userDefault.object(forKey: "token") as! String
        rootURL = userDefault.object(forKey: "rootAddress") as! String
        let urlArr = rootURL.components(separatedBy: "//")
        
        print("apiUrl ===== %@", websocktURL + token)
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
        
        socket.write(string: "{\"tsSubCmds\":[{\"entityType\":\"DEVICE\",\"entityId\":\"\(entityId)\",\"keys\":\"daliy#数量,daliy#电量\",\"startTs\":1531380286000,\"timeWindow\":604801000,\"interval\":1000,\"limit\":10,\"agg\":\"NONE\",\"cmdId\":1}],\"historyCmds\":[],\"attrSubCmds\":[]}")
//        socket.write(string: "{\"tsSubCmds\":[{\"entityType\":\"DEVICE\",\"entityId\":\"\(entityId)\",\"keys\":\"daliy#数量,daliy#电量\",\"startTs\":1531980431000,\"timeWindow\":61000,\"interval\":1000,\"limit\":500,\"agg\":\"NONE\",\"cmdId\":2}],\"historyCmds\":[{\"entityType\":\"DEVICE\",\"entityId\":\"\(entityId)\",\"keys\":\"电量,电流\",\"startTs\":1531375694006,\"endTs\":1531980494006,\"interval\":1800000,\"limit\":336,\"agg\":\"MAX\",\"cmdId\":1},{\"entityType\":\"DEVICE\",\"entityId\":\"\(entityId)\",\"keys\":\"电量,电流\",\"startTs\":1500444431000,\"endTs\":1531980431000,\"interval\":1000,\"limit\":1,\"agg\":\"NONE\",\"cmdId\":3}],\"attrSubCmds\":[]}")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("websocket is disconnected: \(String(describing: error?.localizedDescription))")
        // connect
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("got some text: \(text)")
        socket.disconnect()
        dataSource.removeAllObjects()
        infoDic.removeAllObjects()
        
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

            for i in 0..<dataSource.count {
                let value = dataDic.object(forKey: dataSource[i])
                infoDic.setValue(value, forKey: dataSource[i] as! String)
            }
        }
        self.tableView.reloadData()
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("got some data: \(data.count)")
        
    }
    
    // UITableViewDataSource, UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
         return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailDashboardCell", for: indexPath) as! DetailDashboardCell
        if (dataSource.count > 0) {
            let countArr = infoDic.object(forKey: dataSource[indexPath.section]) as? NSArray
            cell.setSubViews(countArr!, type: "\(dataSource[indexPath.section])")
        }
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 300
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
