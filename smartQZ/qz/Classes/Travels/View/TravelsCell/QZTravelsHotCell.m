//
//  QZTravelsHotCell.m
//  qz
//
//  Created by 景彦铭 on 2016/12/17.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZTravelsHotCell.h"
#import "QZTravelsHotCollectionViewController.h"

@interface QZTravelsHotCell ()

@property(nonatomic,strong)QZTravelsHotCollectionViewController * content;

@end


@implementation QZTravelsHotCell

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        QZTravelsHotCollectionViewController * vc = [[QZTravelsHotCollectionViewController alloc]init];
        vc.view.frame = CGRectMake(8, 0, [UIScreen mainScreen].bounds.size.width - 16, 112);
        [self.contentView addSubview:vc.view];
        _content = vc;
    }
    return self;
}

- (void)setInformations:(NSArray<QZInformationModel *> *)informations {
    _informations = informations;
    _content.informations = informations;
}

@end
