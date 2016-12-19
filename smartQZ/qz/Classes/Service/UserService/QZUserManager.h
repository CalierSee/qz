//
//  QZUserManager.h
//  qztourist
//
//  Created by 景彦铭 on 2016/11/23.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QZBaseUserInfo.h"
#import "QZBaseUser.h"

@interface QZUserManager : NSObject
//记录用户是否登录
@property (nonatomic,assign)BOOL isLogin;
//记录用户账户类型
@property (nonatomic,assign)THIRDLOGIN type;
//记录用户信息
@property(nonatomic,strong)QZBaseUser * user;
//记录用户配置信息
@property(nonatomic,strong)QZBaseUserInfo * userInfo;

+ (instancetype)sharedManager;



/**
 加载Oauth页面HTML字符串
 */
+ (void)oauthPageType:(THIRDLOGIN)type complete:(void(^)(NSURLRequest * request))complete;

/**
 获取user
 */
+ (void)getUserWithType:(THIRDLOGIN)type code:(NSString *)code complete:(void(^)(QZBaseUser * userInfo))complete;
@end
