//
//  PLUSNewSpecialView.m
//  smart
//
//  Created by 景彦铭 on 16/9/6.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "SEENewSpecialView.h"
#import "UIScrollView+SEEQuick.h"
#import "UIPageControl+SEEQuick.h"
#import <Masonry.h>
#import "UIImageView+SEEQuick.h"
#import "UIButton+SEEQuick.h"
@interface SEENewSpecialView ()<UIScrollViewDelegate>
@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,weak) UIPageControl *pageControl;
@property (nonatomic,weak) UIButton *jumpButton;
@property(nonatomic,assign) CGFloat pageControlBottomDistance;


@end
@implementation SEENewSpecialView

+ (instancetype)newSpecialViewWithFrame:(CGRect)frame images:(NSArray <UIImage *> *)images pageControlBottomDistance:(CGFloat)bottomDistance{
    SEENewSpecialView * newSpecialView = [[SEENewSpecialView alloc]initWithFrame:frame];
    newSpecialView.pageControlBottomDistance = bottomDistance;
    newSpecialView.images = images;
    return newSpecialView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]){
        [self createUI];
    }
    return self;
}
#pragma mark - 设置基本界面数据
-(void)setImages:(NSArray *)images{
    _images = images;
    if(images.count > 1){
        //创建页控件
        UIPageControl * page = [[UIPageControl alloc]init];
        [page see_numberOfPage:_images.count currentPage:0 currentPageIndicatorTintColor:[UIColor blackColor] pageIndicatorTintColor:[UIColor grayColor]];
        [self addSubview:page];
        self.pageControl = page;
        page.userInteractionEnabled = NO;
        //布局页控件
        [page mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self).offset(-self.pageControlBottomDistance);
        }];
    }
    //创建imageView显示新特性图片
    for (int i = 0; i  < images.count; i++) {
        UIImageView * imageView = [UIImageView see_createWithFrame:CGRectOffset(self.bounds, self.bounds.size.width * i, 0) image:images[i] contentMode:0];
        imageView.userInteractionEnabled = YES;
        imageView.tag = 100;
        [self.scrollView addSubview:imageView];
    }
    //设置scrollView滚动范围
    self.scrollView.contentSize = CGSizeMake(self.bounds.size.width * (images.count + 1), self.bounds.size.height);
}

#pragma mark - 创建UI界面
- (void)createUI{
    //创建滚屏
    UIScrollView * scroll = [UIScrollView see_createWithFrame:self.bounds bounces:NO verticalScrollIndicator:NO horizontalScrollIndicator:NO pageEnable:YES delegate:self];
    self.scrollView = scroll;
    //scroll.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1];
    [self addSubview:scroll];
}

#pragma mark - 在每一个ImageView上创建按钮
-(void)informationButton:(UIImageView *)view normalImageName:(NSString *)normalImage highlightedImageName:(NSString *)highlightedImage layout:(CGRect)layout {
    UIButton * button = [UIButton see_buttonWithBackgroundImage:[UIImage imageNamed:normalImage] target:self selector:@selector(clickInformationButton:) event:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    [view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(view).offset(layout.origin.y);
        make.right.equalTo(view).offset(layout.origin.x);
        make.size.mas_equalTo(layout.size);
    }];
}

#pragma mark - 详细信息按钮点击事件
- (void)clickInformationButton:(UIButton *)sender{
    UIView * image = sender.superview;
    [UIView animateWithDuration:0.5 animations:^{
        image.transform = CGAffineTransformMakeScale(2.0,2.0);
        image.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 跳过按钮点击事件
-(void)jump{
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, self.bounds.size.height);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


//判断页数
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger currentPage = scrollView.contentOffset.x / self.bounds.size.width + 0.5;
    self.pageControl.currentPage = currentPage;
    self.pageControl.hidden = currentPage == self.images.count;
    self.jumpButton.hidden = currentPage == self.images.count;
}


//判断是否移到最后一页 如果到最后则移除视图
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger currentPage = scrollView.contentOffset.x / self.bounds.size.width;
    if(currentPage == self.images.count){
        [self removeFromSuperview];
    }
}


- (void)informationButtonLayout:(CGRect)layout withNormalImageName:(NSString *)normalImage withHighlightedImageName:(NSString *)highlightedImage{
    UIImageView * view = nil;
    for(int i = 0 ;i < self.scrollView.subviews.count ;i++){
        view = self.scrollView.subviews[i];
        if(view.tag == 100){
            [self informationButton:view normalImageName:normalImage highlightedImageName:highlightedImage layout:layout];
        }
    }
}

- (void)jumpButtonLayout:(CGRect)layout{
    UIButton * button = [UIButton see_buttonWithTitle:@"跳过" titleColor:[UIColor whiteColor] fontSize:14 target:self selector:@selector(jump) event:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor blackColor]];
    button.alpha = 0.8;
    button.layer.cornerRadius = 5;
    [self addSubview:button];
    self.jumpButton = button;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(layout.size);
        make.top.equalTo(self).offset(layout.origin.y);
        make.right.equalTo(self).offset(layout.origin.x);
    }];
}
@end
