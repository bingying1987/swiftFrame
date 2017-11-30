//
//  CommonDefine.swift
//  swiftFrame
//
//  Created by MrWu on 2017/11/28.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import Foundation
func D_DEBUG<T>(message:T,fileName:String = #file,methodName:String = #function,lineNum:Int = #line)
{
    #if DEBUG
        if fileName.hasSuffix("swift") {
            var file = fileName;
            let range = fileName.index(fileName.endIndex, offsetBy: -6)..<fileName.endIndex
            file.removeSubrange(range)
            print("类: \(file) 方法\(methodName) 行:[\(lineNum)] 数据 \(message)")
        }
        
    #endif
}

//快速获取当前手机的设备尺寸
let DEVICE_WIDTH = UIScreen.main.bounds.size.width
let DEVICE_HEIGHT = UIScreen.main.bounds.size.height

//判断当前设备型号,为了方便我依然提取了一个扩展出来

func isIPhone4() ->Bool
{
    return UIScreen.main.currentMode?.size == CGSize(width: 640, height: 960)
}

func isIPhone5s() ->Bool
{
    return UIScreen.main.currentMode?.size == CGSize(width: 640, height: 1136)
}

func isIPhone6() ->Bool
{
    return UIScreen.main.currentMode?.size == CGSize(width: 750, height: 1334)
}

func isIPhone6P() ->Bool
{
    return UIScreen.main.currentMode?.size == CGSize(width: 1242, height: 2208)
}

func isIPhone6PBigMode() ->Bool
{
    return UIScreen.main.currentMode?.size == CGSize(width: 1125, height: 2001)
}

func isIPad() ->Bool
{
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad
}

func currentLanguage() ->String
{
    return NSLocale.preferredLanguages.first!
}

func systemVersion() ->String
{
    return UIDevice.current.systemVersion;
}

func appVersion() ->String
{
    return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
}

//常用字体
let APP_FONT_NAME = "ArialMT"
let APP_FONT_NAME_BOLD = "Arial-BoldMT"
let APP_FONT_NAME_BOLD_Italic = "Arial-BoldItalicMT"

//创建字体
func APP_FONT(fontName:String,fontSize:CGFloat) ->UIFont
{
    return UIFont(name: fontName, size: fontSize)!
}

func APP_FONT_WITH_DEFAULT(fontSize:CGFloat) ->UIFont
{
    return APP_FONT(fontName: APP_FONT_NAME, fontSize: fontSize)
}


