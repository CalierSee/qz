//
//  QZGuideViewController.m
//  qztourist
//
//  Created by 景彦铭 on 2016/11/12.
//  Copyright © 2016年 景彦铭. All rights reserved.
//
#define GUIDENUMBER 2
#import "QZGuideViewController.h"
#import "QZGuideImageViewController.h"
@interface QZGuideViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
{
    NSInteger _currentIndex;
}
@property(nonatomic,strong)NSArray <NSString *> * imageNames;
@end

@implementation QZGuideViewController
#pragma mark - 生命周期
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 载入UI界面
- (void)loadUI {
    UIPageViewController * pageVC = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    [self.view addSubview:pageVC.view];
    [self addChildViewController:pageVC];
    [pageVC didMoveToParentViewController:self];
    pageVC.dataSource = self;
    pageVC.delegate = self;
    
    QZGuideImageViewController * startGuidImageVC = [QZGuideImageViewController guideImageViewControllerWithImageName:self.imageNames[0]];
    [pageVC setViewControllers:@[startGuidImageVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    _currentIndex = 0;
}

- (NSArray<NSString *> *)imageNames {
    if(_imageNames == nil){
        NSMutableArray * arrM = [NSMutableArray array];
        for (NSInteger i  = 0; i < GUIDENUMBER; i++) {
            @autoreleasepool {
                NSString * str = [NSString stringWithFormat:@"special%zd@2x.png",i];
                [arrM addObject:str];
            }
        }
        _imageNames = arrM.copy;
    }
    return _imageNames;
}

#pragma mark - UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    _currentIndex += 1;
    if(_currentIndex == self.imageNames.count){
        return [[UIViewController alloc]init];
    }
    QZGuideImageViewController * guidImageVC = [QZGuideImageViewController guideImageViewControllerWithImageName:self.imageNames[_currentIndex]];
    return guidImageVC;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    return nil;
}

#pragma mark - UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if(_currentIndex == _imageNames.count){
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }
}


@end
