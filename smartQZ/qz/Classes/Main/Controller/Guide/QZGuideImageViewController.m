//
//  QZGuideImageViewController.m
//  qztourist
//
//  Created by 景彦铭 on 2016/11/12.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZGuideImageViewController.h"

@interface QZGuideImageViewController ()
@property (nonatomic,strong) UIImage *image;
@end

@implementation QZGuideImageViewController


//初始化引导页
+ (instancetype)guideImageViewControllerWithImageName:(NSString *)imageName {
    QZGuideImageViewController * guideImageVC = [[QZGuideImageViewController alloc]init];
#warning 如果引导页没有图片检查这里
    [guideImageVC loadImage:imageName];
    return guideImageVC;
}

- (void)loadImage:(NSString *)imageName {
    _image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:imageName ofType:nil]];
}
//加载引导页界面
- (void)loadUI {
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView * imageV = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageV.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageV];
    [imageV setImage:_image];
    imageV.userInteractionEnabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if(self.view.window == nil){
        _image = nil;
    }
}
@end
