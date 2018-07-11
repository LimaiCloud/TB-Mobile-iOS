//
//  DetailMonitorCell.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/6/26.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit

class DetailMonitorCell: UITableViewCell {

    @IBOutlet weak var timeLab: UILabel!
    @IBOutlet weak var keyLab: UILabel!
    @IBOutlet weak var countLab: UILabel!
    @IBOutlet weak var spliteLab: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
