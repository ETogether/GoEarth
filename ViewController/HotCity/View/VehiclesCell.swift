//
//  VehiclesCell.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class VehiclesCell: UITableViewCell {
    
    
    @IBOutlet weak var imageCar: UIImageView!
    
    @IBOutlet weak var nameL: UILabel!
    
    @IBOutlet weak var desL: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.backgroundColor = GRAYCOLOR
        self.selectionStyle = .None
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func createIcons(sup: NSMutableArray){
        
    }
    
}
