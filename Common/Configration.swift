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

//主题色
let THEAMCOLOR = hexColor(hexStr: "14ea24")
//灰色白色
let GRAYCOLOR = UIColor.init(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
let WHITECOLOR = hexColor(hexStr: "FFFFFF")
//文字颜色
let TEXTGRAYCOLOR = hexColor(hexStr: "a0a0a0")

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
func AlertTwoSeconds(object: UIViewController, title: String){
    let ac = UIAlertController.init(title: title, message: nil, preferredStyle: .Alert)
    let action = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.Default, handler: nil)
    ac.addAction(action)
    dispatch_async(dispatch_get_main_queue(), {
        //延迟两秒后消失
        object.presentViewController(ac, animated: true, completion: nil)
        
//        ac.performSelector(#selector(UIAlertController.dismissViewControllerAnimated(_:completion:)), withObject: nil, afterDelay: 1)

    })

}

//MARK: — 创建导航条的返回按钮
func createBackButton(vc: GEBaseVC, action: Selector){
    
    let image = UIImage.init(named: "nav_back")?.imageWithRenderingMode(.AlwaysOriginal)
    let btn = UIButton.init(type: .System)
    btn.frame = CGRectMake(0, 0, 20, 20)
    btn.setBackgroundImage(image, forState: .Normal)
    btn.setBackgroundImage(image, forState: .Highlighted)
    btn.addTarget(vc, action: action, forControlEvents: .TouchUpInside)
    
    vc.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: btn)
}


//MARK: - 将距离当前时间的某时间点的年月日转为字符串
func stringFor(time: NSTimeInterval) -> String{
    let df = NSDateFormatter()
    df.dateFormat = "yyyy-MM-dd"
    let date = NSDate.init(timeIntervalSinceNow: time)
    
    return df.stringFromDate(date)
}


//MARK: - 副文本
/**副文本-修改某子串颜色*/
func AttributeText(color: UIColor, text: String, rangeStr: String) -> NSMutableAttributedString{
    let content = NSMutableString.init(string: text)
    let attr = NSMutableAttributedString.init(string: text)
    attr.addAttributes([NSForegroundColorAttributeName: color], range: content.rangeOfString(rangeStr))
    return attr
}
/**副文本-修改某子串颜色及字体*/
func AttributeText(color: UIColor, text: String, rangeStr: String, font: CGFloat) -> NSMutableAttributedString{
    let content = NSMutableString.init(string: text)
    let attr = NSMutableAttributedString.init(string: text)
    attr.addAttributes([NSForegroundColorAttributeName: color], range: content.rangeOfString(rangeStr))
    attr.addAttributes([NSFontAttributeName:UIFont.systemFontOfSize(font)], range: content.rangeOfString(rangeStr))
    return attr
}

//MARK: -字符串长度
extension String{
    func stringLength() -> NSInteger{
        return self.characters.count
    }
}


