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
    
    
    @IBOutlet weak var supView: UIView!

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
    func createIcons(sup: NSMutableArray, dic: NSDictionary){
        var arrId = [String]()
        var arrUrl = [String]()
        var arrRMB = [String]()
        
        //取出车辆信息中的供应商id
        for model in sup{
            let mdl = model as! SupplierQuotesModel
            let price = (mdl.allQuotes[0] as! AllQuotesModel).priceInfo as PriceInfoModel
            arrRMB.append(price.unitPriceRMB)
            arrId.append(mdl.supplierId)
        }
        //根据id找出供应商相对应的数据
        for id in arrId{
            let d = dic[id] as! NSDictionary
            arrUrl.append(d["supplierImage"] as! String)
        }
        for sub in supView.subviews{
            sub.removeFromSuperview()
        }
        let height = CGFloat(sup.count) * 30 + CGFloat(sup.count - 1) * 5 + 10
        let supplierView = SuppliersView.init(frame: CGRectMake(0, 0, SCREEN_W - supView.mj_x - 8, height), imageURL: arrUrl, RMBS: arrRMB)
        
        supView.addSubview(supplierView)
    }
    
}
