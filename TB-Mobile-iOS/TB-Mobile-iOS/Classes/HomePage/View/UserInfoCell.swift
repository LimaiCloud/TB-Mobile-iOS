//
//  userInfoCell.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/5/25.
//  Copyright © 2017年 DongMingMing. All rights reserved.
//

import UIKit

class UserInfoCell: UITableViewCell {

    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var userNameLab: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var spliteLabel: UILabel!
    
    // config view
    func setupUI() {
       
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.hexStringToColor(hexString: "f0f5f3")

        // 设置颜色
        self.titleLabel.textColor = UIColor.hexStringToColor(hexString: "868e93")
        self.userNameLab.textColor = UIColor.hexStringToColor(hexString: "383f4c")
        self.emailLabel.textColor = UIColor.hexStringToColor(hexString: "868e93")
        self.spliteLabel.textColor = UIColor.hexStringToColor(hexString: "e9eeec")
        // 消圆角
        self.totalView.layer.cornerRadius = 8
        self.totalView.layer.masksToBounds = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
