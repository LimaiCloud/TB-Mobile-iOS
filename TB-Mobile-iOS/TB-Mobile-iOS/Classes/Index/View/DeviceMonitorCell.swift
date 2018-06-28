//
//  DeviceMonitorCell.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/5/11.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit

class DeviceMonitorCell: UITableViewCell {

    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var userIDLab: UILabel!
    @IBOutlet weak var typeLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userIcon.image = UIImage(named: "defaultMachine")
        titleLab.textColor = UIColor.hexStringToColor(hexString: "333333")
        userIDLab.textColor = UIColor.hexStringToColor(hexString: "888888")
        typeLab.textColor = UIColor.hexStringToColor(hexString: "3783d2")
        
        
    }

    //  assignment model
    func setupModel(_ model: DeviceModel) {
        titleLab.text = model.name
        userIDLab.text = "租户ID:\(model.tenantId.id!)"
        typeLab.text = model.type
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
