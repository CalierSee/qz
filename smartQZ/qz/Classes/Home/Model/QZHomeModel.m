//
//  QZHomeModel.m
//  qztourist
//
//  Created by 景彦铭 on 2016/12/9.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZHomeModel.h"

@implementation QZHomeModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"informations" : [QZInformationModel class]};
}

@end
