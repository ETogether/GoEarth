//
//  ContinentCell.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/25.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

/*点击cell通知视图推开新的页面*/
protocol ContinentCellDelegate: class {
    func pushViewControllerIs(countryVC: GEBaseVC)
}


class ContinentCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var dataArr = NSMutableArray()
    weak var delegate: ContinentCellDelegate!
    
    var collectionView: UICollectionView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = WHITECOLOR
        self.contentView.backgroundColor = WHITECOLOR
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 1, bottom: 5, right: 0)
        
        collectionView = UICollectionView.init(frame: self.bounds, collectionViewLayout: layout)
        collectionView.registerNib(UINib.init(nibName: "CountryCell", bundle: nil), forCellWithReuseIdentifier: "CountryCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = WHITECOLOR
        
        self.addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - collectionView 协议方法
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CountryCell", forIndexPath: indexPath) as! CountryCell
        cell.customWith(dataArr[indexPath.item] as! CountrysModel)
        
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let w = (SCREEN_W - 2) / 2
        let h = w * 260 / 206
        return CGSizeMake(w, h)
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let model = dataArr[indexPath.item] as! CountrysModel
        let country = CountryVC()
        country.countryId = model.id
        country.navigationItem.title = model.nameCn
        self.delegate.pushViewControllerIs(country)
    }
}
