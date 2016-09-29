//
//  SuppliersView.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class SuppliersView: UIView {

    init(frame: CGRect, imageURL:[String], RMBS: [String]) {
        super.init(frame: frame)
        
        var i = 0
        
        for url in imageURL{
            let originY = CGFloat(i) * (30 + 5)
            let imageView = UIImageView.init(frame: CGRectMake(0, originY, 50, 30))
            imageView.sd_setImageWithURL(NSURL.init(string: url))
            self.addSubview(imageView)
            
            let rmb = UILabel.init(frame: CGRectMake(frame.width - 60, originY, 60, 30))
            
            let content = NSMutableString.init(string: "¥" + RMBS[i] + "/天")
            let attri = NSMutableAttributedString.init(string: content as String)
            attri.addAttributes([NSForegroundColorAttributeName:hexColor(hexStr: "04f0a1")], range: content.rangeOfString("¥" + RMBS[i]))
            
            rmb.attributedText = attri
            self.addSubview(rmb)
            i += 1
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
