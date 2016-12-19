//
//  QZQQHTTPManager.h
//  qztourist
//
//  Created by 景彦铭 on 2016/11/27.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "SEEHTTPManager.h"
#import "QZBaseUser.h"
#import "QZBaseUserInfo.h"
#import "QZQQUserInfo.h"
@interface QZQQHTTPManager : SEEHTTPManager

/**
 获取QQ用户信息
 */
- (void)getQQUserWithUserInfo:(QZQQUserInfo *)info complete:(void (^)(QZBaseUser *))complete;

/**
 获取QQ token
 */
- (void)getQQTokenWithCode:(NSString *)code complete:(void(^)(QZBaseUserInfo * userInfo))complete;

/**
 获取QQ oauth页面地址
 */
- (void)QQLoginURLComplete:(void(^)(NSURLRequest * request))complete;

@end
