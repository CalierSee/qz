//
//  NSArray+SEEQuick.m
//  支付宝
//
//  Created by 景彦铭 on 16/9/16.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "NSArray+SEEQuick.h"

@implementation NSArray (SEEQuick)

+ (instancetype)see_arrayWithPlist:(NSString *)name modeClass:(Class)cla {
    NSArray * arr = [NSArray arrayWithContentsOfURL:[[NSBundle mainBundle]URLForResource:name withExtension:nil]];
    NSMutableArray * arrM = [NSMutableArray array];
    for (NSDictionary *dict in arr) {
        id mode = [[cla alloc]initWithDictionary:dict];
        [arrM addObject:mode];
    }
    return arrM.copy;
}

@end
