//
//  AttractionModels.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/27.
//  Copyright © 2016年 u. All rights reserved.
//

import Foundation

//MARK: - 景点（Attraction）
class AttractionModel: JSONModel {
    var address: String!
    var cityId: String!
    var cityName: String!
    var contact: String!
    var countryId: String!
    var countryName: String!
    var cover: String!
    var id: String!
    var lat: String!
    var lng: String!
    var mustgo: NSNumber?
    var name: String!
    var nameCn: String!
    var negativeReviewCount: String!
    var neutralReviewCount: String!
    var overall: String!
    var parent: String!
    var path: String!
    var positiveReviewCount: String!
    var price: String!
    var reservable: NSNumber!
    
    var review: ReviewModel! //一个对象模型
    
    var reviewCount: String!
    var reviewIds: String!
    var score: String!
    var status: String!
    
    required init(dictionary dict: [NSObject : AnyObject]!) throws {
        super.init()
//        self.nameCn = dict["name_cn"] as! String
        //借用KVC给属性赋值赋值
        self.setValuesForKeysWithDictionary(dict as! [String : AnyObject])  //调用了setValue...forKye
        self.nameCn = dict["name_cn"] as! String
        let reviewDic = dict["review"] as! NSDictionary
        self.review = (ReviewModel.arrayOfModelsFromDictionaries([reviewDic])).lastObject as! ReviewModel
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        super.setValue(value, forKey: key)
    }
    //如果setValue...forKey方法中的有些属性找不到匹配的字段就会调用该方法
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        //该方法无需进行其他操作，最多也是写个输出语句，提示走到该句！
    }
    
    
    required init(data: NSData!) throws {
        fatalError("init(data:) has not been implemented")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
//MARK: - 景点（Attraction）.review
class ReviewModel: JSONModel{
    
    
    var author: String!
    var authorCn: String!
    var comment: String!
    var commentCn: String!
    var cons: String!
    var id: String!
    var location: String!
    var pros: String!
    var score: String!
    var siteName: String!
    var time: String!
//    "title" : "",
//    "title_cn" : "",
//    "translate" : "1",
//    "userface" : ""
    override class func keyMapper() -> JSONKeyMapper{
        return JSONKeyMapper.mapperFromUnderscoreCaseToCamelCase()
    }
    override class func propertyIsOptional(name: String) -> Bool{
        return true
    }
    
}



/********************/
//MARK: - AttractionDetail某个具体的景点Item(主题)
class AttractionItemModel: JSONModel{
    var activityCount: String!
    var address: String!
    var attractionCount: String!
    var cityId: String!
    var cityName: String!
    var contact: String!
    var countryId: String!
    var countryName: String!
    var cover: String!
    var coverPhotoId: String!
    var covermore: String!
    var dimensionScores: NSMutableArray!  //另一个模型******
    
    //MARK: -景点中有的字段 游玩时间
    var duration: String = ""
    var duration_cn: String = "" //duration_cn其实这样的字段也可以使用，只是iOS中没有这种书写习惯
    
    var favoured: NSNumber!  //NSNumber
    var hotelCount: String!
    var id: String!
    var info: String!
    var infoCn: String!  //info_cn
    var lat: String!
    var lng: String!
    var name: String!
    var nameCn: String! // name_cn
    var negativeReviewCount: String!
    var neutralReviewCount: String!
    
    //MARK: -酒店中没有 开放时间
    var openingTime: String = ""//opening_time
    var openingTimeCn: String = "" //opening_time_cn
    
    var overall: String!
    var parent: String!
    var path: String!
    var photoCount: String!
    var positiveReviewCount: String!
    var price: String!
    var priceinfo: String!
    var reservable: NSNumber!
    var restaurantCount: String!
    var reviewCount: String!
    var reviews: NSMutableArray! //另一个模型******
    var score: String!
    var shoppingCount: String!
    //"sites" : [],
    var status: String!
    var tag: String!
    var tagCn: String! //tag_cn
    
    //MARK: - Restaurant里多了菜系cuisines
    var cuisines: String = ""
    var cuisinesCn: String = ""
    
    //MARK: - Hotel里多了 入住/退房时间 住宿政策 设施服务 是否允许带宠物  星级
    var check_in = ""
    var check_out = ""
    var children = ""
    var facility = ""
    var facility_cn = ""
    var pets = ""
    var star = ""
    
    var tip: String = "" //酒店中没有
    var traffic: String = "" //酒店中没有
    required init(dictionary dict: [NSObject : AnyObject]!) throws {
        super.init()
        
        self.setValuesForKeysWithDictionary(dict as! [String: AnyObject])
        
        let dimensionArr = dict["dimensionScores"] as! [AnyObject]
        self.dimensionScores = DimensionModel.arrayOfModelsFromDictionaries(dimensionArr)
        
        let reviewsArr = dict["reviews"] as! [AnyObject]
        self.reviews = ReviewsModel.arrayOfModelsFromDictionaries(reviewsArr)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "tag_cn"{
            self.setValue(value, forKey: "tagCn")
        }else if key == "opening_time_cn"{
            self.setValue(value, forKey: "openingTimeCn")
        }else if key == "opening_time"{
            self.setValue(value, forKey: "openingTime")
        }else if key == "name_cn"{
            self.setValue(value, forKey: "nameCn")
        }else if key == "info_cn"{
            self.setValue(value, forKey: "infoCn")
        }else if key == "cuisines_cn"{
            self.setValue(value, forKey: "cuisinesCn")
        }else{
            super.setValue(value, forKey: key)
        }
    }
    
    required init(data: NSData!) throws {
        fatalError("init(data:) has not been implemented")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
//MARK: - Item里的模型dimensionScores
class DimensionModel: JSONModel{
    var name: String!
    var score: String!
    var tag: String!
}
//MARK: - Item里的模型reviews
class ReviewsModel: JSONModel{
    var attractionId: String!
    var author: String!
    var authorCn: String! //author_cn
    var cTime: String!
    var comment: String!
    var commentCn: String! //comment_cn
    var cons: String!
    var feedId: String!
    var id: String!
    var location: String!
    var price: String!
    var pros: String!
    var score: String!
    var siteId: String!
    var siteName: String!
    var siteRank: String!  // NSNumber
    var time: String!
//    "title" : "",
//    "title_cn" : "",
    var translate: String!
    var userface: String!
    override class func propertyIsOptional(name: String) -> Bool{
        return true
    }
}

//MARK: - AttractionDetail某个具体的景点Tags
class AttractionTagsModel: JSONModel{
    
    var category: String!
    var groupId: String!  //"group_id" : "9"
    var id: String!
    var num: String!
    var property: String!
    var tag: String!
    override class func keyMapper() -> JSONKeyMapper{
        return JSONKeyMapper.mapperFromUnderscoreCaseToCamelCase()
    }
}


//************************具体景点里的评论
class CommentModel: JSONModel{
    var totalReviewCount: String!       //全部评论
    var negativeReviewCount: String!    //差评
    var neutralReviewCount: String!     //中评
    var positiveReviewCount: String!    //好评
    var ret: NSNumber!
    var reviews: NSMutableArray!
    
    required init(dictionary dict: [NSObject : AnyObject]!) throws {
        super.init()
        self.setValuesForKeysWithDictionary(dict as! [String: AnyObject])
        let arr = dict["reviews"] as! [AnyObject]
        self.reviews = CommentReviewsModel.arrayOfModelsFromDictionaries(arr)
    }
    
    required init(data: NSData!) throws {
        fatalError("init(data:) has not been implemented")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
class CommentReviewsModel: JSONModel{
    var author: String!
    var authorCn: String!      //author_cn
    var comment: String!
    var commentCn: String!     //comment_cn
    var cons: String!
    var id: String!
    var location: String!
    var pros: String!
    var score: String!
    var siteName: String!
    var time: String!
    var title: String!
    var titleCn: String!       ////title_cn
    var translate: String!
    var userface: String!
    
    override class func keyMapper() -> JSONKeyMapper{
        return JSONKeyMapper.init(modelToJSONDictionary: ["authorCn":"author_cn", "commentCn":"comment_cn", "titleCn":"title_cn"])
    }
    
    
}

