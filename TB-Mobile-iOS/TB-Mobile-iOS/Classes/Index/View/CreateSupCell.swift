//
//  CreateSupCell.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/10/9.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit

class CreateSupCell: UITableViewCell {

    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descTF: UITextField!
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var createBtn: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    selectBtn.setTitleColor(UIColor.hexStringToColor(hexString: "3783d2"), for: .normal)
        selectBtn.layer.borderWidth = 1.0
        selectBtn.layer.borderColor = UIColor.hexStringToColor(hexString: "2680b9").cgColor
        selectBtn.layer.masksToBounds = true
        selectBtn.layer.cornerRadius = 3.0
        
        createBtn.backgroundColor = UIColor.hexStringToColor(hexString: "3783d2")
        createBtn.layer.masksToBounds = true
        createBtn.layer.cornerRadius = 15.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
