//
//  ApplicationViewController.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/4/23.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit

class ApplicationViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    // default moduleArray
    fileprivate var moduleArray: [(title: String, titleColor: String, bgImg: String, iconImg: String)] = [("AR工厂", "ffffff", "蓝色背景", "AR"), ("智能识别", "3783d2", "白色背板", "智能识别选中"),("数据挖掘", "3783d2", "白色背板", "数据挖掘选中"),("智能分析", "3783d2", "白色背板", "智能分析选中")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // title
        self.setNavTitle("应用")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moduleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ApplicationItemCell", for: indexPath) as! ApplicationItemCell
        cell.bgImgView.image = UIImage(named:self.moduleArray[indexPath.row].bgImg)
        cell.iconImgView.image = UIImage(named:self.moduleArray[indexPath.row].iconImg)
        cell.titleLab.text = self.moduleArray[indexPath.row].title
        cell.titleLab.textColor = UIColor.hexStringToColor(hexString: self.moduleArray[indexPath.row].titleColor)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (kScreen_W - 60) / 2, height: 220)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
