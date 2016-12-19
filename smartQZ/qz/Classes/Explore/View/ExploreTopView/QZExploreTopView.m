//
//  QZExploreTopView.m
//  qztourist
//
//  Created by 景彦铭 on 2016/12/5.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZExploreTopView.h"
#import "QZExploreIconView.h"
#import "QZExploreHeaderFootView.h"
@interface QZExploreTopView ()
@property(nonatomic,weak)QZExploreIconView *iconView;
@end

@implementation QZExploreTopView

- (void)loadUI {
    [super loadUI];
    //添加icon
    QZExploreIconView * iconView = [[QZExploreIconView alloc]init];
    [self addSubview:iconView];
    iconView.frame = CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 200);
    _iconView = iconView;
    QZExploreHeaderFootView * foot = [[QZExploreHeaderFootView alloc]initWithFrame:CGRectMake(0, 400, [UIScreen mainScreen].bounds.size.width, 50)];
    [self addSubview:foot];
    
}

- (void)setIconArray:(NSArray<NSDictionary *> *)iconArray {
    [super setIconArray:iconArray];
    _iconView.iconArray = iconArray;
}

@end
