//
//  QZSinaUserInfo.m
//  qztourist
//
//  Created by 景彦铭 on 2016/11/27.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZSinaUserInfo.h"
@implementation QZSinaUserInfo
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:_access_token forKey:@"access_token"];
    [aCoder encodeDouble:_expires_in forKey:@"expires_in"];
    [aCoder encodeObject:_uid forKey:@"uid"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]){
        _access_token = [aDecoder decodeObjectForKey:@"access_token"];
        _expires_in = [aDecoder decodeDoubleForKey:@"expires_in"];
        _uid = [aDecoder decodeObjectForKey:@"uid"];
    }
    return self;
}

- (void)setExpires_in:(NSTimeInterval)expires_in {
    _expires_in = expires_in;
    [self loadInfo:expires_in type:THIRDLOGINSINA];
}

@end
