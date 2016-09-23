//
//  PartnerTBC.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/22.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

//当展开或收缩事件触发时，回调
protocol PartnerCellDelegate: NSObjectProtocol {
    func openOrPinch(isOpen: Bool)
}

class PartnerTBC: UITableViewCell {
    
    
    @IBOutlet weak var nameL: UILabel!
    
    @IBOutlet weak var contentL: UILabel!
    
    @IBOutlet weak var faceImage: UIImageView!

    @IBOutlet weak var downUp: UIButton!
    
    @IBOutlet weak var timeL: UILabel!
    weak var delegate: PartnerCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.faceImage.layer.cornerRadius = self.faceImage.mj_h / 2
        self.faceImage.clipsToBounds = true
        
    }
    func customWith(model: PartnerModel){
        self.nameL.text = model.userName
        self.faceImage.sd_setImageWithURL(NSURL.init(string: model.userFace))
        
        //拼接日期字符串
        let timeStr = model.cTime as NSString
        let str = NSMutableString.init(string: timeStr.substringWithRange(NSRange.init(location: 5, length: 11)))
        str.replaceCharactersInRange(NSRange.init(location: 2, length: 1), withString: "月")
        str.insertString("日", atIndex: 5)
        self.timeL.text = str as String
        
        self.contentL.text = model.content
        //contentL.mj_w:当前在cell里的宽度，就算cell拉伸其值不变 self.mj_w-self.contentL.mj_x-16:适应cell后的最大宽度值
        let contentLHeight = heightFor(strLength: model.content, width: self.mj_w - self.contentL.mj_x - 16, font: 14) + 2 //16 距离右边 由于存在误差让它自加2
        //内容小于等于三行，隐藏展开/收缩按钮
        if contentLHeight > 53{
            self.downUp.hidden = false
        }else{  //由于复用时上次显示的还显示着，所以得在复用时进行判断
            self.downUp.hidden = true
        }
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func openOrCloseBtn(sender: UIButton) {
        sender.selected = !sender.selected
//        let contentH = heightFor(strLength: contentL.text!, width: self.mj_w - self.contentL.mj_x - 16, font: 14)
//        if sender.selected{
//            UIView.animateWithDuration(0.25, animations: { 
//                self.timeL.mj_y = contentH + self.contentL.mj_y + 10
//            })
//        }else{
//            UIView.animateWithDuration(0.25, animations: {
//                self.timeL.mj_y = self.timeL.mj_y
//            })
//        }
        self.delegate.openOrPinch(sender.selected)
    }
    
    
    
}
