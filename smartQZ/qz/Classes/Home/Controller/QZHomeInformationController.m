//
//  QZHomeInformationController.m
//  qz
//
//  Created by 景彦铭 on 2016/12/19.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZHomeInformationController.h"
#import "QZInformationView.h"
@interface QZHomeInformationController ()
@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,weak)QZInformationView *header;
@end

@implementation QZHomeInformationController

#pragma mark - life circle 控制器生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

#pragma mark - custom methods 自定义方法

#pragma mark - 载入UI界面

#pragma mark - action 响应方法

#pragma mark - delegate and datasource 代理和数据源协议

#pragma mark - getter and setter 属性getter、setter
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        QZInformationView * header = [[UINib nibWithNibName:@"QZInformationView" bundle:nil]instantiateWithOwner:nil options:nil].firstObject;
        _tableView.tableHeaderView = header;
        _header = header;
        [_header attaction:_attaction];
    }
    return _tableView;
}


@end
