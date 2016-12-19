//
//  SEEAnimator.m
//  SEEQuick
//
//  Created by 景彦铭 on 2016/10/14.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "SEEAnimator.h"

@interface SEEAnimator () <UIViewControllerAnimatedTransitioning>

@end

@implementation SEEAnimator

#pragma mark - UIViewControllerTransitioningDelegate
//返回提供展现动画的对象
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning
//返回预计动画时长
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.0;
}

//返回展现视图的动画
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    //获取容器视图
    UIView * fromView = [transitionContext containerView];
    //获取要展现的视图
    UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    //将要展现的视图添加到容器视图
    [fromView addSubview:toView];
    //动画
    toView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        //告诉系统转场动画结束可以开始用户交互 如果不写就无法开启用户交互
        [transitionContext completeTransition:YES];
    }];
}


@end
