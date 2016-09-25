//
//  CitysCell.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/25.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class CitysCell: UICollectionViewCell {

    
    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var cnL: UILabel!
    
    @IBOutlet weak var poiCountL: UILabel!
    
    @IBOutlet weak var reviewCountL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func customWith(model: CityModel){
        iconImage.sd_setImageWithURL(NSURL.init(string: model.cover))
        cnL.text = model.nameCn
        poiCountL.text = model.poiCount! + " 去处"
        reviewCountL.text = model.reviewCount! + " 点评"
    }

}
