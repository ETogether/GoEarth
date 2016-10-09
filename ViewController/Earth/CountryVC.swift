//
//  CountryVC.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/25.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class CountryVC: GEBaseVC, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var dataArr = NSMutableArray()
    var page = 1
    
    var countryId: String!
    
    lazy var countryView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15)
        layout.scrollDirection = .Vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        
        let con = UICollectionView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64), collectionViewLayout: layout)
        con.pagingEnabled = true
        //cv.showsHorizontalScrollIndicator = false
        con.backgroundColor = hexColor(hexStr: "eeeeee")
        
        con.registerNib(UINib.init(nibName: "CitysCell", bundle: nil), forCellWithReuseIdentifier: "CitysCell")
        con.delegate = self
        con.dataSource = self
        
        
        self.view.addSubview(con)
        return con
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.loadData()
    }
    func loadData(){
       // GET   点击大洲中的国家   page可加载页面 rows的默认值为10
       // http://www.koubeilvxing.com/places?countryId=1&kw=&lang=zh&page=1&rows=12
        HDManager.startLoading()
        let para = NSMutableDictionary.init(dictionary: ["page":String(page), "rows":"12", "countryId":countryId])
        BaseRequest.getWithURL(HOME_URL + "places", para: para) { (data, error) in
            if error == nil{
                let rootDic = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                let placesArr = rootDic["places"] as! [AnyObject]
                if placesArr.count > 0 {
                    dispatch_async(dispatch_get_main_queue(), { 
                        //self.dataArr.addObjectsFromArray(CityModel.arrayOfModelsFromDictionaries(placesArr) as [AnyObject])
                        self.dataArr = CityModel.arrayOfModelsFromDictionaries(placesArr)
                        self.countryView.reloadData()
                    })
                   
                }
                
                
            }else{
                print(error)
                AlertTwoSeconds(self, title: "网络连接请求失败！")
            }
        }
        HDManager.stopLoading()
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: - coutryView 协议方法
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CitysCell", forIndexPath: indexPath) as! CitysCell
        cell.customWith(dataArr[indexPath.item] as! CityModel)
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let w = (SCREEN_W - 40) / 3
        let h = 210 * w / 120
        return CGSizeMake(w, h)
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let city = CityVC.init()
        let model = dataArr[indexPath.item] as! CityModel
        city.cityModel = model
        
        city.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(city, animated: true)
    }
    
    
}
