//
//  SEEHTTPManager.m
//  qztourist
//
//  Created by 景彦铭 on 2016/11/26.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "SEEHTTPManager.h"



@implementation SEEHTTPManager

+ (instancetype)sharedManager {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self manager];
    });
    return instance;
}

+ (void)requestWithMethod:(SEEMETHOD)method URL:(NSString *)url parameters:(id)parameters successBlock:(void(^)(id json))success failureBlock:(void(^)(NSError * error))failure {
    void (^successBlock)(NSURLSessionDataTask * task, id json) = ^(NSURLSessionDataTask * task, id json) {
        success(json);
    };
    void (^failureBlock)(NSURLSessionDataTask * task, NSError * error) = ^(NSURLSessionDataTask * task, NSError * error) {
        failure(error);
    };
    [self requestWithMethod:method URL:url parameters:parameters success:successBlock failure:failureBlock];
}

+ (void)requestWithMethod:(SEEMETHOD)method URL:(NSString *)url parameters:(id)parameters success:(void(^)(NSURLSessionDataTask * task, id json))success failure:(void(^)(NSURLSessionDataTask * task, NSError * error))failure {
    [self requestWithMethod:method URL:url parameters:parameters progress:nil success:success failure:failure];
}


+ (void)requestWithMethod:(SEEMETHOD)method URL:(NSString *)url parameters:(id)parameters progress:(void(^)(NSProgress * uploadProgress))uploadProgress success:(void(^)(NSURLSessionDataTask * task, id json))success failure:(void(^)(NSURLSessionDataTask * task, NSError * error))failure {
    switch (method) {
        case SEEMETHODGET:
            [[self sharedManager]GET:url parameters:parameters progress:uploadProgress success:success failure:failure];
            break;
        case SEEMETHODPOST:
            [[self sharedManager]POST:url parameters:parameters progress:uploadProgress success:success failure:failure];
            break;
            
        default:
            
            break;
    }
}
    
    
@end
