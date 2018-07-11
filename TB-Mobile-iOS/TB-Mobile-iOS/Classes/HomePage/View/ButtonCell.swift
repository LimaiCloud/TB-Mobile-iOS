//
//  ButtonCell.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/7/3.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit

class ButtonCell: UITableViewCell {

    @IBOutlet weak var btn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        btn.backgroundColor = UIColor.hexStringToColor(hexString: "3783d2")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
