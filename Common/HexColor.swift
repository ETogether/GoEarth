//
//  HexColor.swift
//  aFirstBlood
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

//MARK: - 不带#
func hexColor(hexStr hex: String) -> UIColor{
    let str = NSString.init(string: hex)
    var red: UInt32 = 0
    var blue: UInt32 = 0
    var green: UInt32 = 0
    var range = NSRange()
    range.length = 2
    
    range.location = 0
    NSScanner.init(string: str.substringWithRange(range)).scanHexInt(&red)
    
    range.location = 2
    NSScanner.init(string: str.substringWithRange(range)).scanHexInt(&blue)
    
    range.location = 4
    NSScanner.init(string: str.substringWithRange(range)).scanHexInt(&green)
    
    
    return UIColor.init(red: CGFloat(red) / 255.0, green: CGFloat(blue) / 255.0, blue: CGFloat(green) / 255.0, alpha: 1)
    
}
//MARK: 带#号的字符串
func hexColor(hexStrJ hex: String) -> UIColor{
    let str = NSString.init(string: hex)
    var red: UInt32 = 0
    var blue: UInt32 = 0
    var green: UInt32 = 0
    var range = NSRange()
    range.length = 2
    
    range.location = 1
    NSScanner.init(string: str.substringWithRange(range)).scanHexInt(&red)
    
    range.location = 3
    NSScanner.init(string: str.substringWithRange(range)).scanHexInt(&blue)
    
    range.location = 5
    NSScanner.init(string: str.substringWithRange(range)).scanHexInt(&green)
    
    
    return UIColor.init(red: CGFloat(red) / 255.0, green: CGFloat(blue) / 255.0, blue: CGFloat(green) / 255.0, alpha: 1)
    
}