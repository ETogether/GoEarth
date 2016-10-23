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
        cv.showsVerticalScrollIndicator = false
        cv.registerNib(UINib.init(nibName: "CityCell", bundle: nil), forCellWithReuseIdentifier: "CityCell")
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = WHITECOLOR
        
        self.view.addSubview(cv)
        self.view.sendSubviewToBack(cv)
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        createSeachBar()
        self.readRecommendplaces()
        //由于版本变动，数据热门数据无法得到只能本地加载
//        self.loadData()
    }
    /**创建搜索条-样式*/
    func createSeachBar(){
        let btn = UIButton.init(frame: CGRectMake(0, 0, SCREEN_W * 0.64, 35))
        
        btn.backgroundColor = UIColor.init(white: 1, alpha: 0.65)
        btn.setTitle("查找国家", forState: .Normal)
        btn.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        btn.titleLabel!.font = UIFont.systemFontOfSize(18)
        btn.addTarget(self, action: #selector(self.checkCountryOrCity), forControlEvents: .TouchUpInside)
        btn.layer.cornerRadius = btn.mj_h / 2
        btn.clipsToBounds = true
        self.navigationItem.titleView = btn
        
        //按钮字体所需要的宽度 搜索图片的宽
        let fontW = widthFor(strLength: btn.currentTitle!, height: 30, font: 15)
        let imageW:CGFloat = 24
        //添加搜索图片
        let image = UIImageView.init(frame: CGRectMake((btn.mj_w - fontW ) / 2 - imageW - 8, 0, imageW, imageW))
        image.center.y = btn.center.y
        //设置按钮title(默认为居中)的内容偏移，使整个内容都属于居中
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, (imageW + 8) / 2, 0, 0)
        image.image = UIImage.init(named: "search")
        btn.addSubview(image)
        
        
    }
    func checkCountryOrCity(){
        let svc = SearchContryOrCityController()
        svc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(svc, animated: true)
    }
    
    func readRecommendplaces(){
        let path = NSBundle.mainBundle().pathForResource("recommendplaces", ofType: "json")
        let data = NSData.init(contentsOfFile: path!)
        let rootDic = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
        let arr = rootDic["recommendplaces"] as! [AnyObject]
        //一般使用方式
//        for city in arr{
//            let model = HotCityModel()
//            model.setValuesForKeysWithDictionary(city as! [String: AnyObject])
//            self.cityArr.addObject(model)
//        }
//        self.collectionView.reloadData()
        //这是JSONModel(第三方)解析数据
        if arr.count > 0{
            self.cityArr = HotCityModel.arrayOfModelsFromDictionaries(arr)
            self.collectionView.reloadData()
        }
    }
    
    
    func loadData(){
        HDManager.startLoading()
        HotCityModel.requestHotCityData { (countryArr, hotCityArr, err) in
            if err == nil{
                self.cityArr.addObjectsFromArray(hotCityArr!)
                self.collectionView.reloadData()
            }else{
                print(err)
                //发生网络错误时弹出警告框
                AlertTwoSeconds(self, title: "网络连接请求失败！")
            }
        }
        HDManager.stopLoading()
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = hexColor(hexStr: "04f0a1")
    }
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = WHITECOLOR
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
        let width = SCREEN_W / 2 - 12
        let height = 260 * width / 195
        return CGSizeMake(width, height)
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let city = CityVC.init()
        let model = cityArr[indexPath.item] as! HotCityModel
        city.placeId = model.id

        city.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(city, animated: true)
        
    }
}
