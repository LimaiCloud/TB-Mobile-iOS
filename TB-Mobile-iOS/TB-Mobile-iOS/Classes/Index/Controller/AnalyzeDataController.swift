//
//  AnalyzeDataController.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/7/23.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit
import CoreData
import WebKit
import JavaScriptCore

class AnalyzeDataController: BaseViewController, UIWebViewDelegate {
    
//    var wkWebview: WKWebView!
    
    @IBOutlet weak var webView: UIWebView!
    var myRequest: URLRequest!
//    var webUrl = "\(rootURL)/static/bundle.897b646d204a361b42e8.js"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        
        URLProtocol.registerClass(MyURLProtocol.self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        URLProtocol.unregisterClass(MyURLProtocol.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // title
        self.setNavTitle("数据看板")
        let url = URL(string:rootURL)
        myRequest = URLRequest(url: url!)
        
        // Appdelegate
        let app = UIApplication.shared.delegate as! AppDelegate
      
//        let myProtocol = MyURLProtocol(request: myRequest, cachedResponse: nil, client: nil)
//        let possibleCachedResponse = myProtocol.cachedResponseForCurrentRequest()
        
        let possibleCachedResponse = app.cachedResponseForCurrentRequest(webUrl)
        if possibleCachedResponse == nil {
            if #available(iOS 10.0, *) {
                let context = app.persistentContainer.viewContext
                // no exist
                // create NSManagedObject instance to match the Xcdatamodeld files in the corresponding data model。
                let cachedResponse = NSEntityDescription
                    .insertNewObject(forEntityName: "CachedURLResponse",
                                     into: context) as NSManagedObject
                let htmlPath = Bundle.main.path(forResource:"bundle.897b646d204a361b42e8", ofType:"js")
                
                do{
                    let recData = try Data.init(contentsOf: URL(fileURLWithPath: htmlPath!))
                    
                    cachedResponse.setValue(recData, forKey: "data")
                    cachedResponse.setValue("\(rootURL)/static/bundle.897b646d204a361b42e8.js", forKey: "url")
                    //        cachedResponse.setValue(Date(), forKey: "timestamp")
                    cachedResponse.setValue("application/javascript" ,forKey: "mimeType")
                    cachedResponse.setValue("", forKey: "encoding")
                    
                }
                catch {
                    
                }
                
                // save (Core Data, the Data should be placed in the main thread, or concurrency is easy to collapse)
//                DispatchQueue.main.async(execute: {
//                    do {
//                        try context.save()
//                    } catch {
//                        print("不能保存：\(error)")
//                    }
//                })
            }
        }
       
        self.req()
    }

    func req() {
//        let url = URL(string:rootURL)
//        myRequest = URLRequest(url: url!)
        webView.loadRequest(myRequest)
        
//        let webConfiguration = WKWebViewConfiguration()
//
//        let url = URL(string:rootURL)
//
//        wkWebview = WKWebView(frame: CGRect(x: 0, y: -60, width: kScreen_W, height: kScreen_H + 60), configuration: webConfiguration)
//        wkWebview.navigationDelegate = self
//        wkWebview.uiDelegate = self
//
//        let myRequest = URLRequest(url: url!)
//        wkWebview.load(myRequest)
//        self.view.addSubview(wkWebview)
        
        // show MBProgressHUD
        hudManager.showHud(self)
        
    }
    
    // UIWebViewDelegate
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.hudManager.hideHud(self)
    }
    
    // success
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        // hidden MBProgressHUD
//        self.hudManager.hideHud(self)
//        /// wkWebView调用js方法
//        let js = "document.getElementsById('username-input').value = 'qiyue@limaicloud.com';"
////        let js = "document.getElementById('username-input').value = 'qiyue@limaicloud.com';document.getElementById('password-input').value = '123456';document.getElementsByTagName('button')[0].click();"
////        let js = "document.getElementById('kw').value = 'qiyue@limaicloud.com';"
//        wkWebview.evaluateJavaScript(js) { (response, error) in
//            print("response:", response ?? "No Response", "\n", "error:", error ?? "No Error")
//        }
//
//    }
//
//    // fail
//    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
//
//    }
//
//    // WKUIDelegate
//    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
//        print("=======%@-------%@", prompt, defaultText!)
//    }
//
//    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
//
//    }
//
//    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
//        print("=======%@-------", message)
//
//    }
    
    
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