//
//  CityGuideCell.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class CityGuideCell: UITableViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    var sectionArr: NSMutableArray!
    @IBOutlet weak var titleL: UILabel!
    
    @IBOutlet weak var sectionView: UICollectionView!
    
    
    //点击item发生回调
    var block: ((detailVC: GEBaseVC) -> Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = hexColor(hexStr: "eeeeee")
        self.selectionStyle = .None
        
       sectionView.registerNib(UINib.init(nibName: "SectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SectionViewCell")
        sectionView.delegate = self
        sectionView.dataSource = self
        sectionView.backgroundColor = WHITECOLOR
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - sectionView 协议方法
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionArr.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SectionViewCell", forIndexPath: indexPath) as! SectionViewCell
        cell.titleL.text = (sectionArr[indexPath.item] as! ContentModel).title
        
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = (SCREEN_W - self.titleL.mj_x * 2 - 10 * 2) / 3
        let count = sectionArr.count
        var height:CGFloat = 0
        if count % 3 == 0{
           height = (collectionView.mj_h - 10 - 10 - CGFloat(count / 3 - 1) * 5) / CGFloat(count / 3)
        }else{
           height = (collectionView.mj_h - 10 - 10 - CGFloat(count / 3) * 5) / CGFloat(count / 3 + 1)
        }
        
        
        //let height = collectionView.mj_h - 10 - 10
        return CGSizeMake(width, height)
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cgdVC = CityGuideDetailVC()
        let model = sectionArr[indexPath.item] as! ContentModel
        cgdVC.navigationItem.title = model.title
        cgdVC.content = model.content
        
        block(detailVC: cgdVC)
        
    }
}
