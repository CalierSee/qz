//
//  QZHomeInformationController.m
//  qz
//
//  Created by 景彦铭 on 2016/12/19.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZHomeInformationController.h"
#import "QZInformationCell.h"
#import "QZInformationView.h"
static NSString * headerCell = @"headerCell";

@interface QZHomeInformationController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 1 : 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        QZInformationCell * cell = [tableView dequeueReusableCellWithIdentifier:headerCell forIndexPath:indexPath];
        [cell attraction:_attaction];
        return cell;
    }
    return nil;
}
#pragma mark - getter and setter 属性getter、setter
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:@"QZInformationCell" bundle:nil] forCellReuseIdentifier:headerCell];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 700;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


@end
