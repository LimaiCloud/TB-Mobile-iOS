//
//  OtherInfoCell.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/5/25.
//  Copyright © 2017年 DongMingMing. All rights reserved.
//

import UIKit

class OtherInfoCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var spliteLab: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        spliteLab.backgroundColor = UIColor.hexStringToColor(hexString: "eeeeee")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
