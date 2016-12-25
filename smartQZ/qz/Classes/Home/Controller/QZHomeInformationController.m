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
#import "QZCommonModel.h"
#import "QZInformationCommonCell.h"
#import "QZInformationFooter.h"
static NSString * headerCell = @"headerCell";
static NSString * CommonCell = @"commonCell";
@interface QZHomeInformationController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
/**  模型 */
@property(nonatomic,strong)QZCommonModel * common;
/**  是否显示全部评论 */
@property (nonatomic,assign)BOOL isAll;

@end

@implementation QZHomeInformationController

#pragma mark - life circle 控制器生命周期

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _common = [[QZCommonModel alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

#pragma mark - custom methods 自定义方法


#pragma mark - action 响应方法
- (void)changeCommonDisplayMode:(QZInformationFooter *)sender {
    _isAll = !_isAll;
    [self.tableView reloadData];
}
#pragma mark - delegate and datasource 代理和数据源协议
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 1 : _isAll == NO ? 1 : _common.commons.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        QZInformationCell * cell = [tableView dequeueReusableCellWithIdentifier:headerCell forIndexPath:indexPath];
        [cell attraction:_attaction];
        return cell;
    }
    else {
        QZInformationCommonCell * cell = [tableView dequeueReusableCellWithIdentifier:CommonCell forIndexPath:indexPath];
        [cell configerCell:_common.commons[indexPath.row]];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    else {
        return 52;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    else {
        return 50;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view = [[NSBundle mainBundle]loadNibNamed:@"QZInformationHeaderView" owner:nil options:nil].lastObject;
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    QZInformationFooter * footer = [[NSBundle mainBundle]loadNibNamed:@"QZInformationFooter" owner:nil options:nil].lastObject;
    if (_isAll) {
        [footer title:@"    收起评论列表    "];
    }
    else {
        [footer title:[NSString stringWithFormat:@"    查看全部评论(%zd条)    ",_common.commons.count]];
    }
    [footer addTarget:self action:@selector(changeCommonDisplayMode:) forControlEvents:UIControlEventValueChanged];
    return footer;
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
        [_tableView registerNib:[UINib nibWithNibName:@"QZInformationCommonCell" bundle:nil] forCellReuseIdentifier:CommonCell];
    }
    return _tableView;
}

@end
