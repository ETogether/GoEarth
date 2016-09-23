//
//  CityVC.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/22.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class CityVC: UIViewController {
    
    var hotCityModel: HotCityModel!
    
    @IBOutlet weak var cnL: UILabel!
    
    @IBOutlet weak var nameL: UILabel!
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var coverImage: UIImageView!
    
    let btnArr = ["景点", "餐馆", "酒店", "购物", "活动", "租车", "城市指南", "约伴"]
    
    var btnW:CGFloat = 0
    let leftSpace:CGFloat = 25
    
    //按钮间隔  SCREEN_W < SCREEN_H 50  75
    var space:CGFloat = 0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor.cyanColor()
        self.createUI()
        self.loadData()
        
    }
    func createUI(){
        nameL.text = hotCityModel.name
        cnL.text = hotCityModel.nameCn
        
        coverImage.sd_setImageWithURL(NSURL.init(string: hotCityModel.cover))
        
//        //创建毛玻璃
//        let blurView = UIVisualEffectView.init(effect: UIBlurEffect.init(style: .Light))
//        blurView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H)
//        blurView.alpha = 0.6
//        coverImage.addSubview(blurView)
        
        
        
        //创建八个按钮
        self.createBtn(self.btnArr)
    }
    
    func loadData(){
        
        CityModel.requestCityData(hotCityModel.id) { (model, err) in
            if err == nil{
                
                dispatch_async(dispatch_get_main_queue(), {

                })
                
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
    func btnClick(sender: UIButton) -> Void {
        
        switch sender.tag {
        case 100:
            print("景点")
        case 101:
            print("餐馆")
        case 102:
            print("酒店")
        case 103:
            print("购物")
        case 104:
            print("活动")
        case 105:
            print("租车")
        case 106:
            print("城市指南")
        case 107:
            print("约伴")
            let partner = PartnerVC()
            partner.placeId = hotCityModel.id
            partner.navigationItem.title = "邂逅\(hotCityModel.nameCn)旅行者"
            self.navigationController?.pushViewController(partner, animated: true)
            
        default:
            return
        }
    }

    

    //MRAK:- 返回事件 返回上一页
    @IBAction func backClick(sender: UIButton) {
        print(1)
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
