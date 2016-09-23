//
//  EarthVC.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/20.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class EarthVC: GEBaseVC {
    
    let continentTitles = ["A","B","C","D","E","F"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.createUI()
    }

    func createUI(){
        let btn = UIButton.init(frame: CGRectMake(0, 240, 60, 60))
        btn.backgroundColor = UIColor.yellowColor()
        btn.addTarget(self, action: #selector(self.btn), forControlEvents: .TouchUpInside)
        self.view.addSubview(btn)
        let listView = ListView.init(frame: CGRectMake(0, 100, 60, CGFloat(continentTitles.count) * 60), tittles: continentTitles)
        self.view.addSubview(listView)
        
        
    }
    func btn(){
        print("111111")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
