//
//  AttractionCell.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/27.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class AttractionCell: UITableViewCell {

    
    @IBOutlet weak var mustGoSuperView: UIView!
    
    @IBOutlet weak var coverImage: UIImageView!
    
    @IBOutlet weak var cnL: UILabel!
    
    @IBOutlet weak var nameL: UILabel!
    
    @IBOutlet weak var starsView: UIImageView!
   
    @IBOutlet weak var scoreReviewL: UILabel!
    
    @IBOutlet weak var priceL: UILabel!
    
    @IBOutlet weak var contentL: UILabel!
    var stars: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.starsView.contentMode = .Left
        self.starsView.clipsToBounds = true

        self.scoreReviewL.textColor = UIColor.grayColor()
        self.contentL.textColor = UIColor.darkGrayColor()
        
        self.selectionStyle = .None
        
        let starsBG = UIImageView.init(frame: CGRectMake(120, 57, 80, 20))
        starsBG.image = UIImage.init(named: "stars_bgs")
        self.addSubview(starsBG)
        
        stars = UIImageView.init(frame: CGRectMake(120, 57, 80, 20))
        self.addSubview(stars)
        stars.image = UIImage.init(named: "stars_fg")
        
        stars.contentMode = .Left
        stars.clipsToBounds = true
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func customWith(model: AttractionModel){
        coverImage.sd_setImageWithURL(NSURL.init(string: model.cover!))
        cnL.text = model.nameCn
        nameL.text = model.name
        if model.mustgo != nil{
            for view in self.mustGoSuperView.subviews{
                view.removeFromSuperview()
            }
            
            if model.mustgo!.integerValue > 0{
                
                let lab = UILabel.init(frame: CGRectMake(8, 0, 40, 18))
                lab.center.y = self.cnL.center.y
                lab.text = "必去"
                lab.textColor = WHITECOLOR
                lab.font = UIFont.systemFontOfSize(12)
                lab.backgroundColor = UIColor.orangeColor()
                lab.layer.cornerRadius = lab.mj_h / 2
                lab.clipsToBounds = true
                lab.textAlignment = .Center
                self.mustGoSuperView.addSubview(lab)
            }
        }
        
        
        if Int(model.price)! > 0{
            let str = "价格：\t¥" + model.price + "起"
            priceL.attributedText = AttributeText(hexColor(hexStr: "04f0a1"), text: str, rangeStr: "¥" + model.price + "起")
        }else{
            let str = "价格：\t" + "免费"
            priceL.attributedText = AttributeText(hexColor(hexStr: "04f0a1"), text: str, rangeStr: "免费")
        }
        let num = Float(model.score)!
        let width = CGFloat(num / 10) * 80
        stars.mj_w = width
        //starsView.frame.size.width = width
        scoreReviewL.text = model.score + "分/" + model.reviewCount + "点评"
        if model.review != nil{
            contentL.attributedText = AttributeText(hexColor(hexStr: "000000"), text: model.review!.author + ":" + model.review!.comment, rangeStr: model.review!.author)
        }
        
    }
    
    
}
