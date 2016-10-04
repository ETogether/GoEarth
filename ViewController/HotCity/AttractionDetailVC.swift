//
//  AttractionDetailVC.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/28.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class AttractionDetailVC: NavBaseVC, UIScrollViewDelegate {
    //返回按钮
    var back: UIButton!
    
    var model: AttractionModel!
    var module = ""
    
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

        self.loadData()
    }
    
    func loadData(){
        HDManager.startLoading()
        AttractionItemModel.requestAttractionItemData(model.countryId, recordId: model.id, module: module) { (array, err) in
            if err == nil{
                self.itemModel = array!.last as! AttractionItemModel
                
                AttractionItemModel.requestAttractionTagsData(self.model.id, module: self.module) { (tagsArr, err) in
                    if err == nil{
                       // self.tagsArr = NSMutableArray()
                        self.tagsArr.addObjectsFromArray(tagsArr!)
                        
                        if self.itemModel != nil && self.tagsArr.count > 0{
                            self.DetailView.dimensionView.reloadData()
                        }
                        self.createBackButton()
                    }else{
                        print(err)
                        AlertTwoSeconds(self)
                    }
                }
                
            }else{
                print(err)
                AlertTwoSeconds(self)
            }
        }
        HDManager.stopLoading()
    }
    //MARK: - 返回按钮
    func createBackButton(){
        back = UIButton.init(frame: CGRectMake(15, 32, 20, 20))
        back.setImage(UIImage.init(named: "nav_back"), forState: .Normal)
        back.addTarget(self, action: #selector(self.backButtonAction), forControlEvents: .TouchUpInside)
        self.view.addSubview(back)
        self.view.bringSubviewToFront(back)
    }
    func backButtonAction(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //MARK: -UIScrollView协议方法
    //根据DetailView的滑动 显示/隐藏返回按钮
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        //根据其透明度
        self.back.alpha = 1 - (y - self.DetailView.headerImage.mj_h / 2) / (self.DetailView.headerImage.mj_h / 2 - 44)
        
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
