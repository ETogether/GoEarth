//
//  PartnerTBC.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/22.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class PartnerTBC: UITableViewCell {
    
    
    @IBOutlet weak var nameL: UILabel!

    
    @IBOutlet weak var contentL: UILabel!
    
    
    @IBOutlet weak var faceImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.faceImage.layer.cornerRadius = self.faceImage.mj_h / 2
        self.faceImage.clipsToBounds = true
        
    }
    func customWith(model: PartnerModel){
        self.nameL.text = model.userName
        self.contentL.text = model.content
        self.faceImage.sd_setImageWithURL(NSURL.init(string: model.userFace))
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
