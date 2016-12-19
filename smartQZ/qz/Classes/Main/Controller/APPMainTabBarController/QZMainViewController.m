//
//  QZMainViewController.m
//  qztourist
//
//  Created by 景彦铭 on 2016/11/12.
//  Copyright © 2016年 景彦铭. All rights reserved.
#import "QZMainViewController.h"
#import "QZGuideView.h"
#import "QZBaseNavigationController.h"
@interface QZMainViewController ()
@property(nonatomic,weak)UITabBarController *tabBarController;
@end

@implementation QZMainViewController

#pragma mark - life circle 控制器生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    //载入控制器
    [self loadController];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if(self.view.window == nil){
        self.view = nil;
        //清理当前控制器属性
        
    }
}
#pragma mark - custom methods 自定义方法

//载入主界面
- (void)loadUI {
    self.view.backgroundColor = [UIColor whiteColor];
    UITabBarController * tabBarController = [[UITabBarController alloc]init];
    //添加tabBar
    tabBarController.tabBar.translucent = NO;
    [self.view addSubview:tabBarController.view];
    [self addChildViewController:tabBarController];
    [tabBarController didMoveToParentViewController:self];
    _tabBarController = tabBarController;
    //设置文字显示颜色
    [tabBarController.tabBar setTintColor:[UIColor see_colorWithHex:0x1fa5e7]];
    [tabBarController.tabBar setUnselectedItemTintColor:[UIColor see_colorWithHex:0x948475]];

}

//载入控制器
- (void)loadController {
    NSArray <NSDictionary *> * viewControllers = @[
                                                   @{@"name":@"首页",@"class":@"QZHomeViewController",@"image":@"home",@"selectImage":@"home_selected"},
                                                   @{@"name":@"探索",@"class":@"QZExploreViewController",@"image":@"explore",@"selectImage":@"explore_selected"},
                                                   @{@"name":@"游记",@"class":@"QZTravelsViewController",@"image":@"find",@"selectImage":@"find_selected"},
                                                   @{@"name":@"我的",@"class":@"QZMineViewController",@"image":@"mine",@"selectImage":@"mine_selected"}
                                                   ];
    NSMutableArray * vcM = [NSMutableArray arrayWithCapacity:viewControllers.count];
    
    [viewControllers enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //设置viewController
        UIViewController * vc = [[NSClassFromString(obj[@"class"]) alloc]init];
        vc.title = obj[@"name"];
        QZBaseNavigationController * NVc = [[QZBaseNavigationController alloc]initWithRootViewController:vc];
        [vcM addObject:NVc];
        //设置导航栏image
        [vc.tabBarItem setImage:[UIImage imageNamed:obj[@"image"]]];
        [vc.tabBarItem setSelectedImage:[[UIImage imageNamed:obj[@"selectImage"]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }];
    [_tabBarController setViewControllers:vcM.copy];
}

#pragma mark - delegate and datasource 代理和数据源协议



#pragma mark - getter and setter 属性getter、setter


@end
