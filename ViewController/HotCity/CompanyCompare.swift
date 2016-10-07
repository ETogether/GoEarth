//
//  CompanyCompare.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class CompanyCompare: NavBaseVC, UITableViewDelegate, UITableViewDataSource {
    
    var bigCount: Float = 0.0
    
    var placeId = ""
    var dataArr = NSMutableArray()
    let titleArr = NSMutableArray.init(array: ["热度对比", "车况(好评率)", "服务(好评率)", "价格(好评率)"])
    lazy var companyCompare: UITableView = {
        let rc = UITableView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64), style: UITableViewStyle.Grouped)
        rc.registerNib(UINib.init(nibName: "CompanyCompareCell", bundle: nil), forCellReuseIdentifier: "CompanyCompareCell")
        rc.delegate = self
        rc.dataSource = self
        rc.bounces = false
        rc.separatorColor = WHITECOLOR
        
        self.view.addSubview(rc)
        return rc
    }()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadDate()
    }

    func loadDate(){
        HDManager.startLoading()
        
        CompanyCompareModel.requestCompanyCompareData(placeId) { (arr, err) in
            if err == nil{
                self.dataArr.addObjectsFromArray(arr!)
                self.companyCompare.reloadData()
                
            }else{
                print(err)
                AlertTwoSeconds(self, title: "网络连接请求失败！")
            }
        }
        
        HDManager.stopLoading()
    }
    
    
    //MARK: - UITableView 协议方法
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataArr.count
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr[section].count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CompanyCompareCell", forIndexPath: indexPath) as! CompanyCompareCell

        let models = dataArr[indexPath.section] as! [CompanyCompareModel]
        let model = models[indexPath.row]
        cell.logo.sd_setImageWithURL(NSURL.init(string: model.logo!))
        
        switch indexPath.section {
        case 0:
            let count = Float(model.reviewCount)!
            if bigCount < count{
                bigCount = count
            }
            cell.scale.progress = count / bigCount
            cell.reviewL.text = model.reviewCount + " 评价"
        case 1:
            cell.scale.progress = Float(model.status)!
            cell.reviewL.text = String.init(format: "%0.0f%c", cell.scale.progress * 100, 37)// 37ASCII码值是 %
        case 2:
            cell.scale.progress = Float(model.service)!
            cell.reviewL.text = String.init(format: "%0.0f%c", cell.scale.progress * 100, 37)// 37ASCII码值是 %
        case 3:
            cell.scale.progress = Float(model.price)!
            cell.reviewL.text = String.init(format: "%0.0f%c", cell.scale.progress * 100, 37)// 37ASCII码值是 %
        default:
            break
        }

        return cell
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titleArr[section] as? String
    }


}
