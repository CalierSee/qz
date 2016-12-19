//
//  QZBaseUserInfo.h
//  qztourist
//
//  Created by 景彦铭 on 2016/11/27.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QZBaseUserInfo : NSObject <NSCoding>
/**
 失效时间  since1670
 */
@property (nonatomic,strong)NSDate * expired;

/**
 账户类型
 */
@property (nonatomic,assign)NSInteger type;

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

/**
 加载失效时间和类型
 */
- (void)loadInfo:(NSTimeInterval)expires_in type:(THIRDLOGIN)type;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
