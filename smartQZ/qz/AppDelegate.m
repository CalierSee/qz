//
//  AppDelegate.m
//  qztourist
//
//  Created by 景彦铭 on 2016/11/12.
//  Copyright © 2016年 景彦铭. All rights reserved.
//
#define GUIDENUMBER 2
#import "AppDelegate.h"
#import "QZMainViewController.h"
#import "QZUserManager.h"
#import "QZGuideView.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <UMSocialCore/UMSocialCore.h>
@interface AppDelegate ()
@property(nonatomic,strong)NSArray<UIImage *> * images;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeRootViewController:) name:ChangeRootViewController object:nil];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = [[QZMainViewController alloc]init];
    
    [self showGuide];
    
    [self.window makeKeyAndVisible];
    
    //偏好设置
    [UIScrollView appearance].showsVerticalScrollIndicator = NO;
    [UIScrollView appearance].showsHorizontalScrollIndicator = NO;
    
    //地图授权
    [AMapServices sharedServices].apiKey = GDAppKey;
    
    [self getauthority];
    
    return YES;
}

- (void)getauthority {
    //打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
    
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMAppKey];
    
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAppKey appSecret:WXAppSecret redirectURL:@"http://mobile.umeng.com/social"];
    
    
    //设置分享到QQ互联的appKey和appSecret
    // U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAppKey  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    //设置新浪的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:SinaAppKey  appSecret:SinaAppSecret redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    
}

//显示引导
- (void)showGuide {
    if([[NSUserDefaults standardUserDefaults] valueForKey:@"guide"]){
        return ;
    }
    else {
        self.window.rootViewController = [QZGuideView guideWithImages:self.images frame:[UIScreen mainScreen].bounds];
        [[NSUserDefaults standardUserDefaults]setObject:@(1) forKey:@"guide"];
    }
}

- (NSArray<UIImage *> *)images {
    if(_images == nil){
        NSMutableArray * arrM = [NSMutableArray array];
        for (NSInteger i  = 0; i < GUIDENUMBER; i++) {
            @autoreleasepool {
                NSString * str = [NSString stringWithFormat:@"special%zd@2x.png",i];
                UIImage * image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:str ofType:nil]];
                [arrM addObject:image];
            }
        }
        _images = arrM.copy;
    }
    return _images;
}

- (void)changeRootViewController:(NSNotification *)notification {
    self.window.rootViewController = [[QZMainViewController alloc]init];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

@end
