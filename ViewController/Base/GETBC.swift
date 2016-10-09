//
//  GETBC.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/20.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class GETBC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.createViewControllers()
        
    }

    func createViewControllers(){
        
        let hotVC = HotCityVC()
        let earthVC = EarthVC()
        let mineVC = MineVC()
        
        let vcArr = [hotVC, earthVC, mineVC]
        let titleArr = ["热门城市", "Earth", "个人中心"]
        //tabbar的viewControllers不能直接添加ViewController
        var ncArr = [UINavigationController]()
        var i = 0
        for vc in vcArr{
            let nc = UINavigationController.init(rootViewController: vc)
            if i == 2{
               // nc.navigationBar.barTintColor = UIColor.init(white: 1, alpha: 0)
            
            }
            //nc.navigationBar.setBackgroundImage(UIImage.init(named: "nav_bg"), forBarMetrics: .Default)
            //图标 及 title（文字）
            let image = UIImage.init(named: titleArr[i] + "A")?.imageWithRenderingMode(.AlwaysOriginal)
            let selImage = UIImage.init(named: titleArr[i] + "B")?.imageWithRenderingMode(.AlwaysOriginal)
            nc.tabBarItem = UITabBarItem.init(title: titleArr[i], image: image, selectedImage: selImage)
            //设置title颜色
            nc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: hexColor(hexStr: "04f0a1")], forState: .Selected)
            nc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: hexColor(hexStrJ: "#bdbbbb")], forState: .Normal)
            ncArr.append(nc)
            i += 1
        }
        self.viewControllers = ncArr
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
