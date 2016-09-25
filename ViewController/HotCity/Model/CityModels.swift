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
    
    var cover: String!
    var desc: String!
    var id: String!
    var name: String!
    var nameCn: String!
    
    override class func keyMapper() -> JSONKeyMapper{
        return JSONKeyMapper.mapperFromUnderscoreCaseToCamelCase()
    }
    override class func propertyIsOptional(propertyName: String) -> Bool{
        return true
    }
    
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


















