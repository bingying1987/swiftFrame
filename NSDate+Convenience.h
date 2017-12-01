//
//  NSDate+convenience.h
//
//  Created by in 't Veen Tjeerd on 4/23/12.
//  Copyright (c) 2012 Vurig Media. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Convenience)

- (NSDate *)offsetMonth:(NSInteger)numMonths;
- (NSDate *)offsetDay:(NSInteger)numDays;
- (NSDate *)offsetHours:(NSInteger)hours;
/*
 这个月有多少天
 */
- (NSInteger) numDaysInMonth;
/*
 一个月的第一天是周几
 */
- (NSInteger) firstWeekDayInMonth;
- (NSInteger) year;
- (NSInteger) month;
- (NSInteger) day;
- (NSInteger) hour;
- (NSInteger) minute;

+ (NSDate *) dateStartOfDay:(NSDate *)date;
+ (NSDate *) dateStartOfWeek;
+ (NSDate *) dateEndOfWeek;

/**
 *
 *
 *  @param date    给定日期
 *  @param isToday 是否是今天
 *
 *  @return 将date日期封装成NSDictionary格式
 */
+ (NSDictionary *)getDate:(NSDate *)date isToday:(BOOL)isToday;
/**
 *  获取给定date后面delay天数的日期
 *
 *  @param aDate    给定日期
 *  @param delayDay 给定日期后面延后的天数
 *
 *
 */
+ (NSDate *)DateGetDelayDay:(NSDate *)aDate delay:(int)delayDay;
/**
 *  从当日开始创建一周的日期字典
 *
 *
 */
+ (NSMutableArray *)weekDailyDateList;
@end
