//
//  QZExploreHeaderFootView.m
//  qztourist
//
//  Created by 景彦铭 on 2016/12/5.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZExploreHeaderFootView.h"
#import "QZExploreButton.h"
@implementation QZExploreHeaderFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadUI];
    }
    return self;
}

- (void)loadUI {
    QZExploreButton * left = [[QZExploreButton alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width / 2, 50)];
    left.backgroundColor = [UIColor redColor];
    [left addSubview:[[UIButton alloc]initWithFrame:left.bounds]];
    QZExploreButton * right = [[QZExploreButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2, 0, [UIScreen mainScreen].bounds.size.width / 2, 50)];
    right.backgroundColor = [UIColor blueColor];
    [self addSubview:left];
    [self addSubview:right];
}

@end
