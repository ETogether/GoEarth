//
//  CityModels.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 u. All rights reserved.
//

import Foundation

//MARK:热门城市模型
class HotCityModel: JSONModel{
    
//    "cover" : "http://img.koubeilvxing.com/pics/upload/2015-07-28/55b6d992efaed.jpg@!thumb",
//    "desc" : "佛教之都，包罗万象",
//    "id" : "326",
//    "info" : "",
//    "info_cn" : "",
//    "name" : "Bangkok",
//    "name_cn"
    
    var cover: String!
    var desc: String!
    var id: String!
    var name: String!
    var nameCn: String!
    
    override class func propertyIsOptional(name: String) -> Bool{
        return true
    }
    override class func keyMapper() -> JSONKeyMapper{
        return JSONKeyMapper.init(modelToJSONDictionary: ["nameCn":"name_cn"])//对少数字段就行操作
        //return JSONKeyMapper.mapperFromUnderscoreCaseToCamelCase()  //对多数有下划的字段操作(将下划线去掉首字母大写)，但数据里原有字段存在大写字母，会把它当成原字段是带下划线处理导致崩溃
    }
//    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
//        
//    }
//    override func setValue(value: AnyObject?, forKey key: String) {
//        if key == "name_cn"{
//            self.setValue(value, forKey: "nameCn")
//        }else{
//            super.setValue(value, forKey: key)
//        }
//    }
    
}
//MARK:城市页面
class CityModel: JSONModel {
    //活动 景点 酒店 餐馆 购物
    var activityCount: String!
    var activityReviewCount: String!
    var attractionCount: String!
    var attractionReviewCount: String!
    var hotelCount: String!
    var hotelReviewCount: String!
    var restaurantCount: String!
    var restaurantReviewCount: String!
    var shoppingCount: String!
    var shoppingReviewCount: String!

    var continentId: String!
    var countryId: String!
    var cover: String!
    var coverPhotoId: String!
    var detail: String!
    var id: String!                 //json里是NSNumber类型
    var info: String!
    var infoCn: String!
    //经纬度
    var lat: String!
    var lng: String!
    
    var name: String!
    var nameCn: String!
    var path: String!
    var photoIds: String!
    var photos: NSMutableArray!
    
    var poiCount: String? = ""
    var reviewCount: String? = ""
    
    var type: String!
    
    override class func keyMapper() -> JSONKeyMapper{
        return JSONKeyMapper.init(modelToJSONDictionary:["nameCn":"name_cn", "infoCn":"info_cn"])
    }
    override class func propertyIsOptional(name: String) -> Bool{
        return true
    }
    
//    required init(dictionary dict: [NSObject : AnyObject]!) throws {
//        super.init()
//        
//        self.nameCn = dict["name_cn"] as! String
//        self.infoCn = dict["info_cn"] as! String
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    required init(data: NSData!) throws {
//        fatalError("init(data:) has not been implemented")
//    }
    
}

//MARK: - Partner(约伴)页面的模型
class PartnerModel: JSONModel{
   
    var cTime: String!
    var content: String!
    var day: String!
    var device: String!
    var id: String!
    var placeId: String!
    var posts: String!
    var userFace: String!
    var userId: String!
    var userName: String!
    
    override class func propertyIsOptional(pptName: String) -> Bool{
        return true
    }
}

//MARK: - CityGuide(城市指南）页面的模型
class CityGuideModel: JSONModel{
    var title: String!
    var section: NSMutableArray!
    
    required init(dictionary dict: [NSObject : AnyObject]!) throws {
        super.init()
        self.title = dict["title"] as! String
        let arr = dict["section"] as! [AnyObject]
        if arr.count > 0{
            self.section = ContentModel.arrayOfModelsFromDictionaries(arr)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(data: NSData!) throws {
        fatalError("init(data:) has not been implemented")
    }
    
}

class ContentModel: JSONModel{
    var content: String!
    var name: String!
    var title: String!
    
}














