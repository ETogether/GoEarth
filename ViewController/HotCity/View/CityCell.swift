//
//  HotCityCell.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class CityCell: UICollectionViewCell {

    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var cnL: UILabel!
    @IBOutlet weak var nameL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cnL.textColor = WHITECOLOR
        nameL.textColor = WHITECOLOR
        
    }
    func customWith(model: HotCityModel){
        
        cnL.text = model.nameCn
        nameL.text = model.name
        coverImage.sd_setImageWithURL(NSURL.init(string: model.cover))
        
    }

}
