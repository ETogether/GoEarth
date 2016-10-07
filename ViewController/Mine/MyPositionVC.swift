//
//  MyPositionVC.swift
//  GoEarth
//
//  Created by qianfeng on 16/10/7.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class MyPositionVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.createUI()
    }

    func createUI(){
        
        let back = UIButton.init(frame: CGRectMake(15, 32, 20, 20))
        back.setImage(UIImage.init(named: "nav_back"), forState: .Normal)
        back.addTarget(self, action: #selector(self.backButtonAction), forControlEvents: .TouchUpInside)
        self.view.addSubview(back)
        
        
    }
    
    func backButtonAction(){
        self.navigationController?.popViewControllerAnimated(true)
    }

    

}
