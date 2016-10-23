//
//  SearchBtnView.swift
//  GoEarth
//
//  Created by qianfeng on 16/10/22.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class SearchBtnView: UIView {

    var btnS: UIButton!
    var btnFont:CGFloat!//按钮最大字体大小
    var btnBlock:((module:String) -> Void)!
    
    init(frame: CGRect, titles:[String]) {
        super.init(frame: frame)
        let btnW = self.mj_w / CGFloat(titles.count)
        var i = 0;
        btnFont = 16
        if btnFont > btnW / 2{
            btnFont = btnW / 2
        }
        for title in titles{
            let originX = CGFloat(i) * btnW
            let btn = UIButton.init(frame: CGRectMake(originX, 0, btnW, self.mj_h))
            btn.setTitle(title, forState: .Normal)
            btn.setTitle(title, forState: .Selected)
            btn.setTitleColor(hexColor(hexStr: "808080"), forState: .Normal)
            btn.setTitleColor(hexColor(hexStr: "04f0a1"), forState: .Selected)
            btn.addTarget(self, action: #selector(self.btnClick(_:)), forControlEvents: .TouchUpInside)
            btn.titleLabel?.font = UIFont.systemFontOfSize(btnFont - 3)
            btn.tag = 300 + i;
            if i == 0{
                btn.selected = true
                btn.titleLabel?.font = UIFont.systemFontOfSize(btnFont)
                btnS = btn
            }
            self.addSubview(btn)
            i += 1;
        }
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func btnClick(sender:UIButton){
        if btnS != sender {
            sender.selected = !sender.selected
            UIView.animateWithDuration(0.25, animations: { 
               sender.titleLabel!.font = UIFont.systemFontOfSize(self.btnFont)
            })
            btnS.selected = false
            UIView.animateWithDuration(0.25, animations: { 
                self.btnS.titleLabel!.font = UIFont.systemFontOfSize(self.btnFont - 3)
            })
            btnS = sender
            self.changeModule(sender)
        }
    }
    func changeModule(btn:UIButton) -> Void {
        var module = ""
        switch btn.tag {
        case 301:
            module = "country"
        case 302:
            module = "city"
        case 303:
            module = "attraction"
        case 304:
            module = "restaurant"
        case 305:
            module = "hotel"
        case 306:
            module = "shopping"
        case 307:
            module = "activity"
        default:
            module = ""
        }
        self.btnBlock(module: module)
    }

}
