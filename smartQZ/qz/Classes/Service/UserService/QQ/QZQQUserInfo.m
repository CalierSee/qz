//
//  QZQQUserInfo.m
//  qztourist
//
//  Created by 景彦铭 on 2016/12/1.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZQQUserInfo.h"

@implementation QZQQUserInfo
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:_access_token forKey:@"access_token"];
    [aCoder encodeDouble:_expires_in forKey:@"expires_in"];
    [aCoder encodeObject:_refresh_token forKey:@"refresh_token"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]){
        _access_token = [aDecoder decodeObjectForKey:@"access_token"];
        _expires_in = [aDecoder decodeDoubleForKey:@"expires_in"];
        _refresh_token = [aDecoder decodeObjectForKey:@"refresh_token"];
    }
    return self;
}

- (void)setExpires_in:(NSTimeInterval)expires_in {
    _expires_in = expires_in;
    [self loadInfo:expires_in type:THIRDLOGINDQQ];
}

@end
