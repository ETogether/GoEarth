//
//  MineVC.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/20.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit
import CoreData

class MineVC: GEBaseVC, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var mineView: UITableView!
    var headImage: UIButton!
    var mineArr = [[String]]()
    var numLab: UILabel?
    
    //保存图片路径
    let path = NSHomeDirectory() + "/Documents/image.plist"
    
    let fileManager = NSFileManager.defaultManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false

        self.loadData()
        self.createUI()
    }

    func createUI(){
        
        mineView = UITableView.init(frame: CGRectMake(0, 0, SCREEN_W, SCREEN_H), style: .Grouped)
        
        mineView.delegate = self
        mineView.dataSource = self
        mineView.registerNib(UINib.init(nibName: "MineCell", bundle: nil), forCellReuseIdentifier: "MineCell")
        mineView.backgroundColor = GRAYCOLOR
        self.view.addSubview(mineView)
        self.createHeadImage()
    }
    func createHeadImage(){
        headImage = UIButton.init(frame: CGRectMake(0, 0, SCREEN_W, 200))

        let dic = NSDictionary.init(contentsOfFile: path)
        if dic != nil{
            headImage.setBackgroundImage(UIImage.init(data: (dic!["img"] as? NSData)!), forState: .Normal)
           // headImage.setBackgroundImage(UIImage.init(data: (dic!["img"] as? NSData)!), forState: .Highlighted)
        }else{
            let i = arc4random_uniform(4)
            headImage.setBackgroundImage(UIImage.init(named: "headimage_\(i).jpg"), forState: .Normal)
            //headImage.setBackgroundImage(UIImage.init(named: "headimage_\(i).jpg"), forState: .Highlighted)
        }
        headImage.addTarget(self, action: #selector(self.headImageAction), forControlEvents: .TouchUpInside)
        
        mineView.tableHeaderView = headImage
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
        
        self.dataLength()
    }
    func dataLength() -> Void {
        let data1 = NSData.init(contentsOfFile: path)
        if data1 != nil{
            let num1 = data1!.length
            if numLab != nil{
                let num = Double(num1)
                switch num {
                case 0...pow(2, 20) - 1:
                    numLab!.text = String.init(format: "%0.2fKB", Double(num1) / pow(2, 10))
                case pow(2, 20)...pow(2, 30) - 1:
                    numLab!.text = String.init(format: "%0.2fMB", Double(num1) / pow(2, 20))
                default:
                    numLab!.text = String.init(format: "%0.2fGB", Double(num1) / pow(2, 30))
                }
            }
        }else{
            numLab?.text = "0.00KB"
        }
        
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
        
        if indexPath.section == 2{
            numLab = cell.numL
            self.dataLength()
        }
        
        
        
        return cell
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
        switch indexPath.section {
        case 0:
            if indexPath.row == 0{
                let position = MyPositionVC()
                position.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(position, animated: true)
                
            }else{
                let collect = MyCollectVC()
                collect.navigationItem.title = "我的收藏"
                collect.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(collect, animated: true)
            }
        case 1:
            let version = VersionVC()
            version.navigationItem.title = "关于我们"
            version.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(version, animated: true)
        case 2:
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
            do{
                try fileManager.removeItemAtPath(path)
                self.createHeadImage()
            }catch{
                
            }
            self.mineView.reloadData()
            
        default:
            print("超过了")
        }
        
        
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
