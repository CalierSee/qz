//
//  SEEHTTPManager.h
//  qztourist
//
//  Created by 景彦铭 on 2016/11/26.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
typedef enum {
    SEEMETHODGET,
    SEEMETHODPOST,
    SEEMETHODHEAD
}SEEMETHOD;
@interface SEEHTTPManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

/**
 success只有数据 failure只有错误信息  没有task

 @param method 请求方式
 @param url url
 @param parameters 参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestWithMethod:(SEEMETHOD)method URL:(NSString *)url parameters:(id)parameters successBlock:(void(^)(id json))success failureBlock:(void(^)(NSError * error))failure;


/**
 删除进度

 @param method 请求方法
 @param url url
 @param parameters 参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestWithMethod:(SEEMETHOD)method URL:(NSString *)url parameters:(id)parameters success:(void(^)(NSURLSessionDataTask * task, id json))success failure:(void(^)(NSURLSessionDataTask * task, NSError * error))failure;

/**
 完整

 @param method 请求方法
 @param url url
 @param parameters 参数
 @param uploadProgress 进度
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestWithMethod:(SEEMETHOD)method URL:(NSString *)url parameters:(id)parameters progress:(void(^)(NSProgress * uploadProgress))uploadProgress success:(void(^)(NSURLSessionDataTask * task, id json))success failure:(void(^)(NSURLSessionDataTask * task, NSError * error))failure;
@end
