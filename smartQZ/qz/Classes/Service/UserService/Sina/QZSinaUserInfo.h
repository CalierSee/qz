//
//  QZSinaUserInfo.h
//  qztourist
//
//  Created by 景彦铭 on 2016/11/27.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QZBaseUserInfo.h"
@interface QZSinaUserInfo : QZBaseUserInfo 

/**
 token
 */
@property (nonatomic,copy) NSString *access_token;

/**
 时效
 */
@property (nonatomic,assign)NSTimeInterval expires_in;

/**
 uid
 */
@property (nonatomic,copy) NSString *uid;


@end
