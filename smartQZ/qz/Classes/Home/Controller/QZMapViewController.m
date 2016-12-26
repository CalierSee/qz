//
//  QZMapViewController.m
//  qz
//
//  Created by 景彦铭 on 2016/12/26.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZMapViewController.h"
#import "SEECircleTransition.h"
#import <MAMapKit/MAMapKit.h>
@interface QZMapViewController ()

@property(nonatomic,strong)SEECircleTransition * transition;

//地图视图
@property(nonatomic,strong)MAMapView * mapView;

@end

@implementation QZMapViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        _transition = [[SEECircleTransition alloc]init];
        self.transitioningDelegate = _transition;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [AMapServices sharedServices].enableHTTPS = YES;
    ///初始化地图
    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    ///把地图添加至view
    [self.view addSubview:_mapView];
    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - getter & setter

- (void)setAnimationRect:(CGRect)animationRect {
    _animationRect = animationRect;
    self.transition.animationRect = animationRect;
}

@end
