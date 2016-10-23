//
//  SearchContryOrCityController.swift
//  GoEarth
//
//  Created by qianfeng on 16/10/22.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class SearchContryOrCityController: GEBaseVC, UITableViewDelegate, UITableViewDataSource {

    lazy var listView: UITableView = {
        let tv = UITableView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64))
        tv.registerClass(UITableViewCell.self, forCellReuseIdentifier: "SearchCell")
        tv.delegate = self
        tv.dataSource = self
        tv.header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.dataArr.removeAllObjects()
            self.page = 1
            self.loadData()
        })
        tv.footer = MJRefreshAutoNormalFooter.init(refreshingBlock: { 
            self.page += 1
            self.loadData()
        })
        
        
        self.view.addSubview(tv)
        return tv
    }()
    
    var dataArr = NSMutableArray()
    
    let btnW:CGFloat = 25
    var searchTF: UITextField!
    
    var page = 1
    var kw = ""
    var module = "country"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.createUI()
        //self.loadData()
    }
    func createUI(){
        self.view.backgroundColor = WHITECOLOR
        //自家义navBar--返回按钮 查找按钮 输入框
        let navBar = UIView.init(frame: CGRectMake(0, 20, SCREEN_W, 44))
        navBar.backgroundColor = UIColor.init(red: 14 / 255.0, green: 234 / 255.0, blue: 24 / 255.0, alpha: 0.1)
        self.view.addSubview(navBar)
        
        let backBtn = UIButton.init(frame: CGRectMake(10, 0, btnW, btnW))
        backBtn.center.y = navBar.center.y - navBar.mj_y
        backBtn.setBackgroundImage(UIImage.init(named: "back"), forState: .Normal)
        backBtn.addTarget(self, action: #selector(self.backBtnClick), forControlEvents: .TouchUpInside)
        navBar.addSubview(backBtn)
        
        let searchBtn = UIButton.init(frame: CGRectMake(SCREEN_W - btnW - 10, 0, btnW, btnW))
        searchBtn.center.y = navBar.center.y - navBar.mj_y
        searchBtn.setBackgroundImage(UIImage.init(named: "search_q"), forState: .Normal)
        searchBtn.addTarget(self, action: #selector(self.searchBtnClick(_:)), forControlEvents: .TouchUpInside)
        navBar.addSubview(searchBtn)
        
        searchTF = UITextField.init(frame: CGRectMake(backBtn.mj_x + backBtn.mj_w + 10 , 0, SCREEN_W - backBtn.mj_w * 2 - 4 * 10, 30))//w:屏幕宽 - 两个btn宽 - 四个间隔宽
        searchTF.center.y = navBar.center.y - navBar.mj_y
        searchTF.placeholder = "请输入要搜索的国家"
        searchTF.becomeFirstResponder()
        navBar.addSubview(searchTF)
    }
    func loadData(){
        HDManager.startLoading()
        SearchModel.requestSearchData(self.kw, page: page, module: module) { (arr, err) in
            if err == nil{
                if arr == nil{
                    AlertTwoSeconds(self, title: "暂无更多数据！")
                }else{
                    self.dataArr.addObjectsFromArray(arr!)
                    self.listView.reloadData()
                }
            }else{
                AlertTwoSeconds(self, title: "网络连接请求失败！")
            }
            self.listView.header.endRefreshing()
            self.listView.footer.endRefreshing()
            HDManager.stopLoading()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func backBtnClick(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    func searchBtnClick(sender:UIButton) -> Void {
        self.view.endEditing(true)
        self.kw = self.searchTF.text!
        self.dataArr.removeAllObjects()
        self.loadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    
    
    
    
    // UITableView 协议方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("SearchCell")
        if cell == nil{
            cell = UITableViewCell.init(style: .Default, reuseIdentifier: "SearchCell")
        }
        let model = self.dataArr[indexPath.row] as! SearchModel
        cell?.textLabel?.text = model.nameCn
        
        return cell!
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let model = dataArr[indexPath.row] as! SearchModel
        let country = CountryVC()
        country.countryId = model.recordId
        self.navigationController?.pushViewController(country, animated: true)
    }
    

}
