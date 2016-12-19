//
//  QZDateManager.m
//  qztourist
//
//  Created by 景彦铭 on 2016/11/27.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZDateManager.h"

@implementation QZDateManager

+ (NSDate *)dateWithTimeInterValSince1970:(NSTimeInterval)time {
    NSDate * date = [NSDate dateWithTimeIntervalSinceNow:time];
    return date;
}



@end
