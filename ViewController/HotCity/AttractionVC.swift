//
//  AttractionVC.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/27.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class AttractionVC: NavBaseVC, UITableViewDelegate, UITableViewDataSource {
    
    var countryId = ""
    var placeId = ""
    var module = ""
    var page = 1
    
    var dataArr = NSMutableArray()
    
    lazy var attractionView: UITableView = {
        let tv = UITableView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64))
        tv.registerNib(UINib.init(nibName: "AttractionCell", bundle: nil), forCellReuseIdentifier: "AttractionCell")
        tv.delegate = self
        tv.dataSource = self
        self.view.addSubview(tv)
        
        tv.header = MJRefreshHeader.init(refreshingBlock: { 
            self.page = 1
            self.loadData()
        })
        
        tv.footer = MJRefreshAutoNormalFooter.init(refreshingBlock: { 
            self.page += 1
            self.loadData()
        })
        
        
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        
    }

    func loadData(){
        HDManager.startLoading()
        AttractionModel.requestAttractionData(countryId, placeId: placeId, module: module, page: page) { (attractionArr,err) in
            if err == nil{
                self.dataArr.addObjectsFromArray(attractionArr!)
                self.attractionView.reloadData()
                self.attractionView.header.endRefreshing()
                self.attractionView.footer.endRefreshing()
                
            }else{
                print(err)
                AlertTwoSeconds(self, title: "网络连接请求失败！")
            }
            HDManager.stopLoading()
        }
        
    }
        

    //MARK: - UITableView协议方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AttractionCell", forIndexPath: indexPath) as! AttractionCell
        
        cell.customWith(dataArr[indexPath.row] as! AttractionModel)
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        let model = (dataArr[indexPath.row] as! AttractionModel).review
        if model != nil{
            let height = heightFor(strLength: model!.author + model!.comment, width: SCREEN_W - 10 * 2, font: 12) + 20
            return height + 140
        }else{
            return 140
        }
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detail = AttractionDetailVC()
        detail.model = dataArr[indexPath.row] as! AttractionModel
        detail.module = self.module
        self.navigationController?.pushViewController(detail, animated: true)
    }
}
