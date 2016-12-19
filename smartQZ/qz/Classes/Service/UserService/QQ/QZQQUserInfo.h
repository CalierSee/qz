//
//  QZQQUserInfo.h
//  qztourist
//
//  Created by 景彦铭 on 2016/12/1.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZBaseUserInfo.h"

@interface QZQQUserInfo : QZBaseUserInfo

/**
 token
 */
@property (nonatomic,copy) NSString *access_token;

/**
 时效
 */
@property (nonatomic,assign)NSTimeInterval expires_in;

/**
 刷新access_token所必须参数
 */
@property (nonatomic,copy) NSString *refresh_token;

@end
