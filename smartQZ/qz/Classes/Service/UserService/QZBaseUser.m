//
//  QZBaseUser.m
//  qztourist
//
//  Created by 景彦铭 on 2016/11/27.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZBaseUser.h"
#import "QZSinaUser.h"
@implementation QZBaseUser

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super init]){
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
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

- (NSString *)savePath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"user.plist"];
}

- (NSString *)userName {
    if ([self isKindOfClass:[QZSinaUser class]]){
        return ((QZSinaUser *)self).screen_name;
    }
    return nil;
}

- (NSString *)userImage {
    if ([self isKindOfClass:[QZSinaUser class]]){
        return ((QZSinaUser *)self).profile_image_url;
    }
    return nil;
}

@end
