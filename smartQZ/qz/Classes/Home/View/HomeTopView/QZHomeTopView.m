//
//  QZHomeTopView.m
//  qztourist
//
//  Created by 景彦铭 on 2016/12/5.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZHomeTopView.h"


@interface QZHomeTopView ()
@property(nonatomic,weak)QZHomeIconView *iconView;
@property(nonatomic,weak)QZHomeFunctionView *functionView;

@end

@implementation QZHomeTopView

- (void)loadUI {
    [super loadUI];
    //添加icon
    QZHomeIconView * iconView = [[QZHomeIconView alloc]init];
    [self addSubview:iconView];
    iconView.frame = CGRectMake(0, 196, [UIScreen mainScreen].bounds.size.width, 170);
    _iconView = iconView;
    //添加功能视图
    QZHomeFunctionView * functionView = [[UINib nibWithNibName:@"QZHomeFunctionView" bundle:nil] instantiateWithOwner:nil options:nil].firstObject;
    [self addSubview:functionView];
    functionView.frame = CGRectMake(0, 196 + 170 + 4, [UIScreen mainScreen].bounds.size.width, 190);
    _functionView = functionView;
}

- (void)setIconArray:(NSArray<NSDictionary *> *)iconArray {
    [super setIconArray:iconArray];
    _iconView.iconArray = iconArray;
}

@end
