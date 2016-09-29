//
//  AttractionNetworkManager.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/27.
//  Copyright © 2016年 u. All rights reserved.
//

import Foundation

//MARK: - 景点页面
extension AttractionModel{
    
    static func requestAttractionData(countryId: String!, placeId: String!, page: NSInteger, callBack:(attactionArr: [AnyObject]?, err: NSError?) -> Void){
        let para = NSMutableDictionary.init(dictionary: ["countryId":countryId, "placeId":placeId, "page":String(page), "count":"10", "module":"attraction", "":""])
        BaseRequest.getWithURL(HOME_URL + "search", para: para) { (data, error) in
            if error == nil{
                let rootDic = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                let list = rootDic["list"] as! [AnyObject]
                var arr: NSMutableArray?
                do{
                    arr = try AttractionModel.arrayOfModelsFromDictionaries(list)
                }catch{
                    arr = NSMutableArray()
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    callBack(attactionArr: arr! as [AnyObject], err: nil)
                })
            }else{
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(attactionArr: nil, err: error)
                })
            }
        }
    }
}

//MARK: - 某景点的具体页面Item
extension AttractionItemModel{
    static func requestAttractionItemData(countryId: String!, recordId: String!, callBack:(array: [AnyObject]?, err: NSError?) -> Void){
        //http://www.koubeilvxing.com/iteminfo?countryId=1&recordId=9&module=attraction&lang=zh&sessionId=
        let para = NSMutableDictionary.init(dictionary: ["countryId":countryId, "recordId":recordId, "module":"attraction"])
        BaseRequest.getWithURL(HOME_URL + "iteminfo", para: para) { (data, error) in
            if error == nil{
                let rootDic = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                let item = rootDic["item"] as! NSDictionary
                var arr = NSMutableArray()
                if item.count > 0{
                    arr = AttractionItemModel.arrayOfModelsFromDictionaries([item])
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    callBack(array: arr as [AnyObject], err: error)
                })
            }else{
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(array: nil, err: error)
                })
            }
        }
        
    }
    //http://www.koubeilvxing.com/reviewtags?recordId=9&lang=zh&module=attraction
    static func requestAttractionTagsData(recordId: String, callBack:(tagsArr: [AnyObject]?, err: NSError?) -> Void){
        let para = NSMutableDictionary.init(dictionary: ["recordId":recordId, "module":"attraction"])
        BaseRequest.getWithURL(HOME_URL + "reviewtags", para: para) { (data, error) in
            if error == nil{
                let rootDic = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                let tags = rootDic["tags"] as! [AnyObject]
                var arr = NSMutableArray()
                if tags.count > 0{
                    arr = AttractionTagsModel.arrayOfModelsFromDictionaries(tags)
                }
                
                
                dispatch_async(dispatch_get_main_queue(), {
                    callBack(tagsArr: arr as [AnyObject], err: error)
                })
            }else{
                dispatch_async(dispatch_get_main_queue(), {
                    callBack(tagsArr: nil, err: error)
                })
            }
        }
    }
}


//MARK: - 评论CommentModel
extension CommentModel{
    static func requestCommentData(recordId: String, page: NSInteger, callBack:(comments: [AnyObject]?, err: NSError?) -> Void){
        
        let para = NSMutableDictionary.init(dictionary: ["recordId":recordId, "page":"\(page)", "rows":"10", "module":"attraction"])
        BaseRequest.getWithURL(HOME_URL + "reviews", para: para) { (data, error) in
            if error == nil{
                let rootDic = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                let rt = CommentModel.arrayOfModelsFromDictionaries([rootDic])
                dispatch_async(dispatch_get_main_queue(), {
                    callBack(comments: rt as [AnyObject], err: error)
                })
            }else{
                dispatch_async(dispatch_get_main_queue(), {
                    callBack(comments: nil, err: error)
                })
            }
        }
    }
}


