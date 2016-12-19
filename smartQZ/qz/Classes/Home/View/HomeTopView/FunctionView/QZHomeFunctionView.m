//
//  QZHomeFunctionView.m
//  qz
//
//  Created by 景彦铭 on 2016/12/12.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZHomeFunctionView.h"

@interface QZHomeFunctionView ()


@end

@implementation QZHomeFunctionView


- (IBAction)functionButtonClick:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:FunctionButtonClick object:nil userInfo:@{@"sender": sender}];
}


@end
