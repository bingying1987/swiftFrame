//
//  CommonDefine.h
//  ZSJY
//
//  Created by MrWu on 17/4/24.
//  Copyright © 2017年 mac. All rights reserved.
//

#ifndef CommonDefine_h
#define CommonDefine_h

//改进的debug
#ifdef DEBUG
#   define NSLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define NSLog(...)
#endif

//快速获取当前手机的设备尺寸
#define DEVICE_WIDTH [UIScreen mainScreen].bounds.size.width
#define DEVICE_HEIGHT [UIScreen mainScreen].bounds.size.height

//判断当前设备型号,为了方便我依然提取了一个扩展出来
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone(x,y) ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(x, y), [[UIScreen mainScreen] currentMode].size) : NO)

#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//常用的字体名
#define APP_FONT_NAME @"ArialMT"
#define APP_FONT_NAME_BOLD @"Arial-BoldMT"
#define APP_FONT_NAME_BOLD_Italic  @"Arial-BoldItalicMT"

//创建字体
#define APP_FONT(fontname, fontsize) [UIFont fontWithName: fontname size: fontsize]
#define APP_FONT_WTIH_DEFAULT(fontsize) APP_FONT(APP_FONT_NAME, fontsize)
#endif /* CommonDefine_h */
