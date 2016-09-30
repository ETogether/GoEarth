//
//  CityVC.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/22.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class CityVC: GEBaseVC {
    
    
    var placeId = ""
    
    @IBOutlet weak var cnL: UILabel!
    
    @IBOutlet weak var nameL: UILabel!
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var coverImage: UIImageView!
    
    let btnArr = ["景点", "餐馆", "酒店", "购物", "活动", "租车", "城市指南", "约伴"]
    
    var btnW:CGFloat = 0
    let leftSpace:CGFloat = 25
    
    var cityModel: CityModel?
    
    //按钮间隔  SCREEN_W < SCREEN_H 50  75
    var space:CGFloat = 0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //需要网络请求
        if cityModel == nil{
            self.loadData()
            return
        }
        createUI(cityModel!)
        
   
    }
    func createUI(model: CityModel){

            nameL.text = model.name
            cnL.text = model.nameCn
            
            coverImage.sd_setImageWithURL(NSURL.init(string: model.cover))
 
        //创建八个按钮
        self.createBtn(self.btnArr)
    }
    
    func loadData(){
        
        CityModel.requestCityData(placeId) { (model, err) in
            if err == nil{
                self.cityModel = model
                self.createUI(model!)
            }else{
                print(err)
                //发生网络错误时弹出警告框
                AlertTwoSeconds(self)
            }
        }
    }
    //MARK: - 创建按钮
    func createBtn(titleArr: [String]){
        
        var i = 0
        //判断高 宽屏
        if SCREEN_W < SCREEN_H{
            space = 75
            btnW = (SCREEN_W - 2 * leftSpace - 2 * 75) / 3
            
            for title in titleArr{
                
                var originX:CGFloat = 0
                var originY:CGFloat = 0
                //行 2 3 3
                if i < 2{
                    originX = (SCREEN_W - 2 * btnW - 75) / 2 + CGFloat(i) * (btnW + space)
                    originY = self.nameL.mj_y + self.nameL.mj_h + 50 + CGFloat(i / 3) * (btnW + 50)
                }else{
                    let r = i + 1
                    originX = leftSpace + CGFloat(r % 3) * (btnW + space)
                    originY = self.nameL.mj_y + self.nameL.mj_h + 50 + CGFloat(r / 3) * (btnW + 50)
                }
                
                let btn = UIButton.init(frame: CGRectMake(originX, originY, btnW, btnW))
                btn.setImage(UIImage.init(named: title), forState: .Normal)
                
                btn.layer.cornerRadius = btnW / 2
                btn.clipsToBounds = true
                btn.tag = i + 100
                btn.addTarget(self, action: #selector(self.btnClick(_:)), forControlEvents: .TouchUpInside)
                
                self.view.addSubview(btn)
                
                let labW = widthFor(strLength: title, height: 24, font: 14) + 10
                let lab = UILabel.init(frame: CGRectMake(originX, originY + btnW + 5, labW, 18))
                lab.text = title
                lab.textAlignment = .Center
                lab.textColor = WHITECOLOR
                lab.font = UIFont.systemFontOfSize(14)
                //使lab的x方向的中心与btn的中心一致
                lab.center.x = btn.center.x
                self.view.addSubview(lab)

                i += 1
            }
        }else{
            space = 50
           
        }

    }
    //MARK: - 按钮触发事件
    func btnClick(sender: UIButton) -> Void {

            switch sender.tag {
            case 100:
                let attraction = AttractionVC()
                attraction.countryId = cityModel!.countryId
                attraction.placeId = cityModel!.id
                attraction.navigationItem.title = "\(cityModel!.nameCn)景点"
                self.navigationController?.pushViewController(attraction, animated: true)
            case 101:
                print("餐馆")
            case 102:
                print("酒店")
            case 103:
                print("购物")
            case 104:
                print("活动")
            case 105:
                let rentalCar = RentalCarVC()
                rentalCar.placeId = cityModel!.id
                rentalCar.navigationItem.title = "\(cityModel!.nameCn)租车"
                self.navigationController?.pushViewController(rentalCar, animated: true)
                
            case 106:
                let cityGuide = CityGuideVC()
                cityGuide.navigationItem.title = "\(cityModel!.nameCn)城市指南"
                cityGuide.placeId = cityModel!.id
                cityGuide.name = cityModel!.nameCn
                cityGuide.infos = cityModel!.infoCn + "\n\n" + cityModel!.info
                
                self.navigationController?.pushViewController(cityGuide, animated: true)
            case 107:
                
                let partner = PartnerVC()
                partner.placeId = cityModel!.id
                partner.navigationItem.title = "邂逅\(cityModel!.nameCn)旅行者"
                self.navigationController?.pushViewController(partner, animated: true)
                
            default:
                return
            }

        
    }

    

    //MRAK:- 返回事件 返回上一页
    @IBAction func backClick(sender: UIButton) {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }

    //隐藏导航栏 再显示
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
}
