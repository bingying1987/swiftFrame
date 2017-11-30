//
//  UIColor+MyColorCategory.swift
//  swiftFrame
//
//  Created by MrWu on 2017/11/28.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
extension UIColor{
    static func colorWithHexRGB(RGB:Int) ->UIColor
    {
        let r = CGFloat(((RGB >> 16) & 0x00ff)) / 255.0
        let g = CGFloat(((RGB >> 8) & 0x0000ff)) / 255.0
        let b = CGFloat((RGB & 0xff)) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    static func colorWithHexRGBA(RGB:Int) ->UIColor
    {
        let r = CGFloat(((RGB >> 24) & 0xff)) / 255.0
        let g = CGFloat(((RGB >> 16) & 0x00ff)) / 255.0
        let b = CGFloat(((RGB >> 8) & 0x0000ff)) / 255.0
        let a = CGFloat((RGB & 0xff)) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}
