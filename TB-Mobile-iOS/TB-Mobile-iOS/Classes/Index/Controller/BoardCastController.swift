//
//  BoardCastController.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/7/20.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit
import WebKit

class BoardCastController: BaseViewController, WKNavigationDelegate {

    var webUrl = ""
    
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
        self.setNavTitle("公告信息")

        let webConfiguration = WKWebViewConfiguration()
        let myURL = URL(string: self.webUrl)
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: kScreen_W, height: kScreen_H - 64), configuration: webConfiguration)
        webView.navigationDelegate = self
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        self.view.addSubview(webView)

        // show MBProgressHUD
        hudManager.showHud(self)
        
    }

    // success
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // hidden MBProgressHUD
        self.hudManager.hideHud(self)
    }
    
    // fail
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
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
