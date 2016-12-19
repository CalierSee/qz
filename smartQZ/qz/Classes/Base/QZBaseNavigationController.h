//
//  QZBaseNavigationController.h
//  qztourist
//
//  Created by 景彦铭 on 2016/11/20.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,HiddenCustomMode) {
    HiddenCustomModeHidden = 1,
    HiddenCustomModeShow
};

@interface QZBaseNavigationController : UINavigationController

@property (nonatomic,assign)HiddenCustomMode hiddenCustomMode;

@property(nonatomic,strong)UIView *see_navigationItem;

@end
