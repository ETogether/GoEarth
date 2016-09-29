//
//  CommentVC.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/29.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class CommentVC: NavBaseVC {
    
    var recordId = ""
    var page = 1
    
    
    lazy var tableView: UITableView = {
        
        let tv = UITableView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64))
        
        
        self.view.addSubview(tv)
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

       self.loadData()
    }

    func loadData(){
        HDManager.startLoading()
        CommentModel.requestCommentData(recordId, page: page) { (comments, err) in
            
        }
        
        HDManager.stopLoading()
    }
    

    

}
