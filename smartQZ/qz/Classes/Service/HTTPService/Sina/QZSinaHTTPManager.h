//
//  QZSinaHTTPManager.h
//  qztourist
//
//  Created by 景彦铭 on 2016/11/27.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "SEEHTTPManager.h"
#import "QZSinaUser.h"
#import "QZSinaUserInfo.h"
@interface QZSinaHTTPManager : SEEHTTPManager

/**
 获取sina用户信息
 */
- (void)getSinaUserWithUserInfo:(QZSinaUserInfo *)info complete:(void (^)(QZBaseUser *))complete;

/**
 获取sina token
 */
- (void)getSinaTokenWithCode:(NSString *)code complete:(void(^)(QZBaseUserInfo * userInfo))complete;

/**
 获取sina oauth页面地址
 */
- (void)sinaLoginURLComplete:(void(^)(NSURLRequest * request))complete;

@end
