//
//  QZBaseViewController.m
//  qztourist
//
//  Created by 景彦铭 on 2016/11/12.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZBaseViewController.h"

@interface QZBaseViewController ()

@end

@implementation QZBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadUI];
    // Do any additional setup after loading the view.
}
#pragma mark - 载入UI界面
- (void)loadUI {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if(self.view.window == nil){
        self.view = nil;
    }
    // Dispose of any resources that can be recreated.
}


@end
