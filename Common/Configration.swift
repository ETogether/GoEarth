//
//  Configration.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/20.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit


//屏幕宽 高
let SCREEN_W = UIScreen.mainScreen().bounds.width
let SCREEN_H = UIScreen.mainScreen().bounds.height

//首网址
let HOME_URL = "http://www.koubeilvxing.com/"
let WHITECOLOR = hexColor(hexStr: "FFFFFF")


//MARK: - 根据字符串长度返回合适的宽高
func widthFor(strLength str: String, height: CGFloat, font: CGFloat) -> CGFloat {
    
    let s = NSString.init(string: str)
    return s.boundingRectWithSize(CGSizeMake(9999999, height), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(font)], context: nil).width
}
func heightFor(strLength str: String, width: CGFloat, font: CGFloat) -> CGFloat {
   
    let s = NSString.init(string: str)
    return s.boundingRectWithSize(CGSizeMake(width, 999999), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(font)], context: nil).height
}


//MARK: - 警告框 弹出两秒自动消失
func AlertTwoSeconds(object: UIViewController){
    let ac = UIAlertController.init(title: "网络连接请求失败！", message: nil, preferredStyle: .Alert)
    dispatch_async(dispatch_get_main_queue(), {
        //延迟两秒后消失
        object.presentViewController(ac, animated: true, completion: {
            ac.performSelector(#selector(UIAlertController.dismissViewControllerAnimated(_:completion:)), withObject: nil, afterDelay: 2)
        })
    })

}



