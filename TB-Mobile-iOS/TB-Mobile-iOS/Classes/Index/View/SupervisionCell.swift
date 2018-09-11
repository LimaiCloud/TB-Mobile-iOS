//
//  SupervisionCell.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/9/10.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit

class SupervisionCell: UITableViewCell {

    @IBOutlet weak var spliteView: UIView!
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var timeLab: UILabel!
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var statusTF: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        spliteView.backgroundColor = UIColor.hexStringToColor(hexString: "f7f7f7")
        statusTF.isEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
