//
//  QZSinaHTTPManager.m
//  qztourist
//
//  Created by 景彦铭 on 2016/11/27.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZSinaHTTPManager.h"
@implementation QZSinaHTTPManager

+ (instancetype)sharedManager {
    static QZSinaHTTPManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]initWithBaseURL:[NSURL URLWithString:SinaBaseURL]];
        NSMutableSet * set = [NSMutableSet setWithSet:instance.responseSerializer.acceptableContentTypes];
        [set addObject:@"text/html"];
        [set addObject:@"text/plain"];
        instance.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
        instance.responseSerializer.acceptableContentTypes = set;
        
    });
    return instance;
}

- (void)getSinaUserWithUserInfo:(QZSinaUserInfo *)info complete:(void (^)(QZBaseUser *))complete {
    NSString * str = SinaUserAccountURL;
    NSDictionary * par = @{@"access_token":info.access_token,@"uid":info.uid};
    [QZSinaHTTPManager requestWithMethod:SEEMETHODGET URL:str parameters:par successBlock:^(id json) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingAllowFragments error:nil];
        QZSinaUser * user = [[QZSinaUser alloc]initWithDictionary:dict];
        [user saveObject];
        complete(user);
    } failureBlock:^(NSError *error) {
        
    }];
}

- (void)getSinaTokenWithCode:(NSString *)code complete:(void(^)(QZBaseUserInfo * userInfo))complete{
    NSDictionary * par = @{
                           @"client_id":SinaAppKey,
                           @"client_secret":SinaAppSecret,
                           @"grant_type":@"authorization_code",
                           @"code":code,
                           @"redirect_uri":SinaOauthOKURL
                           };
    [QZSinaHTTPManager requestWithMethod:SEEMETHODPOST URL:SinaTokenURL parameters:par successBlock:^(id json) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingAllowFragments error:nil];
        QZSinaUserInfo * userInfo = [[QZSinaUserInfo alloc]initWithDict:dict];
        [userInfo saveObject];
        complete(userInfo);
    } failureBlock:^(NSError *error) {
        
    }];
}

- (void)sinaLoginURLComplete:(void(^)(NSURLRequest * request))complete {
    NSMutableString * strM = [NSMutableString stringWithString:SinaBaseURL];
    [strM appendString:SinaOauthURL];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strM]];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [[NSString stringWithFormat:@"client_id=%@&redirect_uri=%@",SinaAppKey,SinaOauthOKURL] dataUsingEncoding:NSUTF8StringEncoding];
    complete(request);
}

@end
