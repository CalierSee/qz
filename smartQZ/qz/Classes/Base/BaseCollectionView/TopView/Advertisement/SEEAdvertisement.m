//
//  SEEAdvertisement.m
//  SEEQuick
//
//  Created by 景彦铭 on 2016/9/25.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "SEEAdvertisement.h"

@implementation SEEAdvertisement
- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if(self  = [super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)advertisementWithDictionary:(NSDictionary *)dict{
    return [[self alloc]initWithDictionary:dict];
}


@end
