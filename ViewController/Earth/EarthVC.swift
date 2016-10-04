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
//    lazy var listView: ListView = {
//        
//        let listView = ListView.init(frame: CGRectMake(0, 100, 60, CGFloat(self.continentTitles.count) * 60), tittles: self.continentTitles)
//        self.view.addSubview(listView)
//        return listView
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
 
        self.loadData()
        
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
                AlertTwoSeconds(self)
            }
        }
        
        HDManager.stopLoading()
    }


    func createUI(){
        self.navigationItem.title = continentTitles.first
        listView = ListView.init(frame: CGRectMake(0, 100, 60, CGFloat(continentTitles.count) * 60), tittles: continentTitles)
        listView.center.y = self.view.center.y
        listView.delegate = self
        self.view.addSubview(listView)
 
    }
    //MARK: - listView 协议方法
    func didSeletedIndexContentOffsetFor(idx: NSInteger) {
        self.navigationItem.title = continentTitles[idx]
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
