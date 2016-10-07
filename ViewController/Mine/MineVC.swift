//
//  MineVC.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/20.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class MineVC: GEBaseVC, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var mineView: UITableView!
    var headImage: UIButton!
    var mineArr = [[String]]()
    
    //保存图片路径
    let path = NSHomeDirectory() + "/Documents/image.plist"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false

        self.loadData()
        self.createUI()
    }

    func createUI(){
        
        headImage = UIButton.init(frame: CGRectMake(0, 0, SCREEN_W, 200))
        
        
        let dic = NSDictionary.init(contentsOfFile: path)
        if dic != nil{
            headImage.setBackgroundImage(UIImage.init(data: (dic!["img"] as? NSData)!), forState: .Normal)
            headImage.setBackgroundImage(UIImage.init(data: (dic!["img"] as? NSData)!), forState: .Highlighted)
        }else{
            let i = arc4random_uniform(4)
            headImage.setBackgroundImage(UIImage.init(named: "headimage_\(i).jpg"), forState: .Normal)
            headImage.setBackgroundImage(UIImage.init(named: "headimage_\(i).jpg"), forState: .Highlighted)
        }
        headImage.addTarget(self, action: #selector(self.headImageAction), forControlEvents: .TouchUpInside)
        
        
        
        mineView = UITableView.init(frame: CGRectMake(0, 0, SCREEN_W, SCREEN_H), style: .Grouped)
        mineView.tableHeaderView = headImage
        mineView.delegate = self
        mineView.dataSource = self
        mineView.registerNib(UINib.init(nibName: "MineCell", bundle: nil), forCellReuseIdentifier: "MineCell")
        mineView.backgroundColor = GRAYCOLOR
        self.view.addSubview(mineView)
        
    }
    func loadData(){
        let path = NSBundle.mainBundle().pathForResource("Mine.plist", ofType: nil)
        let dic = NSDictionary.init(contentsOfFile: path!)!
        mineArr = dic["mines"] as! [[String]]
//        for arr in mines{
//            
//        }
    }
    
    func headImageAction(){
        
        let ipc = UIImagePickerController()
        ipc.delegate = self
        self.presentViewController(ipc, animated: true, completion: nil)
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    

    
    //MARK: -mineView 协议方法
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return mineArr.count
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mineArr[section].count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MineCell", forIndexPath: indexPath) as! MineCell
        let arr = mineArr[indexPath.section]
        let title = arr[indexPath.row]
        cell.icon.image = UIImage.init(named: title)
        
        cell.titleL.text = title
        
        return cell
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    
    //MARK: -图片拾取器 协议方法
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        headImage.setBackgroundImage(image, forState: .Normal)
        let data = UIImagePNGRepresentation(image)!
        
        let dic = NSDictionary.init(dictionary: ["img":data])
        
        
        let tag = dic.writeToFile(path, atomically: true)
        if tag {
            AlertTwoSeconds(self, title: "保存成功！")
        }else{
            AlertTwoSeconds(self, title: "保存失败！")
        }
    
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
