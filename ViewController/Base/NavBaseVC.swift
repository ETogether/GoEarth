//
//  NavBaseVC.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit
//点击城市八中按钮，推开的下一页都自带一个backButton
class NavBaseVC: GEBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationItem.hidesBackButton = true
        createBackButton(self, action: #selector(self.backButtonClick(_:)))
        self.view.backgroundColor = WHITECOLOR
    }
    
    func backButtonClick(sender: UIBarButtonItem){
        self.navigationController?.popViewControllerAnimated(true)
    }
    

}
