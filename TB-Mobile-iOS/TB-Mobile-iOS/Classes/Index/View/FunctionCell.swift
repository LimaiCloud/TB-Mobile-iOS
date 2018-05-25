//
//  FunctionCell.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/4/20.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit

protocol FunctionCellDelegate {

    func functionCell(_ funcCell: FunctionCell, didSelectItemAt indexPath: IndexPath)
}

class FunctionCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var delegate: FunctionCellDelegate?
    
    // default moduleArray
    fileprivate var moduleArray: [(title: String, introduce: String, bgColor: String)] = [("OA", "办公更轻松", "5092f6"), ("ERP", "物料/财务查看更清晰！", "8e65ea"),("MES", "生产执行更快捷！", "4dcbf6"),("PLM", "流程控制更安全！", "26b980")]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //  Initialization code
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.moduleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FuncCollectionCell", for: indexPath) as! FuncCollectionCell
        cell.titleLab.text = self.moduleArray[indexPath.row].title
        cell.introduceLab.text = self.moduleArray[indexPath.row].introduce
        cell.bgView.backgroundColor = UIColor.hexStringToColor(hexString: self.moduleArray[indexPath.row].bgColor)
        cell.iconImgView.image = UIImage(named: self.moduleArray[indexPath.row].title)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (delegate != nil) {
            delegate?.functionCell(self, didSelectItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (kScreen_W - 60) / 2, height: 75)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
