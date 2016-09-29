//
//  CompanyCompareCell.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class CompanyCompareCell: UITableViewCell {

    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var reviewL: UILabel!
    
    @IBOutlet weak var scale: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
