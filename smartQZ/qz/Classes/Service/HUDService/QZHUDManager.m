//
//  QZHUDManager.m
//  qztourist
//
//  Created by 景彦铭 on 2016/11/27.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZHUDManager.h"

@implementation QZHUDManager

+ (void)show {
    [self showWithTitle:nil];
}

+ (void)showWithTitle:(NSString *)title {
    [SVProgressHUD showWithStatus:title];
}

+ (void)showWithImage:(UIImage *)image title:(NSString *)title {
    [SVProgressHUD showImage:image status:title];
}

+ (void)dismiss {
    [SVProgressHUD dismiss];
}


@end
