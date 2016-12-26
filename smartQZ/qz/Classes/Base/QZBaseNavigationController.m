//
//  QZBaseNavigationController.m
//  qztourist
//
//  Created by 景彦铭 on 2016/11/20.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZBaseNavigationController.h"
#import "QZBaseCollectionViewController.h"
@interface QZBaseNavigationController ()



@property(nonatomic,strong)UIButton *see_leftButton;

@property(nonatomic,strong)UIButton *see_rightButton;

@end

@implementation QZBaseNavigationController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadUI];
}

- (void)loadUI {
//    //导航条颜色
    [self.navigationBar setBackgroundImage:[UIImage see_blankImageWithSize:CGSizeMake(1, 1)] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.translucent = YES;
    self.navigationBar.shadowImage = [UIImage see_blankImageWithSize:CGSizeMake(1, 1)];
    [self.topViewController.view addSubview:self.see_navigationItem];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
    [self.view insertSubview:self.see_navigationItem belowSubview:self.navigationBar];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.hiddenCustomMode == HiddenCustomModeShow){
            [UIView animateWithDuration:0.25 animations:^{
                self.see_navigationItem.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
            }];
        }
        else {
            [UIView animateWithDuration:0.25 animations:^{
                self.see_navigationItem.frame = CGRectMake(0, -64, [UIScreen mainScreen].bounds.size.width, 64);
            }];
        }
    });
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.hiddenCustomMode == HiddenCustomModeShow){
            [UIView animateWithDuration:0.25 animations:^{
                self.see_navigationItem.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
            }];
        }
        else {
            [UIView animateWithDuration:0.25 animations:^{
                self.see_navigationItem.frame = CGRectMake(0, -64, [UIScreen mainScreen].bounds.size.width, 64);
            }];
        }
    });

    return [super popViewControllerAnimated:animated];
}

- (void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            self.see_navigationItem.transform = hidden? CGAffineTransformMakeTranslation(0, -44) : CGAffineTransformIdentity;
        }];
    }
    else {
        self.see_navigationItem.transform = hidden? CGAffineTransformMakeTranslation(0, -44) : CGAffineTransformIdentity;
    }
    [super setNavigationBarHidden:hidden animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter setter
- (UIView *)see_navigationItem {
    if(_see_navigationItem == nil){
        _see_navigationItem = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
        _see_navigationItem.backgroundColor = [UIColor see_colorWithHex:0x1AA1E6];
    }
    return _see_navigationItem;
}
@end
