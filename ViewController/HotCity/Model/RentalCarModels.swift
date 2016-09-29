//
//  RentalCarModels.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 u. All rights reserved.
//

import Foundation
//******************************************************************//
//**MARK: - vehicles车辆

class VehiclesModel: JSONModel{
    var quoteNums: NSNumber!
    var supplierQuotes: NSMutableArray!
    var unitPriceRMB: NSNumber!
    var vehicleInfo: VehicleInfoModel!
    required init(dictionary dict: [NSObject : AnyObject]!) throws {
        super.init()
        self.quoteNums = dict["quoteNums"] as! NSNumber
        self.unitPriceRMB = dict["unitPriceRMB"] as! NSNumber
        let quotes = dict["supplierQuotes"] as! [AnyObject]
        if quotes.count > 0{
            self.supplierQuotes = SupplierQuotesModel.arrayOfModelsFromDictionaries(quotes)
        }
        let infoDic = dict["vehicleInfo"] as! NSDictionary
        
        self.vehicleInfo = (VehicleInfoModel.arrayOfModelsFromDictionaries([infoDic])).lastObject as! VehicleInfoModel
        
        
    }
    
    required init(data: NSData!) throws {
        fatalError("init(data:) has not been implemented")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SupplierQuotesModel: JSONModel{
    var supplierId: String!
    var allQuotes: NSMutableArray!
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    required init(dictionary dict: [NSObject : AnyObject]!) throws {
        super.init()
        self.supplierId = (dict["supplierId"] as! NSNumber).stringValue
        let arr = dict["allQuetes"] as! [AnyObject]
        if arr.count > 0{
            self.allQuotes = allQuotesModel.arrayOfModelsFromDictionaries(arr)
        }
        
    }
    
    required init(data: NSData!) throws {
        fatalError("init(data:) has not been implemented")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - vehicles车辆allQuotes
class allQuotesModel: JSONModel{
    var priceInfo: priceInfoModel!
    required init(dictionary dict: [NSObject : AnyObject]!) throws {
        super.init()
        let price = dict["priceInfo"] as! NSDictionary
        let array = priceInfoModel.arrayOfModelsFromDictionaries([price])
        self.priceInfo = array.lastObject as! priceInfoModel
    }
    
    required init(data: NSData!) throws {
        fatalError("init(data:) has not been implemented")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - vehicles车辆allQuotes priceInfo
class priceInfoModel: JSONModel{
    var unitPriceRMB: String!
    override class func propertyIsOptional(name: String) -> Bool{
        return true
    }
}

//MARK: - vehicleInfo车辆信息
class VehicleInfoModel: JSONModel{
    var door: String!
    var groupType: String!
    var imagePath: String!
    var seat: String!
    var transmission: String!
    var vehicleName: String!
    var vehicleId: String!
    
    override class func propertyIsOptional(name: String) -> Bool{
        return true
    }

}

//**************************************************************************************//
//MARK: - suppliers供应商

//supplier供应商模型
class SupplierModel: JSONModel{
    var address: String!
    var addressMark: String!
    var supplierImage: String!
    var supplierName: String!
}

//********
//MARK: - 供应商口碑 companycompare
class CompanyCompareModel: JSONModel{
   
    var experience: String!
    var id: String!
    var logo: String!
    var name: String!
    var negativeReviewCount: String!
    var neutralReviewCount: String!
    var positiveReviewCount: String!
    var price: String!
    var reviewCount: String!
    var score: String!
    var service: String!
    var status: String!
    var value: NSNumber!
    

}
