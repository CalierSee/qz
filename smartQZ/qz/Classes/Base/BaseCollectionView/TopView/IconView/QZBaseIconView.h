//
//  QZBaseIconView.h
//  qztourist
//
//  Created by 景彦铭 on 2016/12/5.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QZBaseIconButton.h"
#define IconButtonClickNotification @"IconButtonClickNotification"
@interface QZBaseIconView : UIView
@property(nonatomic,strong)NSArray <NSDictionary *> * iconArray;
//每行几个button
- (NSInteger)numberOfLineInView;
//button的frame
- (CGSize)sizeForButton;
@end
