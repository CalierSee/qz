//
//  QZHUDManager.h
//  qztourist
//
//  Created by 景彦铭 on 2016/11/27.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SVProgressHUD.h>
@interface QZHUDManager : NSObject

+ (void)show;
+ (void)showWithTitle:(NSString *)title;
+ (void)showWithImage:(UIImage *)image title:(NSString *)title;
+ (void)dismiss;

@end
