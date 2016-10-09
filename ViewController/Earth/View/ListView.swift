//
//  ListView.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/23.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit
/*声明按钮点击时需要通知其他视图设置偏移量*/
protocol ListViewDelegate: class {
    func didSeletedIndexContentOffsetFor(idx: NSInteger)
}

class ListView: UIView {
    
    var btns = [UIButton]()
    var pinchBtn: UIButton!
    var isPinch = false
    var index:Int = 0
    
    var btnW:CGFloat = 0
    var btnH: CGFloat = 0
    
    //默认selectedIndex
    var selectedIndex = 0
    var trends: NSTimeInterval = 0.25
    
    weak var delegate: ListViewDelegate!

    init(frame: CGRect, tittles: [String]) {
        super.init(frame: frame)
        //不让其接收事件
//        self.userInteractionEnabled = false
        
        index = tittles.count
        //与视图同宽
        btnW = frame.width
        btnH = 0.6 * btnW
        
        var i = 0
        for title in tittles{
            
            
            let btn = UIButton.init(frame: CGRectMake(0, CGFloat(i) * (btnH + 2), btnW, btnH))
            self.addSubview(btn)
            
            btn.setTitle(title, forState: .Normal)
            btn.setTitleColor(hexColor(hexStr: "ffffff"), forState: .Normal)
            btn.setTitle(title, forState: .Highlighted)
            btn.setTitleColor(hexColor(hexStr: "14ea24"), forState: .Highlighted)
            btn.setTitle(title, forState: .Selected)
            btn.setTitleColor(hexColor(hexStr: "14ea24"), forState: .Selected)
            btn.backgroundColor = UIColor.init(white: 0.5, alpha: 0.5)
            if SCREEN_W == 414{
                btn.titleLabel?.font = UIFont.systemFontOfSize(18)
            }else if SCREEN_W == 375{
                btn.titleLabel?.font = UIFont.systemFontOfSize(16)
            }else{  // 320
                btn.titleLabel?.font = UIFont.systemFontOfSize(14)
            }
            
            
            btn.layer.cornerRadius = 5
            btn.layer.borderWidth = 2
            btn.layer.borderColor = WHITECOLOR.CGColor
            
            btn.tag = i + 100
            btn.addTarget(self, action: #selector(self.btnClick(_:)), forControlEvents: .TouchUpInside)
            btns.append(btn)
            if i == 0{
                btn.selected = true
                btn.layer.borderColor = hexColor(hexStr: "14ea24").CGColor
            }
            
            i += 1
        }
        pinchBtn = UIButton.init(frame: CGRectMake(0, CGFloat(i) * (btnH + 2), btnW, btnH))
        self.addSubview(pinchBtn)
        pinchBtn.setImage(UIImage.init(named: "向上"), forState: .Highlighted)
        pinchBtn.setImage(UIImage.init(named: "向上"), forState: .Normal)
        pinchBtn.addTarget(self, action: #selector(self.pinchBtnClick(_:)), forControlEvents: .TouchUpInside)
        
    }
    //按钮的点击事件
    func btnClick(sender: UIButton){
        self.updateIndex(sender.tag - 100)
        //遵守该协议的视图的偏移量发生偏转
        self.delegate.didSeletedIndexContentOffsetFor(sender.tag - 100)
    }
    func updateIndex(idx: NSInteger){
        
        let preBtn = self.viewWithTag(selectedIndex + 100) as! UIButton
        preBtn.layer.borderColor = WHITECOLOR.CGColor
        preBtn.selected = false
        
        let currentBtn = self.viewWithTag(idx + 100) as! UIButton
        currentBtn.selected = true
        currentBtn.layer.borderColor = hexColor(hexStr: "14ea24").CGColor
        selectedIndex = idx
    }
    
    func pinchBtnClick(sender: UIButton){
        
        self.isPinch = !self.isPinch
        if self.isPinch {
            UIView.animateWithDuration(trends * NSTimeInterval(index), animations: {
                //向上移动
                self.pinchBtn.frame.origin.y = 0
                //父视图也收缩
                self.mj_h = self.pinchBtn.mj_h
                
                }, completion: { (true) in
                self.pinchBtn.setImage(UIImage.init(named: "向下"), forState: .Normal)
                    self.pinchBtn.setImage(UIImage.init(named: "向下"), forState: .Highlighted)
            })
            //隐藏显示的按钮
            self.hiddenBtns(btns[index - 1], i: index)
            
        }else{
            
            UIView.animateWithDuration(trends * NSTimeInterval(index), animations: {
                self.pinchBtn.frame.origin.y = CGFloat(self.index) * (self.btnH + 2)
                self.mj_h = self.pinchBtn.mj_h + self.pinchBtn.mj_y
                }, completion: { (true) in
                    self.pinchBtn.setImage(UIImage.init(named: "向上"), forState: .Normal)
                    self.pinchBtn.setImage(UIImage.init(named: "向下"), forState: .Highlighted)
            })
            //显示隐藏的按钮
            self.showBtns(btns[0], i: 0)
        }
        
    }
    //隐藏
    func hiddenBtns(btn: UIButton, i: Int){
        var idx = i
        UIView.animateWithDuration(trends, animations: {
            btn.mj_h = 0
            }) { (true) in
                btn.hidden = true
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
        btn.hidden = false
        UIView.animateWithDuration(trends, animations: {
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
