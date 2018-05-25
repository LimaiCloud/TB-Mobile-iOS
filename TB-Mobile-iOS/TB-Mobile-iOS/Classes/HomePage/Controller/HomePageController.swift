//
//  HomePageController.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/4/23.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit

class HomePageController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // 数组
    let imgArr = ["收藏", "提醒", "红包", "设置"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // set up
        self.setup()
    }
    
    func setup() {
         self.setNavTitle("我的")
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 1) {
            return 3
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoCell", for: indexPath) as! UserInfoCell
            // 赋值
            cell.setupUI()
            return cell
        }else if (indexPath.section == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OtherInfoCell", for: indexPath) as! OtherInfoCell
            cell.iconImageView.image = UIImage(named: imgArr[indexPath.row])
            cell.titleLabel.text = imgArr[indexPath.row]
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OtherInfoCell", for: indexPath) as! OtherInfoCell
            cell.iconImageView.image = UIImage(named: imgArr[imgArr.count - 1])
            cell.titleLabel.text = imgArr[imgArr.count - 1]
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.alertManager().showTips("暂无数据", view: self.view)
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView(frame: CGRect(x: 0, y: 0, width: kScreen_W, height: 20))
        headView.backgroundColor = UIColor.clear
        return headView
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 0
        }
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            return 210;
        }
        return 44;
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
