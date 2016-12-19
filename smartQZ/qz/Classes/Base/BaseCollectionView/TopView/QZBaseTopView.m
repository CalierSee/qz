//
//  QZBaseTopView.m
//  qztourist
//
//  Created by 景彦铭 on 2016/12/5.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZBaseTopView.h"

@interface QZBaseTopView ()

@end


@implementation QZBaseTopView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadUI];
    }
    return self;
}

- (void)loadUI {
    //添加banner
    SEEAdvertisementView * adv = [[SEEAdvertisementView alloc]init];
    [self addSubview:adv];
    adv.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 196);
    _advView = adv;
    
    
}


- (void)setAdvs:(NSArray<SEEAdvertisement *> *)advs {
    _advs = advs;
    _advView.advertisements = advs;
}

- (void)setIconArray:(NSArray<NSDictionary *> *)iconArray {
    _iconArray = iconArray;
}
@end
