//
//  DialogCell.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/9/18.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit

class DialogCell: UITableViewCell {

    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var selectBtn: BtnIndexpath!
    
    @IBOutlet weak var spliteLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.spliteLab.backgroundColor = UIColor.hexStringToColor(hexString: "dddddd")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
