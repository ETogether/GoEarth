//
//  AttractionDetailVC.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/28.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class AttractionDetailVC: NavBaseVC {
    
    
    var model: AttractionModel!
    
    var itemModel: AttractionItemModel?
    var tagsArr = NSMutableArray()
    
//    lazy var tableView: UITableView = {
//        let tv = UITableView.init(frame: self.view.bounds)
//        tv.tableHeaderView = self.headerView
//        
//        
//        self.view.addSubview(tv)
//        return tv
//    }()
    
    lazy var DetailView: AttractionDetailView = {
        let dv = AttractionDetailView.init(frame: self.view.bounds, itemModel: self.itemModel!, tagArr: self.tagsArr)
        dv.block = { detail in
            self.navigationController?.pushViewController(detail, animated: true)
        }
        self.view.addSubview(dv)
        return dv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.translucent = true

        self.loadData()
    }

    func loadData(){
        HDManager.startLoading()
        AttractionItemModel.requestAttractionItemData(model.countryId, recordId: model.id) { (array, err) in
            if err == nil{
                self.itemModel = array!.last as! AttractionItemModel
                
                AttractionItemModel.requestAttractionTagsData(self.model.id) { (tagsArr, err) in
                    if err == nil{
                       // self.tagsArr = NSMutableArray()
                        self.tagsArr.addObjectsFromArray(tagsArr!)
                        
                        if self.itemModel != nil && self.tagsArr.count > 0{
                            self.DetailView.dimensionView.reloadData()
                        }
                        
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
    
}
