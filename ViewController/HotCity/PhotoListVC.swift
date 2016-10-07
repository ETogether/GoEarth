//
//  PhotoListVC.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/29.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class PhotoListVC: NavBaseVC , UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    var module = ""
    var recordId = ""
    var page = 1
    @IBOutlet weak var PhotoListView: UICollectionView!
    
    var dataArr = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "照片列表"
        self.createUI()
        self.loadData()
    }
    func createUI(){
        PhotoListView.backgroundColor = WHITECOLOR
        PhotoListView.registerNib(UINib.init(nibName: "AttractionPhotoListCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
        PhotoListView.delegate = self
        PhotoListView.dataSource = self

        //上拉刷新 下拉加载
        PhotoListView.header = MJRefreshNormalHeader.init(refreshingBlock: { 
            self.page = 1
            self.dataArr.removeAll()
            self.loadData()
        })
        PhotoListView.footer = MJRefreshAutoNormalFooter.init(refreshingBlock: { 
            self.page += 1
            self.loadData()
        })
        
    }
    
    func loadData(){
        HDManager.startLoading()
    //    GET http://www.koubeilvxing.com/photos?recordId=9&module=attraction&lang=zh&page=1&rows=10
        let para = ["recordId": recordId,"page": String(page), "rows":"10","module":module]
        BaseRequest.getWithURL(HOME_URL + "photos", para: para) { (data, error) in
            if error == nil{
                let rootDic = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                let photos = rootDic["photos"] as! NSArray
                for photo in photos{
                    let dic = photo as! [String: String]
                    self.dataArr.append(dic["url"]!)
                }
                dispatch_async(dispatch_get_main_queue(), { 
                    self.PhotoListView.reloadData()
                })
            }else{
                print(error)
                AlertTwoSeconds(self, title: "网络连接请求失败！")
            }
        }
        
        
        HDManager.stopLoading()
    }
    
    
   //MARK: - UICollectionView 协议方法
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as! AttractionPhotoListCell
        cell.photoView.sd_setImageWithURL(NSURL.init(string: dataArr[indexPath.item]))
        
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake((SCREEN_W - 20) / 2, 137)
    }

    
}
