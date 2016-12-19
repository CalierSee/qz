//
//  QZEditViewController.m
//  qztourist
//
//  Created by 景彦铭 on 2016/12/4.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZEditViewController.h"
#import "QZUserManager.h"
@interface QZEditViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UITextField *userMailTextField;

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UILabel *userBirthdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *userAddressLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *userGender;



@end

@implementation QZEditViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.tableView endEditing:YES];
}

#pragma mark - life circle 控制器生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
    [self loadUser];
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

#pragma mark - 载入UI界面
- (void)loadUI {
//    self.tableView.bounces = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _userMailTextField.borderStyle = UITextBorderStyleNone;
    _userNameTextField.borderStyle = UITextBorderStyleNone;
    _phoneTextField.borderStyle = UITextBorderStyleNone;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
}

- (void)loadUser {
    if ([QZUserManager sharedManager].isLogin) {
        [_userIcon sd_setImageWithURL:[NSURL URLWithString:[QZUserManager sharedManager].user.userImage]];
        _userNameTextField.text = [QZUserManager sharedManager].user.userName;
    }
}

- (void)save {
    
}

#pragma mark - delegate and datasource 代理和数据源协议

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc]init];
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES; 
}

#pragma mark - getter and setter 属性getter、setter

@end
