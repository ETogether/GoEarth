//
//  AttractionTagsCell.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/28.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class AttractionTagsCell: UICollectionViewCell {

    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var count: UILabel!
    
    @IBOutlet weak var tagL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.layer.cornerRadius = bgView.mj_w / 2
        bgView.clipsToBounds = true
        bgView.layer.borderWidth = 3
        bgView.layer.borderColor = hexColor(hexStr: "04f0a1").CGColor
        
        //self.backgroundColor = WHITECOLOR
        self.contentView.backgroundColor = WHITECOLOR
        
    }

}
