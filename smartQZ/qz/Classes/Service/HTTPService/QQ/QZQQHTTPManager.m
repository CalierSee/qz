//
//  QZQQHTTPManager.m
//  qztourist
//
//  Created by 景彦铭 on 2016/11/27.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZQQHTTPManager.h"
#import "QZQQUser.h"
@implementation QZQQHTTPManager

+ (instancetype)sharedManager {
    static QZQQHTTPManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]initWithBaseURL:[NSURL URLWithString:QQBaseURL]];
        NSMutableSet * set = [NSMutableSet setWithSet:instance.responseSerializer.acceptableContentTypes];
        [set addObject:@"text/html"];
        [set addObject:@"text/plain"];
        instance.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
        instance.responseSerializer.acceptableContentTypes = set;
        
    });
    return instance;
}

- (void)getQQUserWithUserInfo:(QZQQUserInfo *)info complete:(void (^)(QZBaseUser *))complete {
    NSString * str = QQOpenIDURL;
    NSDictionary * par = @{@"access_token":info.access_token,};
    [QZQQHTTPManager requestWithMethod:SEEMETHODGET URL:str parameters:par successBlock:^(id json) {
        NSString * str = [[NSString alloc]initWithData:json encoding:NSUTF8StringEncoding];
        NSString * openid = [str componentsSeparatedByString:@"openid\":\""][1];
        openid = [openid componentsSeparatedByString:@"\""][0];
        //oauth_consumer_key=100330589&access_token=470B16849963E961AE1D67CEBCCAC569&openid=026052BEE68525A8E8EFCFB54FF21CF7&format=json
//        NSDictionary * para = @{
//                                @"access_token":@"470B16849963E961AE1D67CEBCCAC569",
//                                @"oauth_consumer_key":@"100330589",
//                                @"openid":@"026052BEE68525A8E8EFCFB54FF21CF7",
//                                @"format":@"json"
//                                };
        NSDictionary * para = @{
                                @"access_token":info.access_token,
                                @"oauth_consumer_key":QQAppKey,
                                @"openid":openid,
                                @"format":@"json"
                                };
        //470B16849963E961AE1D67CEBCCAC569
        //AAFA5CA75FC67F5630252EB8443A2810
        //026052BEE68525A8E8EFCFB54FF21CF
        //EA445F2A17C62C9ECC8C0294ABF6F31A
        [QZQQHTTPManager requestWithMethod:SEEMETHODGET URL:QQUserAccountURL parameters:para successBlock:^(id json) {
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingAllowFragments error:nil];
            NSMutableDictionary * dicts = [NSMutableDictionary dictionaryWithDictionary:dict];
            [dicts setObject:openid forKey:@"openid"];
            QZQQUser * user = [[QZQQUser alloc]initWithDictionary:dicts];
                    [user saveObject];
                    complete(user);
        } failureBlock:^(NSError *error) {
            
        }];
    } failureBlock:^(NSError *error) {
        
    }];
}

- (void)getQQTokenWithCode:(NSString *)code complete:(void(^)(QZBaseUserInfo * userInfo))complete{
    NSDictionary * par = @{
                           @"client_id":QQAppKey,
                           @"client_secret":QQAppID,
                           @"grant_type":@"authorization_code",
                           @"code":code,
                           @"redirect_uri":QQOauthOKURL
                           };
    NSString * para = [NSString stringWithFormat:@"client_id=%@&client_secret=%@&grant_type=authorization_code&code=%@&redirect_uri=%@",QQAppKey,QQAppID,code,QQOauthOKURL];
    NSLog(@"%@",para);
    [QZQQHTTPManager requestWithMethod:SEEMETHODGET URL:QQTokenURL parameters:par successBlock:^(id json) {
        //NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingAllowFragments error:nil];
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        NSString * string = [[NSString alloc]initWithData:json encoding:NSUTF8StringEncoding];
        NSArray * array = [string componentsSeparatedByString:@"&"];
        for (NSString * str in array) {
            NSArray * a = [str componentsSeparatedByString:@"="];
            [dict setObject:a[1] forKey:a[0]];
        }
        QZQQUserInfo * userInfo = [[QZQQUserInfo alloc]initWithDict:dict];
        [userInfo saveObject];
        complete(userInfo);
    } failureBlock:^(NSError *error) {
        
    }];
}

- (void)QQLoginURLComplete:(void(^)(NSURLRequest * request))complete {
    NSMutableString * strM = [NSMutableString stringWithString:QQBaseURL];
    [strM appendString:QQOauthURL];
    [strM appendFormat:@"?%@",[NSString stringWithFormat:@"response_type=code&client_id=%@&redirect_uri=%@&&state=200&display=mobile",QQAppKey,QQOauthOKURL]];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strM]];
    request.HTTPMethod = @"GET";
    complete(request);
}

@end
