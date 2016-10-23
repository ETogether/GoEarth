//
//  MyCollectVC.swift
//  GoEarth
//
//  Created by qianfeng on 16/10/7.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit
import CoreData

class MyCollectVC: NavBaseVC, UITableViewDelegate, UITableViewDataSource {

    var dataArr = [Place]()
    lazy var tableViw: UITableView = {
        let tv = UITableView.init(frame: CGRectMake(0, 64 + 40, SCREEN_W, SCREEN_H - 64 - 40))
        tv.backgroundColor = GRAYCOLOR
        tv.registerNib(UINib.init(nibName: "MyCollectCell", bundle: nil), forCellReuseIdentifier: "MyCollectCell")
        tv.delegate = self
        tv.dataSource = self
        
        self.view.addSubview(tv)
        return tv
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadData()
        self.createUI()
    }

    func loadData(){
        let request = NSFetchRequest.init(entityName: "Place")
        dataArr = try! context.executeFetchRequest(request) as! [Place]
    }
    func createUI(){
        let clearBtn = UIButton.init(frame: CGRectMake(0, 64, SCREEN_W, 40))
        clearBtn.backgroundColor = GRAYCOLOR
        clearBtn.setTitle("取消所有收藏", forState: .Normal)
        clearBtn.setTitleColor(hexColor(hexStr: "a124b0"), forState: .Normal)
        clearBtn.addTarget(self, action: #selector(self.clearCollectData), forControlEvents: .TouchUpInside)
        self.view.addSubview(clearBtn)
        if dataArr.count == 0{
            AlertTwoSeconds(self, title: "您未收藏，请先收藏了！再查看！")
            
        }
    }
    func clearCollectData(){
        let request = NSFetchRequest.init(entityName: "Place")
        let arr = try! context.executeFetchRequest(request) as! [Place]
        for model in arr{
            context.deleteObject(model)
        }

        do{
            try context.save()
            AlertTwoSeconds(self, title: "清除成功！")
        }catch{
            AlertTwoSeconds(self, title: "清除失败！")
        }
        self.dataArr.removeAll()
        self.tableViw.reloadData()
    }
    override func viewWillAppear(animated: Bool) {
        if dataArr.count != 0{
            self.tableViw.reloadData()
        }
    }
    
    //MARK: - tableView协议方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCollectCell", forIndexPath: indexPath) as! MyCollectCell
        cell.customWith(dataArr[indexPath.row])
        
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let model = dataArr[indexPath.row]
        let ch = heightFor(strLength: model.nameCn!, width: SCREEN_W - 8 - 140 - 20, font: 16) + 5
        let nh = heightFor(strLength: model.name!, width: SCREEN_W - 168, font: 16) + 5
        
        return 10 + ch + 5 + nh + 24 + 21 + 5 + 21 + 5
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let model = dataArr[indexPath.row]
        let detail = AttractionDetailVC()
        detail.module = model.module!
        detail.countryId = model.countryId!
        detail.recordId = model.recordId!
        
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    //MARK: -左滑相关的设置
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let model = dataArr.removeAtIndex(indexPath.row)
        context.deleteObject(model)
        do{
           try context.save()
            AlertTwoSeconds(self, title: "删除成功！")
        }catch{
            AlertTwoSeconds(self, title: "删除失败！")
        }
        self.tableViw.reloadData()
    }
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "删除"
    }
    

}
