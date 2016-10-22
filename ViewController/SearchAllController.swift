//
//  SearchAllController.swift
//  GoEarth
//
//  Created by qianfeng on 16/10/22.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class SearchAllController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let btnW:CGFloat = 20
    var searchTF: UITextField!
    
    var page = 1
    var dataArr = NSMutableArray()
    var module = ""
    
    //headView(按钮)标题
    var headerView:SearchBtnView!
    let btnTitles = ["全部", "国家", "城市", "景点", "餐馆", "酒店", "购物", "活动"]
    
    lazy var listView: UITableView = {
        let tv = UITableView.init(frame: CGRectMake(0, 64 + self.headerView.mj_h, SCREEN_W, SCREEN_H - 64 - self.headerView.mj_h))
        tv.backgroundColor = GRAYCOLOR
        //tv.registerClass(UITableViewCell.self, forCellReuseIdentifier: "SearchCell")
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

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.createUI()
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
        searchTF.borderStyle = .RoundedRect
        searchTF.placeholder = "请输入国家、城市、景点、酒店等"
        searchTF.becomeFirstResponder()
        navBar.addSubview(searchTF)
        
        //searchBtnView---listView的tableHeaderView
        headerView = SearchBtnView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_W / CGFloat(btnTitles.count) * 0.8), titles: btnTitles)
        headerView.hidden = true
        self.view.addSubview(headerView)
    }
    
    func loadData(){
        HDManager.startLoading()
        SearchModel.requestSearchData(searchTF.text!, page: page, module: module) { (arr, err) in
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
            self.headerView.hidden = false
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
        self.dataArr.removeAllObjects()
        self.loadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }

    //MARK:----- UITableView 协议方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("SearchCell")
        if cell == nil{
            cell = UITableViewCell.init(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "SearchCell")
        }
        let model = dataArr[indexPath.row] as! SearchModel
        cell?.imageView?.image = UIImage.init(named: model.module)
        let str = String.init(format: "%@(%@)", model.nameCn, model.parent)
        cell?.textLabel?.attributedText = AttributeText(hexColor(hexStr: "808080"), text: str, rangeStr: "(\(model.parent))", font: 14)
        return cell!
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let model = dataArr[indexPath.row] as! SearchModel
        if model.module == "country"{
            let country = CountryVC()
            country.countryId = model.recordId
            country.navigationItem.title = model.nameCn
            self.navigationController?.pushViewController(country, animated: true)
        }else if model.module == "city"{
            let city = CityVC.init()
            city.placeId = model.recordId
            self.navigationController?.pushViewController(city, animated: true)
        }else{
            let detail = AttractionDetailVC()
            detail.countryId = model.countryId
            detail.recordId = model.recordId
            detail.module = model.module
            self.navigationController?.pushViewController(detail, animated: true)
        } 
    }
}
