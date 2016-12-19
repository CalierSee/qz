//
//  QZMineMenu.m
//  qztourist
//
//  Created by 景彦铭 on 2016/11/29.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZMineMenu.h"

@implementation QZMineMenu
- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if(self  = [super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)mineMenuWithDictionary:(NSDictionary *)dict{
    return [[self alloc]initWithDictionary:dict];
}


@end
