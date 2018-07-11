//
//  HomePageController.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/4/23.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit

class HomePageController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    
    // image array
    let imgArr = ["收藏", "提醒", "红包", "设置"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // set up
        self.setup()
    }
    
    func setup() {
      
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        self.tableView.backgroundColor = UIColor.hexStringToColor(hexString: "f7f7f7")
        self.topView.backgroundColor = UIColor.hexStringToColor(hexString: "f7f7f7")

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return imgArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OtherInfoCell", for: indexPath) as! OtherInfoCell
        cell.iconImageView.image = UIImage(named: imgArr[indexPath.row])
        cell.titleLabel.text = imgArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 3) {
            let settingVC = SettingController(nibName: "SettingController", bundle: nil)
            self.navigationController?.pushViewController(settingVC, animated: true)
        }else {
            self.alertManager().showTips("暂无数据", view: self.view)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        return 52;
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
