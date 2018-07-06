//
//  WarningController.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/7/5.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit

class WarningController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = NSMutableArray()
     fileprivate var moduleArray: [(title: String, introduce: String, iconImg: String)] = [("立式注塑机报警", "办公更轻松", "device"), ("流程报警", "立式注塑机在20时39分因为机器电流不稳定造成了机器故障。。。", "流程")]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.customView()
    }
    
    // set up
    func customView() {
        
        // title
        self.setNavTitle("警报信息")
       
        // register cell
        self.registerCell()
    }
    
    // register cell
    func registerCell() {
        // register NIB
        let nib = UINib(nibName: "DeviceMonitorCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DeviceMonitorCell")
        
    }
    

    // UITableViewDataSource, UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moduleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceMonitorCell", for: indexPath) as! DeviceMonitorCell
        cell.titleLab.text = moduleArray[indexPath.row].title
        cell.userIDLab.text = moduleArray[indexPath.row].introduce
        cell.userIcon.image = UIImage(named: moduleArray[indexPath.row].iconImg)
        cell.typeLab.text = "07-05"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 95
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
