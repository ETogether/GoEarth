//
//  CountrysModels.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 u. All rights reserved.
//

import Foundation

class CountrysModel: JSONModel{
   
    var capitalId: String!
    var continentId: String!
    var countryId: String!
    var cover: String!
    var id: String!
    var name: String!
    var nameCn: String!
    var type: String!
    
    override class func keyMapper() -> JSONKeyMapper{
        return JSONKeyMapper.init(modelToJSONDictionary: ["nameCn":"name_cn"])
    }
//    required init(dictionary dict: [NSObject : AnyObject]!) throws {
//        super.init()
//        self.nameCn = dict["name_cn"] as! String
//    }
//    
//    required init(data: NSData!) throws {
//        fatalError("init(data:) has not been implemented")
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
    
    
}

class ContinentModel: JSONModel {
    
    var continentId: String!
    var countryId: String!
    var countrys: NSMutableArray!
    var id: String!
    var name: String!
    var nameCn: String!
    var type: String!
//    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
//        
//    }
    required init(dictionary dict: [NSObject : AnyObject]!) throws {
        super.init()
        self.nameCn = dict["name_cn"] as! String!
        let arr = dict["countrys"] as! [AnyObject]
        if arr.count > 0{
            self.countrys = CountrysModel.arrayOfModelsFromDictionaries(arr)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(data: NSData!) throws {
        fatalError("init(data:) has not been implemented")
    }
    
}








