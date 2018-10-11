//
//  AddressBookCell.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/7/5.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit

class AddressBookCell: UITableViewCell {

    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var rankLab: UILabel!
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var spliteLab: UILabel!
    @IBOutlet weak var showBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.showBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: -5)

        titleLab.textColor = UIColor.hexStringToColor(hexString: "7e7e7f")
        spliteLab.backgroundColor = UIColor.hexStringToColor(hexString: "f2f2f2")

    }
    
    func setupUI(_ model: ContactModel) {
        userName.text = model.name
        rankLab.text = model.title
        titleLab.text = "博萨集团"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
