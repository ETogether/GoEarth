//
//  AttractionDetailVC.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/28.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit
import CoreData

class AttractionDetailVC: NavBaseVC, UIScrollViewDelegate {
    //导航条  返回按钮
    var navBar: UIView!
    var back: UIButton!
    
    var model: AttractionModel!
    var module = ""
    
    //收藏中的countryId recordId不是model里的了
    var countryId = ""
    var recordId = ""
    
    
    var itemModel: AttractionItemModel?
    var tagsArr = NSMutableArray()

    //MARK: -自订制的Scrollview视图
    lazy var DetailView: AttractionDetailView = {
        let dv = AttractionDetailView.init(frame: self.view.bounds, itemModel: self.itemModel!, tagArr: self.tagsArr)
        dv.module = self.module
        dv.block = { detail in
            
            self.navigationController?.pushViewController(detail, animated: true)
        }
        dv.delegate = self
        dv.showsVerticalScrollIndicator = false
        self.view.addSubview(dv)
        return dv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        if countryId.stringLength() > 0{
            //直接从收藏而中赋值
        }else{
            countryId = model.countryId
            recordId = model.id
        }
        self.loadData()
    }
    
    func loadData(){
        HDManager.startLoading()
        AttractionItemModel.requestAttractionItemData(countryId, recordId: recordId, module: module) { (array, err) in
            if err == nil{
                self.itemModel = array!.last as? AttractionItemModel
                
                AttractionItemModel.requestAttractionTagsData(self.recordId, module: self.module) { (tagsArr, err) in
                    if err == nil{
                       // self.tagsArr = NSMutableArray()
                        self.tagsArr.addObjectsFromArray(tagsArr!)
                        
                        if self.itemModel != nil && self.tagsArr.count > 0{
                            self.DetailView.dimensionView.reloadData()
                        }
                        self.createBackButton()
                    }else{
                        print(err)
                        AlertTwoSeconds(self, title: "网络连接请求失败！")
                    }
                }
                
            }else{
                print(err)
                AlertTwoSeconds(self, title: "网络连接请求失败！")
            }
        }
        HDManager.stopLoading()
    }
    //MARK: - 返回按钮
    func createBackButton(){
        navBar = UIView.init(frame: CGRectMake(0, 0, SCREEN_W, 64))
        navBar.backgroundColor = UIColor.init(white: 1, alpha: 0.5)
        self.view.addSubview(navBar)
        self.view.bringSubviewToFront(navBar)
        back = UIButton.init(frame: CGRectMake(15, 30, 24, 24))
        back.setImage(UIImage.init(named: "nav_back"), forState: .Normal)
        back.addTarget(self, action: #selector(self.backButtonAction), forControlEvents: .TouchUpInside)
        navBar.addSubview(back)
        
        let store = UIButton.init(frame: CGRectMake(SCREEN_W - 15 - 30, 26, 30, 30))
        store.setImage(UIImage.init(named: "nav_storeA"), forState: .Normal)
        store.setImage(UIImage.init(named: "nav_storeB"), forState: .Selected)
        store.addTarget(self, action: #selector(self.storeUpData(_:)), forControlEvents: .TouchUpInside)
        navBar.addSubview(store)
        
        
    }
    func backButtonAction(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    func storeUpData(sender: UIButton){
        sender.selected = !sender.selected
        //创建对象并给其各个字段赋值
        let place = NSEntityDescription.insertNewObjectForEntityForName("Place", inManagedObjectContext: context) as! Place
        if sender.selected {
            place.countryId = model.countryId
            place.recordId = model.id
            place.module = self.module
            place.imageUrl = model.cover
            place.nameCn = model.nameCn
            place.name = model.name
            place.score = model.score
            place.reviews = model.reviewCount
            place.countryName = model.countryName
            place.cityName = model.cityName
            do{
                try context.save()
                AlertTwoSeconds(self, title: "收藏成功！")
            }catch{
                print(error)
                AlertTwoSeconds(self, title: "收藏失败！")
            }
        }else{
            context.deleteObject(place)
            
            do{
                try context.save()
                AlertTwoSeconds(self, title: "取消收藏！")
            }catch{
                print(error)
                AlertTwoSeconds(self, title: "取消收藏失败！")
            }
        }

    }
    
    
    //MARK: -UIScrollView协议方法
    //根据DetailView的滑动 显示/隐藏返回按钮
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        //根据其透明度
        self.navBar.alpha = (y - self.DetailView.headerImage.mj_h / 2) / (self.DetailView.headerImage.mj_h / 2 - 44)
        
//        if scrollView.contentOffset.y >= self.DetailView.headerImage.mj_h - 44{
//            self.back.hidden = true
//        }else{
//            self.back.hidden = false
//        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    
}
