//
//  TagsCell.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/28.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class TagsCell: UICollectionViewCell {
    
    @IBOutlet weak var tagsL: UILabel!
    
    @IBOutlet weak var lineL: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lineL.layer.cornerRadius = lineL.mj_h / 2
        lineL.clipsToBounds = true
       
        
    }

}
