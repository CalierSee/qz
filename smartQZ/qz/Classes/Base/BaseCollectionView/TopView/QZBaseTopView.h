//
//  QZBaseTopView.h
//  qztourist
//
//  Created by 景彦铭 on 2016/12/5.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SEEAdvertisement.h"
#import "SEEAdvertisementView.h"
#import "QZBaseIconView.h"
@interface QZBaseTopView : UICollectionViewCell
@property(nonatomic,weak)SEEAdvertisementView *advView;
@property(nonatomic,strong)NSArray<NSDictionary *> * iconArray;
@property(nonatomic,strong)NSArray<SEEAdvertisement *> * advs;
- (void)loadUI;

//重写set为自定义iconview赋值
- (void)setIconArray:(NSArray<NSDictionary *> *)iconArray;

@end
