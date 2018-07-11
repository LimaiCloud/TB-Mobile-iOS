//
//  BroadcastCell.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/4/20.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit

class BroadcastCell: UITableViewCell {

    @IBOutlet weak var messageLab: UILabel!
    @IBOutlet weak var timeLab: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //  Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
