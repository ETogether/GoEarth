//
//  CityGuideVC.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class CityGuideVC: NavBaseVC, UITableViewDelegate, UITableViewDataSource {

    var placeId = ""
    
    //当该页面数据解析不到值，直接推开指南页面(简介)
    var infos = ""
    var name = ""
    
    var dataArr = NSMutableArray()
    
    lazy var tableView: UITableView = {
        let tv = UITableView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64), style: .Plain)
        tv.scrollEnabled = false
        tv.registerNib(UINib.init(nibName: "CityGuideCell", bundle: nil), forCellReuseIdentifier: "CityGuideCell")
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
        CityGuideModel.requestCityGuideData(placeId) { (guideArr, err) in
            if err == nil{
                if guideArr == nil{
                    let cgdVC = CityGuideDetailVC()
                    cgdVC.content = self.infos
                    cgdVC.title = self.name
                    self.navigationController?.pushViewController(cgdVC, animated: true)
                    return
                }
                self.dataArr.addObjectsFromArray(guideArr!)
                self.tableView.reloadData()
            }else{
                print(err)
                //弹窗警告
                AlertTwoSeconds(self, title: "网络连接请求失败！")
            }
            HDManager.stopLoading()
        }
        
    }
    
    
    //MARK: - tableView 协议方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CityGuideCell", forIndexPath: indexPath) as! CityGuideCell
        let model = dataArr[indexPath.row] as! CityGuideModel
        cell.titleL.text = model.title
        cell.sectionArr = model.section
        
        //推开页面
        cell.block = {(vc) in
                self.navigationController?.pushViewController(vc, animated: true)
            }
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let model = dataArr[indexPath.row] as! CityGuideModel
        let count = model.section.count  //count即为item的个数
        /*
         *titleL h:23 top: 10 left: 8 leading: 8
         *contentView(cv) top: 8  bottom: 8  h:?(根据count) 
         *items: 行列间距：(5 10) Insets: 10 / 8
         *item宽 = (SCREEN_W - self.titleL.mj_x * 2 - 10 * 2) / 3 高是宽的三分之一
         */
        if count % 3 == 0{
           return CGFloat(count / 3) * ((SCREEN_W - 8 * 2 - 10 * 2) / 9) + 2 * 10 + CGFloat(count / 3 - 1) * 5 + 23
        }else{
           return CGFloat(count / 3 + 1) * ((SCREEN_W - 8 * 2 - 10 * 2) / 9) + 2 * 10 + CGFloat(count / 3) * 5 + 23
        }
    }
    //组头
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    

}
