//
//  QZThiedLoginViewController.m
//  qztourist
//
//  Created by 景彦铭 on 2016/11/27.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZThiedLoginViewController.h"
#import "QZHUDManager.h"
@interface QZThiedLoginViewController ()<UIWebViewDelegate>
@property(nonatomic,weak)UIWebView *webView;
@property (nonatomic,copy) void(^complete)(QZBaseUser *user);
@end

@implementation QZThiedLoginViewController

#pragma mark - life circle 控制器生命周期
- (void)loadView {
    self.view = [[UIWebView alloc]init];
    _webView = (UIWebView *)self.view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
    [self.navigationController.navigationBar setTintColor:[UIColor redColor]];
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
#pragma mark - custom methods 自定义方法
- (instancetype)initWithType:(THIRDLOGIN)type complete:(void (^)(QZBaseUser *))complete {
    if(self = [super init]){
        self.type = type;
        self.complete = complete;
    }
    return self;
}

#pragma mark - 载入UI界面
- (void)loadUI {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(close)];
#ifdef DEBUG
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"测试账号" style:UIBarButtonItemStylePlain target:self action:@selector(testAccount)];
#endif
    _webView.delegate = self;
    [QZUserManager oauthPageType:_type complete:^(NSURLRequest *request) {
        [_webView loadRequest:request];
    }];
}

- (void)close {
    [self dismissViewControllerAnimated:YES completion:nil];
    [QZHUDManager dismiss];
}

- (void)closeAll {
    [[NSNotificationCenter defaultCenter]postNotificationName:LoginSuccess object:nil];
    UIViewController *rootVC = self.presentingViewController;
    while (rootVC.presentingViewController) {
        rootVC = rootVC.presentingViewController;
    }
    [rootVC dismissViewControllerAnimated:YES completion:nil];
    [QZHUDManager dismiss];
}

#ifdef DEBUG

- (void)testAccount {
    switch (_type) {
        case THIRDLOGINDQQ:
            [_webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('u').value = '3067105801';document.getElementById('p').value = 'jingyanming.1994'"];
            break;
        case THIRDLOGINSINA:
            [_webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('userId').value = '15280856063';document.getElementById('passwd').value = 'jingyanming.1994'"];
            break;
        case THIRDLOGINWECHAT:
            
            break;
    }
}
#endif



#pragma mark - delegate and datasource 代理和数据源协议
#pragma mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString * urlString = request.URL.absoluteString;
    if([urlString hasPrefix:@"http://www.baidu.com/"]){
        NSString * attr = [urlString componentsSeparatedByString:@"?"][1];
        NSArray * arr = [attr componentsSeparatedByString:@"&"];
        NSString * code;
        for (NSString * str in arr) {
            if([str hasPrefix:@"code"]) {
                code = [str componentsSeparatedByString:@"="][1];
            }
        }
        [QZUserManager getUserWithType:_type code:code complete:^(QZBaseUser *user) {
            self.complete(user);
            [self closeAll];
        }];
        return NO;
    }
    if([urlString hasPrefix:@"http://www.qq.com"]){
        [self close];
        return NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [QZHUDManager showWithTitle:@"正在加载..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [QZHUDManager dismiss];
}
#pragma mark - getter and setter 属性getter、setter

@end
