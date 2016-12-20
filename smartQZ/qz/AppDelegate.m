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
    
    return YES;
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

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
