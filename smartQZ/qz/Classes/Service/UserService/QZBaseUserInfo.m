//
//  QZBaseUserInfo.m
//  qztourist
//
//  Created by 景彦铭 on 2016/11/27.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZBaseUserInfo.h"
#import "QZDateManager.h"
@implementation QZBaseUserInfo

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_expired forKey:@"expired"];
    [aCoder encodeDouble:_type forKey:@"type"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super init]){
        _expired = [aDecoder decodeObjectForKey:@"expired"];
        _type = [aDecoder decodeDoubleForKey:@"type"];
    }
    return self;
}

- (BOOL)saveObject {
    return [NSKeyedArchiver archiveRootObject:self toFile:[self savePath]];
    ;
}

+ (instancetype)getObject {
    return [NSKeyedUnarchiver unarchiveObjectWithFile: [[[self alloc]init]savePath]];
}

+ (BOOL)deleteObject {
    return [[NSFileManager defaultManager]removeItemAtPath:[[[self alloc]init]savePath] error:nil];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (NSString *)savePath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"userInfo.plist"];
}

- (void)loadInfo:(NSTimeInterval)expires_in type:(THIRDLOGIN)type {
    _expired = [QZDateManager dateWithTimeInterValSince1970:expires_in];
    _type = type;
}
@end
