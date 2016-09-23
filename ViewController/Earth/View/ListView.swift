//
//  ListView.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/23.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class ListView: UIView {
    
    var btns = [UIButton]()
    var pinchBtn: UIButton!
    var isPinch = false
    var index:Int = 0
    
    var btnW:CGFloat = 0
    var btnH: CGFloat = 0

    init(frame: CGRect, tittles: [String]) {
        super.init(frame: frame)
        //不让其接收事件
//        self.userInteractionEnabled = false
        
        index = tittles.count
        //与视图同宽
        btnW = frame.width
        btnH = 0.8 * btnW
        
        var i = 0
        for title in tittles{
            
            
            let btn = UIButton.init(frame: CGRectMake(0, CGFloat(i) * btnH + 5, btnW, btnH))
            self.addSubview(btn)
            
            btn.setTitle(title, forState: .Normal)
            btn.setTitleColor(WHITECOLOR, forState: .Normal)
            btn.setTitle(title, forState: .Highlighted)
            btn.setTitleColor(WHITECOLOR, forState: .Highlighted)
            btn.backgroundColor = UIColor.orangeColor()
            
            btn.tag = i + 100
            btn.addTarget(self, action: #selector(self.btnClick(_:)), forControlEvents: .TouchUpInside)
            btns.append(btn)
            
            i += 1
        }
        pinchBtn = UIButton.init(frame: CGRectMake(0, CGFloat(i) * btnH, btnW, btnW))
        self.addSubview(pinchBtn)
        
        pinchBtn.setImage(UIImage.init(named: "向上"), forState: .Normal)
        pinchBtn.addTarget(self, action: #selector(self.pinchBtnClick(_:)), forControlEvents: .TouchUpInside)
        
    }
    func btnClick(sender: UIButton){
        print(sender.tag)
    }
    
    func pinchBtnClick(sender: UIButton){
        
        self.isPinch = !self.isPinch
        if self.isPinch {
            UIView.animateWithDuration(0.25 * NSTimeInterval(index), animations: {
                //向上移动
                self.pinchBtn.frame.origin.y = 0
                //父视图也收缩
                self.mj_h = self.pinchBtn.mj_h
                
                }, completion: { (true) in
                self.pinchBtn.setImage(UIImage.init(named: "向下"), forState: .Normal)
            })
            //隐藏显示的按钮
            self.hiddenBtns(btns[index - 1], i: index)
            
        }else{
            
            UIView.animateWithDuration(0.25 * NSTimeInterval(index), animations: {
                self.pinchBtn.frame.origin.y = CGFloat(self.index) * self.btnH
                self.mj_h = self.pinchBtn.mj_h + self.pinchBtn.mj_y
                }, completion: { (true) in
                    self.pinchBtn.setImage(UIImage.init(named: "向上"), forState: .Normal)
            })
            //显示隐藏的按钮
            self.showBtns(btns[0], i: 0)
        }
        
    }
    //隐藏
    func hiddenBtns(btn: UIButton, i: Int){
        var idx = i
        UIView.animateWithDuration(0.25, animations: { 
            btn.mj_h = 0
            }) { (true) in
                idx -= 1
                if idx < 0{
                    return
                }
                self.hiddenBtns(self.btns[idx], i: idx)
        }
       
    }
    //显示
    func showBtns(btn: UIButton, i: Int) -> Void {
        var idx = i
        UIView.animateWithDuration(0.25, animations: {
            btn.mj_h = self.btnH
        }) { (true) in
            idx += 1
            if idx >= self.index{
                return
            }
            self.showBtns(self.btns[idx], i: idx)
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
