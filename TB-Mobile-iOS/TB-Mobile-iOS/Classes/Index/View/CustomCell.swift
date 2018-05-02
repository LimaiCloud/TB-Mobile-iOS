//
//  CustomCell.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/4/20.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var deviceButton: UIButton!
    @IBOutlet weak var dataButton: UIButton!
    @IBOutlet weak var alarmButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    
    @IBOutlet weak var splite1Lab: UILabel!
    
    @IBOutlet weak var splite2Lab: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.splite1Lab.backgroundColor = UIColor.hexStringToColor(hexString: "eeeeee")
        self.splite2Lab.backgroundColor = UIColor.hexStringToColor(hexString: "eeeeee")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
