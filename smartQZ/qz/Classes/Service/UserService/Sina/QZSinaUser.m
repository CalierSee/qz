//
//  QZSinaUser.m
//  qztourist
//
//  Created by 景彦铭 on 2016/11/27.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZSinaUser.h"

@implementation QZSinaUser

- (void)setValue:(id)value forKey:(NSString *)key {
    if([key isEqualToString:@"gender"]){
        if([value isEqualToString:@"m"]){
            [super setValue:@(SINAMAN) forKey:key];
            return ;
        }
        else if([value isEqualToString:@"f"]){
            [super setValue:@(SINAWOMAN) forKey:key];
            return ;
        }
        else {
            [super setValue:@(SINAUNKNOW) forKey:key];
            return ;
        }
    }
    [super setValue:value forKey:key];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:_idstr forKey:@"idstr"];
    [aCoder encodeObject:_screen_name forKey:@"screen_name"];
    [aCoder encodeObject:_profile_image_url forKey:@"profile_image_url"];
    [aCoder encodeObject:_weihao forKey:@"weihao"];
    [aCoder encodeObject:_avatar_large forKey:@"avatar_large"];
    [aCoder encodeObject:_avatar_hd forKey:@"avatar_hd"];
    [aCoder encodeInt:_gender forKey:@"gender"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]){
        _idstr = [aDecoder decodeObjectForKey:@"idstr"];
        _screen_name = [aDecoder decodeObjectForKey:@"screen_name"];
        _profile_image_url = [aDecoder decodeObjectForKey:@"profile_image_url"];
        _weihao = [aDecoder decodeObjectForKey:@"weihao"];
        _avatar_large = [aDecoder decodeObjectForKey:@"avatar_large"];
        _avatar_hd = [aDecoder decodeObjectForKey:@"avatar_hd"];
        _gender = [aDecoder decodeIntForKey:@"gender"];
    }
    return self;
}

@end
