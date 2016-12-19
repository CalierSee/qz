//
//  NSArray+SEEQuick.h
//  支付宝
//
//  Created by 景彦铭 on 16/9/16.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface NSArray (SEEQuick)

///  根据plist返回一个模型数组
///
///  @param name  plist文件名
///  @param cla  模型类
+ (instancetype)see_arrayWithPlist:(NSString *)name modeClass:(Class)cla;
@end
