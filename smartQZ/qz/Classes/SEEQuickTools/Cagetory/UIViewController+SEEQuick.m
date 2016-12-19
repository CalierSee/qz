//
//  UIViewController+SEEQuick.m
//  美团外卖
//
//  Created by 景彦铭 on 2016/10/12.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "UIViewController+SEEQuick.h"

@implementation UIViewController (SEEQuick)

- (void)addSubViewController:(UIViewController *)vc view:(UIView *)view {
    if(view){
        [view addSubview:vc.view];
    }
    else{
        [self.view addSubview:vc.view];
    }
    [self addChildViewController:vc];
    [vc didMoveToParentViewController:self];
}

@end
