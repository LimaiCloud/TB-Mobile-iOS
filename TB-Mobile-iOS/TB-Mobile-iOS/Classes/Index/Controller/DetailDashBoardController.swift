//
//  DetailDashBoardController.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/6/28.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit
import Charts
import Starscream

class DetailDashBoardController: BaseViewController, WebSocketDelegate {

    @IBOutlet weak var chartView: LineChartView!
    
    var socket: WebSocket!
    var apiUrl = ""
    var titleStr = ""
    var entityId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.customView()
    }
    
    // set up
    func customView() {
        
        // title
        self.setNavTitle(titleStr)
        
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
        
//        socket.write(string: "{\"tsSubCmds\":[{\"entityType\":\"DEVICE\",\"entityId\":\"\(entityId)\",\"scope\":\"LATEST_TELEMETRY\",\"cmdId\":2}],\"historyCmds\":[],\"attrSubCmds\":[]}")
        socket.write(string: "{\"tsSubCmds\":[{\"entityType\":\"DEVICE\",\"entityId\":\"\(entityId)\",\"keys\":\"count,state\",\"startTs\":1529549464000,\"timeWindow\":604801000,\"interval\":1000,\"limit\":200,\"agg\":\"NONE\",\"cmdId\":1}],\"historyCmds\":[],\"attrSubCmds\":[]}")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("websocket is disconnected: \(String(describing: error?.localizedDescription))")
        // connect
        socket.connect()
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("got some text: \(text)")
//        dataSource.removeAllObjects()
//        infoArray.removeAllObjects()
//
//        let jsonData:Data = text.data(using: .utf8)!
//
//        var jsonDic = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
//        if jsonDic != nil {
//            jsonDic = jsonDic as! NSDictionary
//            let dataDic = (jsonDic as! NSDictionary).object(forKey: "data") as! NSDictionary
//            for (key,value): (Any, Any) in dataDic {
//                print("key: %@ ---- value: %@", key, value)
//                dataSource.add(key)
//                for dataValue in value as! NSArray {
//                    infoArray.add(dataValue)
//                }
//            }
//        }
//        self.tableView.reloadData()
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("got some data: \(data.count)")
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
