//
//  QZBaseUser.h
//  qztourist
//
//  Created by 景彦铭 on 2016/11/27.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QZBaseUser : NSObject <NSCoding>

/**
 存储用户信息
 */
- (BOOL)saveObject;

/**
 获取用户信息
 */
+ (instancetype)getObject;

/**
 用户退出登录后删除用户信息
 */
+ (BOOL)deleteObject;

- (NSString *)userName;

- (NSString *)userImage;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
