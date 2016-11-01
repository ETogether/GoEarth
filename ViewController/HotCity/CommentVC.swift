//
//  CommentVC.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/29.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class CommentVC: NavBaseVC, UITableViewDelegate, UITableViewDataSource {
    var module = ""
    var recordId = ""
    var page = 1
    var dataArr = NSMutableArray()
    var reviews = [CommentReviewsModel]()
    
    lazy var tableView: UITableView = {
        
        let tv = UITableView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64))
        tv.registerNib(UINib.init(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "CommentCell")
        tv.delegate = self
        tv.dataSource = self
        tv.tableHeaderView = self.countView
        tv.header = MJRefreshNormalHeader.init(refreshingBlock: { 
            self.page = 1
            self.reviews.removeAll()
            self.loadData()
        })
        tv.footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.page += 1
            self.loadData()
        })
        
        self.view.addSubview(tv)
        return tv
    }()
    
    lazy var countView: UIView = {
        let cv = UIView.init(frame: CGRectMake(0, 0, SCREEN_W, 120))
        cv.backgroundColor = UIColor.brownColor()
        cv.layer.cornerRadius = 10
        cv.clipsToBounds = true
        
        let backView = UIView.init(frame: cv.bounds)
        cv.addSubview(backView)
        backView.backgroundColor = UIColor.init(white: 1, alpha: 0.5)
        
        let model = self.dataArr.lastObject as! CommentModel
        let counts = [model.totalReviewCount, model.positiveReviewCount, model.neutralReviewCount, model.negativeReviewCount]
        let titles = ["全部", "好评", "中评", "差评"]
        
        var i = 0
        for ttl in titles{
            let originY = 10 + CGFloat(i) * 25
            
            let totalL = UILabel.init(frame: CGRectMake(15, originY, 40, 20))
            totalL.text = ttl
            totalL.textColor = hexColor(hexStr: "ffffff")
            totalL.font = UIFont.systemFontOfSize(14)
            cv.addSubview(totalL)
            
            let scale = Float(counts[i])! / Float(counts[0])!
            let str = String.init(format: "%0.1f%c", scale * 100, 37)
            let countL = UILabel.init(frame: CGRectMake(SCREEN_W - 130 , originY, 120, 20))
            countL.text = str + " / " + counts[i] + "评论"
            countL.textColor = hexColor(hexStr: "ffffff")
            countL.font = UIFont.systemFontOfSize(12)
            cv.addSubview(countL)
            var width =  SCREEN_W - 55 - 135
            let bgL = UILabel.init(frame: CGRectMake(50 + 5, 0,width, 2))
            bgL.center.y = totalL.center.y
            bgL.backgroundColor = hexColor(hexStr: "a0a0a0")
            cv.addSubview(bgL)
            width = CGFloat(scale) * width
            let fgL = UILabel.init(frame: CGRectMake(50 + 5, 0,width, 2))
            fgL.center.y = totalL.center.y
            cv.addSubview(fgL)
            if i == 0{
                fgL.backgroundColor = hexColor(hexStr: "04f0a1")
            }else if i == 1{
                fgL.backgroundColor = hexColor(hexStr: "06f0c2")
            }else if i == 2{
                fgL.backgroundColor = hexColor(hexStr: "08f0e0")
            }else{
                fgL.backgroundColor = hexColor(hexStr: "ee0000")
            }
            
            i += 1
        }
        
        
        
        
        
        
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
       self.loadData()
    }

    func loadData(){
        HDManager.startLoading()
        CommentModel.requestCommentData(recordId, page: page, module: module) { (comments, err) in
            if err == nil{
                self.dataArr.addObjectsFromArray(comments!)
                let arr = (self.dataArr.lastObject as! CommentModel).reviews
                for model in arr{
                    self.reviews.append(model as! CommentReviewsModel)
                }
                
                self.tableView.reloadData()
                self.tableView.header.endRefreshing()
                self.tableView.footer.endRefreshing()
            }else{
                print(err)
                AlertTwoSeconds(self, title: "网络连接请求失败！")
            }
            HDManager.stopLoading()
        }
        
        
    }
    
    
    //MARK: - tableView 协议方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell", forIndexPath: indexPath) as! CommentCell
        cell.customWith(reviews[indexPath.row])
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let model = reviews[indexPath.row]
        let h = heightFor(strLength: model.comment, width: SCREEN_W - 65, font: 12) + 5
        return h + 43 + 10 + 21 + 10
    }
    

}
