//
//  QZSinaUser.h
//  qztourist
//
//  Created by 景彦铭 on 2016/11/27.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QZBaseUser.h"

typedef enum {
    SINAUNKNOW = 0,
    SINAMAN = 1,
    SINAWOMAN = 2
}SINAGENDER;

@interface QZSinaUser : QZBaseUser

/**
 uid
 */
@property (nonatomic,copy) NSString *idstr;

/**
 昵称
 */
@property (nonatomic,copy) NSString *screen_name;

/**
 用户头像50*50
 */
@property (nonatomic,copy) NSString *profile_image_url;

/**
 用户微博账号
 */
@property (nonatomic,copy) NSString *weihao;

/**
 性别
 */
@property (nonatomic,assign) SINAGENDER gender;

/**
 用户头像180*180
 */
@property (nonatomic,copy) NSString *avatar_large;

/**
 用户头像 hd
 */
@property (nonatomic,copy) NSString *avatar_hd;



@end
