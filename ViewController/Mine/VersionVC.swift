//
//  VersionVC.swift
//  GoEarth
//
//  Created by qianfeng on 16/10/7.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class VersionVC: NavBaseVC {

    var versionL: UILabel!
    var appNameL: UILabel!
    var versionL1: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createUI()
       
    }

    func createUI(){
        let path = NSBundle.mainBundle().pathForResource("Info.plist", ofType: nil)
        let infoDic = NSDictionary.init(contentsOfFile: path!)!
        
        versionL = UILabel.init(frame: CGRectMake(0, 0, SCREEN_W, 30))
        versionL.center = CGPointMake(SCREEN_W / 2, SCREEN_H / 2)
        versionL.text = "版本号：" + String(infoDic["CFBundleShortVersionString"]!) + "." + String(infoDic["CFBundleVersion"]!)
        versionL.textAlignment = .Center
        versionL.font = UIFont.systemFontOfSize(16)
        self.view.addSubview(versionL)
        
        appNameL = UILabel.init(frame: CGRectMake(0, versionL.mj_y - 35, SCREEN_W, 30))
        appNameL.center.x = versionL.center.x
        appNameL.text = infoDic["CFBundleName"] as? String
        appNameL.textAlignment = .Center
        appNameL.font = UIFont.boldSystemFontOfSize(24)
        self.view.addSubview(appNameL)
        
        let imageView = UIImageView.init(frame: CGRectMake(0, appNameL.mj_y - 76 - 20, 76, 76))
        imageView.center.x = appNameL.center.x
        imageView.image = UIImage.init(named: "icon")
        self.view.addSubview(imageView)
        
//        versionL1 = UILabel.init(frame: CGRectMake(0, versionL.mj_y + 30 + 5, SCREEN_W, 30))
//        versionL1.center.x = versionL.center.x
//        versionL1.text =
//        versionL1.font = UIFont.italicSystemFontOfSize(16)
//        versionL1.textColor = TEXTGRAYCOLOR
//        self.view.addSubview(versionL1)
//        // app名称
//        NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];  //swift中是CFBundleName
//        // app版本
//        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//        // app build版本
//        NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
        
    }

   

}
