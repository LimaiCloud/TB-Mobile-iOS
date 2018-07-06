//
//  SettingCell.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/7/3.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {

    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var spliteLab: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
