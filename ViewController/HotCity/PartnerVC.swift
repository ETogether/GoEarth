//
//  PartnerVC.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/22.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class PartnerVC: NavBaseVC, UITableViewDelegate, UITableViewDataSource, PartnerCellDelegate {
    var placeId = ""
    var dataArr = NSMutableArray()
    //默认是收缩的
    var isOpen = false
    
    lazy var tableView: UITableView = {
        
        let tv = UITableView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64))
        tv.registerNib(UINib.init(nibName: "PartnerTBC", bundle: nil), forCellReuseIdentifier: "PartnerCell")
        tv.delegate = self
        tv.dataSource = self
        
        self.view.addSubview(tv)
        return tv
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadData()
        
    }
    func loadData(){
        HDManager.startLoading()
        PartnerModel.requestPartnerData(placeId) { (partnerArr, err) in
            if err == nil{
                self.dataArr.addObjectsFromArray(partnerArr!)
                self.tableView.reloadData()
            }else{
                print(err)
                //发生网络错误时弹出警告框
                AlertTwoSeconds(self, title: "网络连接请求失败！")
            }
            HDManager.stopLoading()
        }
        
        
        
    }
    

    //MARK: - TableView 协议方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PartnerCell", forIndexPath: indexPath) as! PartnerTBC
        cell.delegate = self
        let model = dataArr[indexPath.row] as! PartnerModel
        cell.customWith(model)
        
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        if dataArr.count > 0{
//            let cell = tableView.cellForRowAtIndexPath(indexPath) as! PartnerTBC
//            print(cell.contentL.numberOfLines)
//        }
        
        let model = dataArr[indexPath.row] as! PartnerModel
        let height = heightFor(strLength: model.content, width: SCREEN_W - 83, font: 14) + 2
        //当14号字体三行的时候label的 宽度值为52.多 不能超过三行 超过按三行
        if height > 53 && !isOpen{
            return 53 + 78
        }
        
        return height + 78
    }
    
    //Partner
    func openOrPinch(isOpen: Bool) {
        self.isOpen = isOpen
        self.tableView.reloadData()
    }

}
