//
//  CityNetworkManager.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 u. All rights reserved.
//

import Foundation

extension HotCityModel{
//    六大洲国家continents 及 热门城市recommendplaces
//    http://www.koubeilvxing.com/countrys?lang=zh
    static func requestHotCityData(callBack:(countryArr: [AnyObject]? , hotCityArr: [AnyObject]?, err: NSError?) -> Void){
        BaseRequest.getWithURL(HOME_URL + "countrys", para: nil) { (data, error) in
            if error == nil{
                let rootDic = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                //推荐城市(热门城市)
                let cityArr = rootDic["recommendplaces"] as! [AnyObject]
                var hotArr = NSMutableArray()
                if cityArr.count > 0{
                    hotArr = HotCityModel.arrayOfModelsFromDictionaries(cityArr)
                }
                
                //六大洲
                let conArr = rootDic["continents"] as! [AnyObject]
                var countyrs:NSMutableArray? = nil
                do{
                    countyrs = try ContinentModel.arrayOfModelsFromDictionaries(conArr, error: ())
                }catch{
                    countyrs = NSMutableArray()
                }
                
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(countryArr: countyrs! as [AnyObject], hotCityArr: hotArr as [AnyObject], err: nil)
                })
                
                
            }else{
                dispatch_async(dispatch_get_main_queue(), {
                    callBack(countryArr: nil, hotCityArr: nil, err: error)
                })
            }
        }
        
    }
    
}
//MARK: -城市（曼谷）
extension CityModel{
    static func requestCityData(placeId: String, callBack:(model: CityModel?, err: NSError?) -> Void){
        //http://www.koubeilvxing.com/placeinfo?countryId=&lang=zh&placeId=326&new=0
        let para = NSMutableDictionary.init(dictionary: ["placeId":placeId])
        
        BaseRequest.getWithURL(HOME_URL + "placeinfo", para: para) { (data, error) in
            if error == nil{
                let rootDic = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                let placeDic = rootDic["place"] as! NSDictionary
                
                let cityArr = CityModel.arrayOfModelsFromDictionaries([placeDic])
                //由于数据中只有一个字典(也模型)
                let model = cityArr.lastObject as! CityModel
                
                dispatch_async(dispatch_get_main_queue(), {
                    callBack(model: model, err: error)
                })
            }else{
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(model: nil, err: error)
                })
            }
        }
    }
    
}

//MARK: - Partner约伴模型
extension PartnerModel{
    //http://www.koubeilvxing.com/plans?lng=0.0&lang=zh&placeId=19039&sessionId=&lat=0.0
    static func requestPartnerData(placeId: String, callBack:(partnerArr: [AnyObject]?, err: NSError?) -> Void){
        let para = NSMutableDictionary.init(dictionary: ["placeId":placeId])
        BaseRequest.getWithURL(HOME_URL + "plans", para: para) { (data, error) in
            if error == nil{
                let rootDic = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                let planArr = rootDic["plans"] as! [AnyObject]
                var arr = NSMutableArray()
                if planArr.count > 0 {
                    arr = PartnerModel.arrayOfModelsFromDictionaries(planArr)
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    callBack(partnerArr: arr as [AnyObject], err: nil)
                })
            }else{
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(partnerArr: nil, err: error)
                })
            }
        }
        
    }
}

//MARK: - CityGuide城市指南模型
extension CityGuideModel{
    static func requestCityGuideData(placeId: String, callBack:(guideArr: [AnyObject]?, err: NSError?) -> Void){
        // http://www.koubeilvxing.com/placedetail?lang=zh&placeId=19039
        let para = NSMutableDictionary.init(dictionary: ["placeId":placeId])
        BaseRequest.getWithURL(HOME_URL + "placedetail", para: para) { (data, error) in
            if error == nil{
                
                let rootDic = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                let arr = rootDic["detail"] as? [AnyObject]
                var guideArr: NSMutableArray? = nil
                do{
                    guideArr = try CityGuideModel.arrayOfModelsFromDictionaries(arr, error: ())
                }catch{
                    guideArr = nil
                }
                if guideArr == nil{
                    dispatch_async(dispatch_get_main_queue(), {
                        callBack(guideArr: nil, err: nil)
                    })
                    return
                }
                dispatch_async(dispatch_get_main_queue(), {
                    callBack(guideArr: guideArr! as [AnyObject], err: nil)
                })
            }else{
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(guideArr: nil, err: error)
                })
            }
        }
        
    }

}






















