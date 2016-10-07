//
//  MineCell.swift
//  GoEarth
//
//  Created by qianfeng on 16/10/7.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class MineCell: UITableViewCell {

    
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var titleL: UILabel!
    
    @IBOutlet weak var numL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        self.selectionStyle = .None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
