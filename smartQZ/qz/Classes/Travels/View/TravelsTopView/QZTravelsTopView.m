//
//  QZTravelsTopView.m
//  qztourist
//
//  Created by 景彦铭 on 2016/12/5.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZTravelsTopView.h"
#import "QZTravelsIconView.h"

@interface QZTravelsTopView ()
@property(nonatomic,weak)QZTravelsIconView *iconView;
@end

@implementation QZTravelsTopView

- (void)loadUI {
    [super loadUI];
//    //添加icon
//    QZTravelsIconView * iconView = [[QZTravelsIconView alloc]init];
//    [self addSubview:iconView];
//    iconView.frame = CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 200);
//    _iconView = iconView;
}

//- (void)setIconArray:(NSArray<NSDictionary *> *)iconArray {
//    [super setIconArray:iconArray];
//    _iconView.iconArray = iconArray;
//}

@end
