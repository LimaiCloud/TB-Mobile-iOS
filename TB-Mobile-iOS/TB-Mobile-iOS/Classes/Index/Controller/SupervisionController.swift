//
//  SupervisionController.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/9/10.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit

class SupervisionController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    
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
        self.setNavTitle("任务督办")
        // create right button
        self.setRightTitleOnTargetNav(self, action: #selector(createSupervision), title: "", image: "新建")
        
        // register cell
        self.registerCell()
        
    }
    
    // register cell
    func registerCell() {
        // register NIB
        let nib = UINib(nibName: "SupervisionCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "SupervisionCell")
        
    }
    
    // create right button
    @objc func createSupervision() {
        
    }
    
    // UITableViewDataSource, UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SupervisionCell", for: indexPath) as! SupervisionCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 145
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
