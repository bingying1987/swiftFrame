//
//  NSString+NSString_MyString.h
//  ZSJY
//
//  Created by MrWu on 17/4/25.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#include <CommonCrypto/CommonCryptor.h>  //常用加解密算法
#include <CommonCrypto/CommonDigest.h>  //摘要算法
#include <CommonCrypto/CommonHMAC.h>
#include <CommonCrypto/CommonKeyDerivation.h>
#include <CommonCrypto/CommonSymmetricKeywrap.h>

@interface NSString (MyString)
#pragma mark =====这里主要是为tableView索引服务
+ (NSMutableArray*)ReturnSortChineseArrar:(NSArray*)DataArr SortIndex:(NSString*)SortIndex type:(NSInteger)type bOrder:(BOOL)bOrder;
+ (NSMutableArray*)IndexArray:(NSArray*)SortedArr;
+ (NSMutableArray*)LetterSortArray:(NSArray*)SortedArr;
#pragma mark =====这里是验证判断字符串是否满足各种条件=======
//判断是否为空
- (BOOL)isNullOrEmpty;
//验证邮箱
- (BOOL)validateEmail;
//手机号码验证
- (BOOL)validateMobile;
//车牌号验证
- (BOOL)validateCarNo;
//车型验证
- (BOOL)validateCarType;
//用户名验证(6-20位)
- (BOOL)validateUserName;
//密码验证(6-20位)
- (BOOL)validatePassword;
//验证是否满足传入的正则表达式
- (BOOL)validateCheck:(NSString*)strPredicate;

#pragma mark =====这里是尽兴时间相关的一些字符串处理
//计算字符串所需高度，这里是把字符串当做段落来计算，因此可以自定义lineSpace,horizonSpace
//horizonSpace为两个字之间的间距，lineSpace为行间距,
//如果需要额外设置字体，颜色等属性，可以在调用函数前自行添加
- (float)calculateHeightForString:(NSMutableAttributedString *)attibutedString byWidth:(float)width lineSpace:(float)lineSpace;
- (float)calculateHeightForString:(NSMutableAttributedString *)attibutedString byWidth:(float)width lineSpace:(float)lineSpace horizonSpace:(float)horizonSpace;
//与当前本地时间进行比较
- (NSString *)compareTime:(NSString *)dataString;
//让传入的两个时间进行比较
- (NSString *)compareTime:(NSString *)dataString CompareToData:(NSString *)CompareTime;

#pragma mark =====这里是一些常见加密解密算法相关
- (NSString *)encodeBase64;
- (NSString *)decodeBase64;
- (NSString *)aes256_encrypt:(NSString *)key;
- (NSString *)aes256_decrypt:(NSString *)key;
- (NSString *)md5HexDigest;
- (NSString *)sha256HexDigest;
@end
