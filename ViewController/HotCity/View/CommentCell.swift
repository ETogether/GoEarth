//
//  CommentCell.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/30.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    
    
    @IBOutlet weak var userface: UIImageView!
    
    @IBOutlet weak var authorL: UILabel!
    @IBOutlet weak var commentL: UILabel!
    @IBOutlet weak var timeL: UILabel!
   
    
    @IBOutlet weak var starView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userface.layer.cornerRadius = userface.mj_h / 2
        userface.clipsToBounds = true
        
        
        
        self.selectionStyle = .None
        
        
    }
    
    func customWith(model: CommentReviewsModel){
        userface.sd_setImageWithURL(NSURL.init(string: model.userface))
        authorL.text = model.author
        let width = widthFor(strLength: model.author, height: 21, font: 14) + 5
        for view in starView.subviews{
            view.removeFromSuperview()
        }
        let starBG = UIImageView.init(frame: CGRectMake(authorL.mj_x + width + 10, 10, 80, 20))
        starBG.image = UIImage.init(named: "stars_bgs")
        starView.addSubview(starBG)
        
        let starFG = UIImageView.init(frame: CGRectMake(authorL.mj_x + width + 10, 10, 80, 20))
        starView.addSubview(starFG)
        starFG.image = UIImage.init(named: "stars_fg")
        starFG.contentMode = .Left   //左不动
        starFG.clipsToBounds = true
        let s = Float(model.score)!
        starFG.mj_w = CGFloat(s / 10) * 80
        
        
        let h = heightFor(strLength: model.comment, width: SCREEN_W - commentL.mj_x - 15, font: 12) + 5
        commentL.mj_h = h
        commentL.text = model.comment
        
        let str = NSString.init(string: model.time)
        timeL.text = str.substringToIndex(10)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
