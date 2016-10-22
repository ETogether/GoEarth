//
//  ContinentNetworkManager.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/25.
//  Copyright © 2016年 u. All rights reserved.
//

import Foundation

extension SearchModel{
    /**主页中搜索*/
    static func requestSearchData(kw:String, page:NSInteger, module:String, callBack:(arr:[AnyObject]?, err: NSError?) -> Void){
        //GET http://www.koubeilvxing.com/suggest_all?kw=%E6%B3%95&module=country&lang=zh&placeId=&page=1
        let para = ["kw":kw, "page":String(page), "module":module]
        BaseRequest.getWithURL(HOME_URL + "suggest_all", para: para) { (data, error) in
            if error == nil{
                let rootDic = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
               // print(rootDic)
                let keys = rootDic.allKeys as! [String]
                var haveList = false
                for key in keys{
                    if key == "list"{
                        haveList = true
                    }
                }
                
                
                if haveList{
                    let listArr = rootDic["list"] as! [AnyObject]
                    var arr = NSMutableArray()
                    if listArr.count > 0{
                        arr = SearchModel.arrayOfModelsFromDictionaries(listArr)
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        callBack(arr: arr as [AnyObject], err: nil)
                    })
                }else{
                    dispatch_async(dispatch_get_main_queue(), {
                        callBack(arr: nil, err: nil)
                    })
                }
            }else{
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(arr: nil, err: error)
                })
                
            }
        }
        
        
    }
    
}