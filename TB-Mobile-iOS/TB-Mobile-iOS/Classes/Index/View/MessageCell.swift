//
//  MessageCell.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/6/19.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var messageImg: UIImageView!
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var contentLab: UILabel!
    @IBOutlet weak var dateLab: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code


    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
