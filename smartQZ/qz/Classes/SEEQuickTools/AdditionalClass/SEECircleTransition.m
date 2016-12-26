//
//  SEECircleTransition.m
//  SEECircleTransition
//
//  Created by 景彦铭 on 2016/12/16.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "SEECircleTransition.h"
static NSTimeInterval animationDuration = 0.5;
@interface SEECircleTransition ()<UIViewControllerAnimatedTransitioning,CAAnimationDelegate>

@property (nonatomic,assign)BOOL isCustom;

@property (nonatomic,assign)BOOL isPresent;

@property(nonatomic,weak)id<UIViewControllerContextTransitioning> transitionContext;

@end

@implementation SEECircleTransition

- (void)animateWithView:(UIView *)view {
    //创建遮罩图层
    CAShapeLayer * layer = [[CAShapeLayer alloc]init];
    //设置遮罩图层
    view.layer.mask = layer;
    
    CGFloat viewWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat viewHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat margin = 20;
    CGFloat beginRadius = 30;
    CGRect beginRect = CGRectZero;
    if (!_isCustom){
        //动画中心点 （圆心中心点,如果要改变动画起始位置请求改这里）
        CGPoint animationCenter = CGPointMake(viewWidth - margin - beginRadius, margin + beginRadius / 2 );
        //展现大小
        beginRect = CGRectMake(animationCenter.x - beginRadius , animationCenter.y - beginRadius / 2, 2 * beginRadius, 2 * beginRadius);
    }
    else {
        beginRect = CGRectMake(_animationRect.origin.x, _animationRect.origin.y, (_animationRect.size.width + _animationRect.size.height) / 2, (_animationRect.size.width + _animationRect.size.height) / 2);
    }
    //创建内切圆路径
    UIBezierPath * beginPath = [UIBezierPath bezierPathWithOvalInRect:beginRect];
    
    CGFloat endRadius = sqrt(viewWidth * viewWidth + viewHeight * viewHeight);
    //消失大小
    CGRect endRect = CGRectInset(beginRect, -endRadius, -endRadius);
    //创建消失内切圆路径
    UIBezierPath * endPath = [UIBezierPath bezierPathWithOvalInRect:endRect];
    
    //创建动画
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (__bridge id _Nullable)(_isPresent ? beginPath.CGPath : endPath.CGPath);
    animation.toValue = (__bridge id _Nullable)(_isPresent ? endPath.CGPath : beginPath.CGPath);
    animation.duration = [self transitionDuration:_transitionContext];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.delegate = self;
    [layer addAnimation:animation forKey:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    _isPresent = YES;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    _isPresent = NO;
    return self;
}
#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return animationDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    //1. 得到容器视图
    UIView * container = [transitionContext containerView];
    //2. 得到被展现的视图
    UIView * view = [transitionContext viewForKey:UITransitionContextToViewKey];
    if (!view) {
        view = [transitionContext viewForKey:UITransitionContextFromViewKey];
    }
    //3. 将被展现的视图添加到容器视图
    [container addSubview:view];
    //4. 动画
    [self animateWithView:view];
    //5. 记录上下文在动画结束后告诉上下文转场结束
    _transitionContext = transitionContext;
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    //告诉上下文转场结束 开启用户交互
    [_transitionContext completeTransition:YES];
}

- (void)setAnimationRect:(CGRect)animationRect {
    _animationRect = animationRect;
    _isCustom = YES;
}

@end
