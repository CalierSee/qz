//
//  QZDateManager.m
//  qztourist
//
//  Created by 景彦铭 on 2016/11/27.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZDateManager.h"

@interface QZDateManager ()



@end


@implementation QZDateManager

+ (instancetype)defaultManager {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

+ (NSDictionary *)componentsForDayAfterToday:(NSInteger)day {
    //=============  获得当前日期  =============//
    NSTimeInterval timeInterval = day * 60 * 60 * 24;
    NSDate * date = [NSDate dateWithTimeIntervalSinceNow:timeInterval];
    //=============  获得日期组件  =============//
    NSCalendar * calender = [NSCalendar currentCalendar];
    NSDateComponents * components = [calender components:
                        NSCalendarUnitYear |
                        NSCalendarUnitMonth |
                        NSCalendarUnitDay |
                        NSCalendarUnitHour |
                        NSCalendarUnitMinute |
                        NSCalendarUnitSecond |
                        NSCalendarUnitWeekday |
                        NSCalendarUnitWeekOfMonth |
                        NSCalendarUnitWeekOfYear
        fromDate:date];
    NSString * weekDay;
    switch (components.weekday) {
        case 1:
            weekDay = @"星期日";
            break;
        case 2:
            weekDay = @"星期一";
            break;
        case 3:
            weekDay = @"星期二";
            break;
        case 4:
            weekDay = @"星期三";
            break;
        case 5:
            weekDay = @"星期四";
            break;
        case 6:
            weekDay = @"星期五";
            break;
        case 7:
            weekDay = @"星期六";
            break;
    }
    NSDictionary * dict = @{
            DateYearKey: @(components.year),
            DateMonthKey: @(components.month),
            DateDayKey: @(components.day),
            DateHourKey: @(components.hour),
            DateMinuteKey: @(components.minute),
            DateSecondKey: @(components.second),
            DateWeekdayKey: weekDay,
            DateWeekOfYearKey: @(components.weekOfYear),
            DateWeekOfMonthKey: @(components.weekOfMonth),
            };
    return dict;
}



+ (NSDate *)dateWithTimeInterValSince1970:(NSTimeInterval)time {
    NSDate * date = [NSDate dateWithTimeIntervalSinceNow:time];
    return date;
}



@end
