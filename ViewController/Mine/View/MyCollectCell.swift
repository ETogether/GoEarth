//
//  MyCollectCell.swift
//  GoEarth
//
//  Created by qianfeng on 16/10/7.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class MyCollectCell: UITableViewCell {

    
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var nameCnL: UILabel!
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var scoreL: UILabel!
    @IBOutlet weak var countryNameL: UILabel!
    
    @IBOutlet weak var typeL: UILabel!
    @IBOutlet weak var starView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.selectionStyle = .None
        self.backgroundColor = GRAYCOLOR
    }

    func customWith(model: Place){
        cover.sd_setImageWithURL(NSURL.init(string: model.imageUrl!))
        nameCnL.text = model.nameCn
        nameL.text = model.name
        
        for sub in starView.subviews{
            sub.removeFromSuperview()
        }
        let starsBG = UIImageView.init(frame: CGRectMake(0, 0, 80, 20))
        starsBG.center.x = (SCREEN_W - 168) / 2
        starsBG.image = UIImage.init(named: "stars_bgs")
        starView.addSubview(starsBG)
        
        let stars = UIImageView.init(frame: CGRectMake(starsBG.mj_x, 0, 80, 20))
        //stars.center.x = starView.center.x
        starView.addSubview(stars)
        stars.image = UIImage.init(named: "stars_fg")
        
        stars.contentMode = .Left
        stars.clipsToBounds = true
        let num = CGFloat(Float(model.score!)!)
        stars.mj_w = num / 10 * 80
        
        scoreL.text = model.score! + "分/" + model.reviews! + "点评"
        
        countryNameL.text = model.countryName! + "." + model.cityName!
        
        switch model.module! {
        case "attraction":
            typeL.text = "类型： " + "景点"
        case "restaurant":
            typeL.text = "类型： " + "餐馆"
        case "hotel":
            typeL.text = "类型： " + "酒店"
        case "shopping":
            typeL.text = "类型： " + "购物"
        case "activity":
            typeL.text = "类型： " + "活动"
        default:
            print("没该类型！")
        }
        
    }
    
}
