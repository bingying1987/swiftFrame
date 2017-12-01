//
//  NSDate+convenience.m
//
//  Created by in MrWu on 4/23/12.
//  Copyright (c) 2012 Vurig Media. All rights reserved.
//

#import "NSDate+Convenience.h"

@implementation NSDate (Convenience)

- (NSInteger)year {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitYear fromDate:self];
    return [components year];
}


- (NSInteger)month {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitMonth fromDate:self];
    return [components month];
}

- (NSInteger)day {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitDay fromDate:self];
    return [components day];
}

- (NSInteger)hour
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitHour fromDate:self];
    return (int)[components hour];
}

- (NSInteger)minute
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitMinute fromDate:self];
    return (int)[components minute];
}


- (NSInteger)firstWeekDayInMonth {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setFirstWeekday:2]; //monday is first day
    //[gregorian setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"nl_NL"]];
    
    //Set date to first of month
    NSDateComponents *comps = [gregorian components:NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay fromDate:self];
    [comps setDay:1];
    NSDate *newDate = [gregorian dateFromComponents:comps];
    
    return [gregorian ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:newDate];
}

- (NSDate *)offsetMonth:(NSInteger)numMonths {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setFirstWeekday:2]; //monday is first day
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:numMonths];
    //[offsetComponents setHour:1];
    //[offsetComponents setMinute:30];
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:self options:0];
}

- (NSDate *)offsetHours:(NSInteger)hours {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setFirstWeekday:2]; //monday is first day
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    //[offsetComponents setMonth:numMonths];
    [offsetComponents setHour:hours];
    //[offsetComponents setMinute:30];
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:self options:0];
}

- (NSDate *)offsetDay:(NSInteger)numDays {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setFirstWeekday:2]; //monday is first day
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:numDays];
    //[offsetComponents setHour:1];
    //[offsetComponents setMinute:30];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:self options:0];
}



- (NSInteger)numDaysInMonth {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSRange rng = [cal rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    NSUInteger numberOfDaysInMonth = rng.length;
    return (int)numberOfDaysInMonth;
}

+ (NSDate *)dateStartOfDay:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *components =
    [gregorian components:(NSCalendarUnitYear | NSCalendarUnitMonth |
                           NSCalendarUnitDay) fromDate: date];
    return [gregorian dateFromComponents:components];
}

+ (NSDate *)dateStartOfWeek {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setFirstWeekday:2]; //monday is first day
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:[NSDate date]];
    
    NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
    [componentsToSubtract setDay: - ((([components weekday] - [gregorian firstWeekday])
                                      + 7 ) % 7)];
    NSDate *beginningOfWeek = [gregorian dateByAddingComponents:componentsToSubtract toDate:[NSDate date] options:0];
    
    NSDateComponents *componentsStripped = [gregorian components: (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
                                                        fromDate: beginningOfWeek];
    
    //gestript
    beginningOfWeek = [gregorian dateFromComponents: componentsStripped];
    
    return beginningOfWeek;
}

+ (NSDate *)dateEndOfWeek {
    NSCalendar *gregorian =[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:[NSDate date]];
    
    
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay: + (((([components weekday] - [gregorian firstWeekday])
                                  + 7 ) % 7))+6];
    NSDate *endOfWeek = [gregorian dateByAddingComponents:componentsToAdd toDate:[NSDate date] options:0];
    
    NSDateComponents *componentsStripped = [gregorian components: (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
                                                        fromDate: endOfWeek];
    
    //gestript
    endOfWeek = [gregorian dateFromComponents: componentsStripped];
    return endOfWeek;
}

+ (NSDictionary *)getDate:(NSDate *)date isToday:(BOOL)isToday{
    NSArray * arrWeek=[NSArray arrayWithObjects:@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:date];
    NSInteger week = [comps weekday];
    NSInteger year = [comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    NSString *arr_Date = [NSString stringWithFormat:@"%ld月%ld日",month,day];
    NSString *arr_Today = [NSString stringWithFormat:@"%ld",day];
    NSString *arr_Week = [NSString stringWithFormat:@"%@",[arrWeek objectAtIndex:week-1]];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"yyyy-MM-dd"];
    NSDateFormatter *monthDay = [[NSDateFormatter alloc] init];
    [monthDay setDateFormat:@"MM-dd"];
    NSString *date_day = [dateday stringFromDate:date];
    NSString *month_day = [monthDay stringFromDate:date];
    if(isToday == 1){
        //        [dict setValue:@"今天" forKey:@"week"];
        [dict setValue:arr_Week forKey:@"week"];
    }
    else{
        [dict setValue:arr_Week forKey:@"week"];
    }
    [dict setValue:date_day forKey:@"day"];
    [dict setValue:arr_Date forKey:@"month"];
    return dict;
}

+ (NSDate *)DateGetDelayDay:(NSDate *)aDate delay:(int)delayDay
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:aDate];
    [components setDay:([components day]+delayDay)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    return beginningOfWeek;
}

+ (NSMutableArray *)weekDailyDateList{
    NSMutableArray *weekList = [NSMutableArray array];
    NSDate *dateToday = [NSDate date];
    NSDate *date1 = [self DateGetDelayDay:dateToday delay:1];
    NSDate *date2 = [self DateGetDelayDay:dateToday delay:2];
    NSDate *date3 = [self DateGetDelayDay:dateToday delay:3];
    NSDate *date4 = [self DateGetDelayDay:dateToday delay:4];
    NSDate *date5 = [self DateGetDelayDay:dateToday delay:5];
    NSDate *date6 = [self DateGetDelayDay:dateToday delay:6];
    [weekList addObject:[self getDate:dateToday isToday:1]];
    [weekList addObject:[self getDate:date1 isToday:0]];
    [weekList addObject:[self getDate:date2 isToday:0]];
    [weekList addObject:[self getDate:date3 isToday:0]];
    [weekList addObject:[self getDate:date4 isToday:0]];
    [weekList addObject:[self getDate:date5 isToday:0]];
    [weekList addObject:[self getDate:date6 isToday:0]];
    return weekList;
}

@end
