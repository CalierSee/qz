//
//  QZUserManager.m
//  qztourist
//
//  Created by 景彦铭 on 2016/11/23.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZUserManager.h"
#import "QZSqliteManager.h"
#import "QZSinaHTTPManager.h"
#import "QZQQHTTPManager.h"
#import <YYModel.h>
@interface QZUserManager ()

@property(nonatomic,weak)QZSqliteManager * sqliteManager;

@end


@implementation QZUserManager

+ (instancetype)sharedManager {
    static id manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[QZUserManager alloc]init];
    });
    return manager;
}

- (QZSqliteManager *)sqliteManager {
    if(_sqliteManager == nil){
        _sqliteManager = [QZSqliteManager shareManager];
    }
    return _sqliteManager;
}

+ (void)oauthPageType:(THIRDLOGIN)type complete:(void(^)(NSURLRequest * request))complete {
    switch (type) {
        case THIRDLOGINDQQ:
            [[QZQQHTTPManager sharedManager]QQLoginURLComplete:complete];
            break;
        case THIRDLOGINSINA:
            [[QZSinaHTTPManager sharedManager]sinaLoginURLComplete:complete];
            break;
        case THIRDLOGINWECHAT:
            
            break;
    }
}

+ (void)getUserWithType:(THIRDLOGIN)type code:(NSString *)code complete:(void (^)(QZBaseUser *))complete {
    [[QZUserManager sharedManager]getTokenWithType:type code:code complete:^(QZBaseUserInfo *userInfo) {
        [[QZUserManager sharedManager]getUserWithUserInfo:userInfo complete:complete];
    }];
}


- (void)getTokenWithType:(THIRDLOGIN)type code:(NSString *)code complete:(void(^)(QZBaseUserInfo * userInfo))complete {
    void(^userInfoComplete)(QZBaseUserInfo * userInfo) = ^(QZBaseUserInfo *userInfo) {
        complete(userInfo);
        [QZUserManager sharedManager].type = type;
        [QZUserManager sharedManager].userInfo = userInfo;
    };
    switch (type) {
        case THIRDLOGINDQQ:
            [[QZQQHTTPManager sharedManager] getQQTokenWithCode:code complete:userInfoComplete];
            break;
        case THIRDLOGINSINA:
            [[QZSinaHTTPManager sharedManager]getSinaTokenWithCode:code complete:userInfoComplete];
            break;
        case THIRDLOGINWECHAT:
            break;
    }
}

- (void)getUserWithUserInfo:(QZBaseUserInfo *)userInfo complete:(void (^)(QZBaseUser *))complete{
    void(^userComplete)(QZBaseUser *user) = ^(QZBaseUser *user) {
        complete(user);
        [QZUserManager sharedManager].user = user;
    };
    switch (userInfo.type) {
        case THIRDLOGINDQQ:
        {
            [[QZQQHTTPManager sharedManager]getQQUserWithUserInfo:(QZQQUserInfo *)userInfo complete:userComplete];
        }
            break;
        case THIRDLOGINWECHAT:
        {
            
        }
            break;
        case THIRDLOGINSINA:
        {
            [[QZSinaHTTPManager sharedManager]getSinaUserWithUserInfo:(QZSinaUserInfo *)userInfo complete:userComplete];
            
        }
            break;
    }
}

- (QZBaseUserInfo *)getUserInfo {
    QZBaseUserInfo * userInfo = [QZBaseUserInfo getObject];
    return userInfo;
}


- (QZBaseUser *)getUser {
    QZBaseUser * user = [QZBaseUser getObject];
    return user;
}

- (BOOL)isLogin {
    return [self.userInfo.expired compare:[NSDate date]] == NSOrderedDescending ? YES : NO;
}

- (THIRDLOGIN)type {
    if(_type == 0){
        _type = (THIRDLOGIN)self.userInfo.type;
    }
    return _type;
}

- (QZBaseUserInfo *)userInfo {
    if(_userInfo == nil) {
        _userInfo = [self getUserInfo];
    }
    return _userInfo;
}

- (QZBaseUser *)user {
    if(_user == nil){
        _user = [self getUser];
    }
    return _user;
}

@end
