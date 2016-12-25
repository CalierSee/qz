//
//  QZDateManager.h
//  qztourist
//
//  Created by 景彦铭 on 2016/11/27.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * DateYearKey = @"DateYearKey";
static NSString * DateMonthKey = @"DateMonthKey";
static NSString * DateDayKey = @"DateDayKey";
static NSString * DateHourKey = @"DateHourKey";
static NSString * DateMinuteKey = @"DateMinuteKey";
static NSString * DateSecondKey = @"DateSecondKey";
static NSString * DateWeekdayKey = @"DateWeekdayKey";
static NSString * DateWeekOfYearKey = @"DateWeekOfYearKey";
static NSString * DateWeekOfMonthKey = @"DateWeekOfMonthKey";




@interface QZDateManager : NSObject

+ (instancetype)defaultManager;

+ (NSDate *)dateWithTimeInterValSince1970:(NSTimeInterval)time;

/**
 返回从今天开始之后的指定天数的日期组件
 星期、年、月、日、时、分、秒、一年中的周数
 */
+ (NSDictionary *)componentsForDayAfterToday:(NSInteger)day;

@end
