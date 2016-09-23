//
//  HotCityVC.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/20.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class HotCityVC: GEBaseVC {
    
    var cityArr = NSMutableArray()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets.init(top: 10, left: 7, bottom: 5, right: 7)
        layout.scrollDirection = .Vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let cv = UICollectionView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64 - 49), collectionViewLayout: layout)
        cv.registerNib(UINib.init(nibName: "CityCell", bundle: nil), forCellWithReuseIdentifier: "CityCell")
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = WHITECOLOR
        
        self.view.addSubview(cv)
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.loadData()
    }

    func loadData(){
        HDManager.startLoading()
        HotCityModel.requestHotCityData("countrys") { (countryArr, hotCityArr, err) in
            if err == nil{
                
                self.cityArr.addObjectsFromArray(hotCityArr!)
                self.collectionView.reloadData()
                
            }else{
                print(err)
                //发生网络错误时弹出警告框
                AlertTwoSeconds(self)
            }
        }
        HDManager.stopLoading()
    }

}

extension HotCityVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cityArr.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CityCell", forIndexPath: indexPath) as! CityCell
        cell.customWith(cityArr[indexPath.item] as! HotCityModel)
        
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(195, 260)
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let city = CityVC.init()
        let model = cityArr[indexPath.item] as! HotCityModel
        city.hotCityModel = model

        city.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(city, animated: true)
        
    }
}
