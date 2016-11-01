//
//  EarthVC.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/20.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class EarthVC: GEBaseVC, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, ListViewDelegate, ContinentCellDelegate {
    
    var continentTitles = [String]()
    var continentsArr = NSMutableArray()
    var titleLab: UILabel!//显示title
    
    var listView: ListView!
    
    lazy var contentView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let cv = UICollectionView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64 - 49), collectionViewLayout: layout)
        cv.pagingEnabled = true
        //cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = WHITECOLOR
        
        cv.registerClass(ContinentCell.self, forCellWithReuseIdentifier: "ContinentCell")
        cv.delegate = self
        cv.dataSource = self
        
        self.view.sendSubviewToBack(cv)
        self.view.addSubview(cv)
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.createSeachBar()
        self.loadData()
        
    }
    /**创建搜索条-样式*/
    func createSeachBar(){
        let btn = UIButton.init(frame: CGRectMake(0, 0, SCREEN_W * 0.55, 30))
        
        btn.backgroundColor = WHITECOLOR
        btn.setTitle("查找国家", forState: .Normal)
        btn.setTitleColor(hexColor(hexStr: "ebebeb"), forState: .Normal)
        btn.titleLabel!.font = UIFont.systemFontOfSize(15)
        btn.addTarget(self, action: #selector(self.checkCountryOrCity), forControlEvents: .TouchUpInside)
        btn.layer.cornerRadius = btn.mj_h / 2
        btn.clipsToBounds = true
        self.navigationItem.titleView = btn
        
        //按钮字体所需要的宽度 搜索图片的宽
        let fontW = widthFor(strLength: btn.currentTitle!, height: 30, font: 15)
        let imageW:CGFloat = 20
        //添加搜索图片
        let image = UIImageView.init(frame: CGRectMake((btn.mj_w - fontW ) / 2 - imageW, 0, imageW, imageW))
        image.center.y = btn.center.y
        //设置按钮title(默认为居中)的内容偏移，使整个内容都属于居中
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, (imageW) / 2, 0, 0)
        image.image = UIImage.init(named: "search")
        btn.addSubview(image)
        
        
    }
    func checkCountryOrCity(){
        let svc = SearchContryOrCityController()
        svc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(svc, animated: true)

    }
    func loadData(){
        HDManager.startLoading()
        HotCityModel.requestHotCityData { (countryArr, hotCityArr, err) in
            if err == nil{
                self.continentsArr.addObjectsFromArray(countryArr!)
                self.contentView.reloadData()

                for str in self.continentsArr{
                    self.continentTitles.append((str as! ContinentModel).nameCn)
                }
               self.createUI()

            }else{
                print(err)
                //发生网络错误时弹出警告框
                AlertTwoSeconds(self, title: "网络连接请求失败！")
            }
            HDManager.stopLoading()
        }
        
        
    }


    func createUI(){
        
        titleLab = UILabel.init(frame: CGRectMake(0, (64 - 20 - 23) / 2, 60, 23))
        titleLab.text = continentTitles.first//默认为亚洲
        titleLab.font = UIFont.boldSystemFontOfSize(18)
        titleLab.textAlignment = .Center
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLab)
        
        let w = SCREEN_W * 60 / 414
        listView = ListView.init(frame: CGRectMake(SCREEN_W - w, 100, w, CGFloat(continentTitles.count) * 60), tittles: continentTitles)
        listView.center.y = self.view.center.y
        listView.delegate = self
        self.view.addSubview(listView)
 
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = hexColor(hexStr: "04f0a1")
    }
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = WHITECOLOR
    }
    
    //MARK: - listView 协议方法
    func didSeletedIndexContentOffsetFor(idx: NSInteger) {
        let labW = widthFor(strLength: continentTitles[idx], height: 23, font: 18) + 5
        self.titleLab.mj_w = labW
        self.titleLab.text = continentTitles[idx]
        self.contentView.setContentOffset(CGPointMake(CGFloat(idx) * self.contentView.mj_w, 0), animated: true)
    }
  
    
    //MARK: - continentView 协议方法
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.continentsArr.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ContinentCell", forIndexPath: indexPath) as! ContinentCell
        
        cell.dataArr = (self.continentsArr[indexPath.item] as! ContinentModel).countrys
        cell.delegate = self
        cell.collectionView.reloadData()
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(SCREEN_W, self.contentView.mj_h)
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let x = NSInteger(scrollView.contentOffset.x / scrollView.mj_w)
        self.navigationItem.title = continentTitles[x]
        self.listView.updateIndex(x)
    }
    
    //MARK: - ContinentCell中的collectionView的cell被点击  协议方法
    func pushViewControllerIs(countryVC: GEBaseVC) {
        countryVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(countryVC, animated: true)
    }
    
}
