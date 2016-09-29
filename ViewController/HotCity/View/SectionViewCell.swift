//
//  SectionViewCell.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class SectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var titleL: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.layer.borderColor = hexColor(hexStr: "dddddd").CGColor
        self.layer.borderWidth = 2
        
        
    }

}
