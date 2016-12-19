//
//  QZGuideView.m
//  qztourist
//
//  Created by 景彦铭 on 2016/11/12.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZGuideView.h"
#import "QZLoginViewController.h"
#import "QZBaseNavigationController.h"
#import "QZUserManager.h"
@interface QZGuideView ()
{
    NSInteger _currentIndex;
}

@property(nonatomic,strong)NSArray <UIImage *> * images;

@property(nonatomic,weak)UIImageView *imageView;

@property(nonatomic,strong)UINavigationController * nav;

@property(nonatomic,weak)UIView * backView;

@end

@implementation QZGuideView

+ (instancetype)guideWithImages:(NSArray<UIImage *> *)images frame:(CGRect)frame{
    QZGuideView * guidV = [[QZGuideView alloc]init];
    [guidV loadImages:images];
    return guidV;
}

- (void)loadImages:(NSArray <UIImage *> *)images {
    _images = images;
}

#pragma mark - 载入UI界面
- (void)loadUI {
    self.view.backgroundColor = [UIColor redColor];
    UIView * backView = [[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:backView];
    _backView = backView;
    UIImageView * imageV = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageV.backgroundColor = [UIColor whiteColor];
    [backView addSubview:imageV];
    imageV.userInteractionEnabled = YES;
    _imageView = imageV;
    imageV.backgroundColor = [UIColor whiteColor];
    UISwipeGestureRecognizer * swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(gestureAction:)];
    [imageV addGestureRecognizer:swipe];
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [_imageView setImage:_images[0]];
}

- (void)gestureAction:(UISwipeGestureRecognizer *)gesture {
    if(++_currentIndex != _images.count) {
        [UIView transitionWithView:_imageView duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            [self.imageView setImage:_images[_currentIndex]];
        } completion:nil];
    }
    else if(_currentIndex == _images.count && ![QZUserManager sharedManager].isLogin){
        CATransition * transition = [CATransition animation];
        transition.type = kCATransitionMoveIn;
        transition.subtype = kCATransitionFromTop;
        transition.duration = 0.25;
        transition.timeOffset = 0;
        transition.removedOnCompletion = YES;
        QZLoginViewController * loginV = [[QZLoginViewController alloc]init];
        loginV.isGuide = YES;
        QZBaseNavigationController * nav = [[QZBaseNavigationController alloc]initWithRootViewController:loginV];
        _nav = nav;
        [self.backView.layer addAnimation:transition forKey:@"loginAnimation"];
        [self.backView addSubview:nav.view];
        [self.imageView removeFromSuperview];
    }
    else {
        [UIView animateWithDuration:1 animations:^{
            self.imageView.transform = CGAffineTransformMakeScale(1.5, 1.5);
            self.imageView.alpha = 0;
        }];
        [[NSNotificationCenter defaultCenter]postNotificationName:ChangeRootViewController object:nil];
    }
}




@end
