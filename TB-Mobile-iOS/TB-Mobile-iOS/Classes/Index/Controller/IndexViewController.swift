//
//  IndexViewController.swift
//  TB-Mobile-iOS
//
//
//  Created by dongmingming on 2018/4/20.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit


class IndexViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, FunctionCellDelegate, SDCycleScrollViewDelegate {

    @IBOutlet weak var tableView: UITableView!
        
    @IBOutlet weak var cycleScrollView: SDCycleScrollView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.customView()
    }

    // set up
    func customView() {

        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        let imArr = ["banner-1","banner-2"]
        
        cycleScrollView.localizationImageNamesGroup = imArr
        cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        cycleScrollView.autoScrollTimeInterval = 2

    }
    
    // device monitor action
    @objc func deviceMonitorAction(_ sender: UIButton) {
        let deviceMonitor = DeviceMonitorController(nibName: "DeviceMonitorController", bundle: nil)
        self.navigationController?.pushViewController(deviceMonitor, animated: true)
    }
    
    // UITableViewDataSource, UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BroadcastCell", for: indexPath) as! BroadcastCell
            return cell
        }else if (indexPath.row == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
            // device monitor
            cell.deviceButton.addTarget(self, action: #selector(deviceMonitorAction(_:)), for: .touchUpInside)
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FunctionCell", for: indexPath) as! FunctionCell
            cell.delegate = self 
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return 60
        }else if (indexPath.row == 1) {
            return 120
        }
        return 300
    }
    
    // FunctionCellDelegate
    func functionCell(_ funcCell: FunctionCell, didSelectItemAt indexPath: IndexPath) {
        
    }

    // --- SDCycleScrollViewDelegate
    
    
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
