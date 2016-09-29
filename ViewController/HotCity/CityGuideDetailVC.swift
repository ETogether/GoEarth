//
//  CityGuideDetailVC.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class CityGuideDetailVC: NavBaseVC {

    var content = ""
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let height = heightFor(strLength: self.content, width: SCREEN_W - 20, font: 12) + 30

        
        let scrollView = UIScrollView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64))
        self.view.addSubview(scrollView)
        scrollView.contentSize = CGSizeMake(SCREEN_W, height)
        scrollView.showsVerticalScrollIndicator = false

        let lab = UILabel.init(frame: CGRectMake(10, 0, SCREEN_W - 20, height))
        lab.text = content
        lab.numberOfLines = 0
        lab.font = UIFont.boldSystemFontOfSize(12)
        
        
        scrollView.addSubview(lab)
        
        //createBackButton(self, action: #selector(self.backButtonClick(_:)))
    }

    override func backButtonClick(sender: UIBarButtonItem){
        
        let vcArr = self.navigationController?.viewControllers
        
        let vc1 = vcArr![vcArr!.endIndex.predecessor() - 1]
          if vc1.isMemberOfClass(CityGuideVC){
            let vc = vc1 as! CityGuideVC
            if vc.dataArr.count == 0{
                self.navigationController?.popToViewController(vcArr![vcArr!.endIndex.predecessor() - 2], animated: true)
                
                return
            }
        }
        
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
