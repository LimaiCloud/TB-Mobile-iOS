//
//  StartMonitorController.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/10/16.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit
import EZOpenSDKFramework

class StartMonitorController: BaseViewController, EZPlayerDelegate {

    var deviceSerial = ""
    
    var player: EZPlayer = EZPlayer()
    @IBOutlet weak var monitorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // title
        self.setNavTitle("视频监控")

        self.startMonitor()
    }

    func startMonitor() {

        // initial sdk
        EZOpenSDK.initLib(withAppKey: fluoriteKey)
        // accessToken
        let tokens = userDefault.object(forKey: "accessToken") as! String
        EZOpenSDK.setAccessToken(tokens)
        player = EZOpenSDK.createPlayer(withDeviceSerial: deviceSerial, cameraNo: 1)
        player.delegate = self
        player.setPlayerView(monitorView)
        // start
        player.startRealPlay()
        
        self.hudManager.showHud(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        player.stopRealPlay()
    }
    
    // EZPlayerDelegate
    func player(_ player: EZPlayer!, didPlayFailed error: Error!) {
        print("------%@", error)
        self.hudManager.showTips("连接出错", view: self.view)
    }
    
    func player(_ player: EZPlayer!, didReceivedMessage messageCode: Int) {
        self.hudManager.hideHud(self)
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
