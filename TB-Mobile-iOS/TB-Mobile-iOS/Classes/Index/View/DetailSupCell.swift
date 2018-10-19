//
//  DetailSupCell.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/10/8.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit

class DetailSupCell: UITableViewCell {

    // values
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var desLab: UILabel!
    @IBOutlet weak var dateLab: UILabel!
    
    @IBOutlet weak var titleLab1: UILabel!
    @IBOutlet weak var desLab1: UILabel!
    @IBOutlet weak var dateLab1: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        titleLab1.backgroundColor = UIColor.hexStringToColor(hexString: "79d4ee")
        desLab1.backgroundColor = UIColor.hexStringToColor(hexString: "f7dc72")
        dateLab1.backgroundColor = UIColor.hexStringToColor(hexString: "79b3ee")
        
    }

    func setUpValues(_ model: SupervisionModel) {
        titleLab.text = model.title
        desLab.text = model.description
        let endIndex = model.dateLastActivity!.index(model.dateLastActivity!.startIndex, offsetBy: 10)
        dateLab.text = String(model.dateLastActivity![model.dateLastActivity!.startIndex..<endIndex])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
