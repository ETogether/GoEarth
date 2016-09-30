//
//  RentalCarNetworkManager.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 u. All rights reserved.
//

import Foundation


extension VehiclesModel{
    
    //https://www.koubeilvxing.com/rental_search?dropoffDate=2016-10-04&pickupDateTime=10:00&type=3&lang=zh&placeId=19039&dropoffDateTime=10:00&pickupDate=2016-09-27
    static func requestVehiclesData(placeId: String, callBack:(vehiclesArr: [AnyObject]?, suppliersDic: NSDictionary?, vehicleType: NSDictionary?, err: NSError?) -> Void){
        let dropDate = stringFor(3600 * 24 * 14)
        let pickDate = stringFor(3600 * 24 * 7)
        
        let para = NSMutableDictionary.init(dictionary: ["type":"3", "placeId":placeId, "dropoffDate":dropDate, "pickupDateTime":"10:00", "dropoffDateTime":"10:00", "pickupDate":pickDate])
        BaseRequest.getWithURL(HOME_URL + "rental_search", para: para) { (data, error) in
//            dispatch_async(dispatch_get_main_queue(), { 
//                print(NSString.init(data: data!, encoding: NSUTF8StringEncoding))
//            })
            
            
            if error == nil{
                let rootDic = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                let dataDic = rootDic["data"] as! NSDictionary
                /* vehicleTypeDescs - 车辆类型 */
                let type = dataDic["vehicleTypeDescs"] as! NSDictionary
                
                
                
                /* Vehicles - 车辆 *********************************************/
                let vehicles = dataDic["vehicles"] as? [AnyObject]
                var vehArr = NSMutableArray()
                if vehicles == nil{
                    return
                }else{
                    if vehicles!.count > 0{
                        vehArr = VehiclesModel.arrayOfModelsFromDictionaries(vehicles)
                    }
                }
                
                
                /* Suppliers - 供应商 *********************************************/
               
                let suppliers = dataDic["suppliers"] as! NSDictionary
//                let supKeys = suppliers.allKeys
//                let keyArr = NSMutableArray()
//                for key in supKeys{
//                    
//                    let dic = suppliers[key as! String] as! NSDictionary
//                    //SupplierModel.arrayOfModelsFromDictionaries([dic])
//                    keyArr.addObject(dic)
//                }
//                if keyArr.count > 0{
//                    supArr = SupplierModel.arrayOfModelsFromDictionaries(keyArr as [AnyObject])
//                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    callBack(vehiclesArr: vehArr as [AnyObject], suppliersDic: suppliers, vehicleType: type, err: nil)
                })

            }else{
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(vehiclesArr: nil, suppliersDic: nil, vehicleType: nil, err: error)
                })
            }
        }

    }

}

//********
//MARK: - 供应商口碑 companycompare
extension CompanyCompareModel{
    static func requestCompanyCompareData(placeId: String, callBack:(arr: [AnyObject]?, err: NSError?) -> Void){
        //GET http://www.koubeilvxing.com/companycompare?lang=zh&placeId=19039
        let para = NSMutableDictionary.init(dictionary: ["placeId":placeId])
        BaseRequest.getWithURL(HOME_URL + "companycompare", para: para) { (data, error) in
            if error == nil{
                let rootDic = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                let arrKeys = rootDic.allKeys as! [String]
                let arr = NSMutableArray()
                for key in arrKeys{
                    if key == "ret"{
                        continue
                    }
                    let arrays = rootDic[key] as! [AnyObject]
                    var array = NSMutableArray()
                    if arrays.count > 0{
                        array = CompanyCompareModel.arrayOfModelsFromDictionaries(arrays)
                    }
                    arr.addObject(array)
                }
 
                dispatch_async(dispatch_get_main_queue(), {
                    callBack(arr: arr as [AnyObject], err: error)
                })
            }else{
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(arr: nil, err: error)
                })
            }
        }
        
    }
}
