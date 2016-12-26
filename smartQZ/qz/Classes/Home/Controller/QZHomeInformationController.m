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
#import "QZMapViewController.h"

static NSString * headerCell = @"headerCell";
static NSString * CommonCell = @"commonCell";
@interface QZHomeInformationController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
/**  模型 */
@property(nonatomic,strong)QZCommonModel * common;
/**  是否显示全部评论 */
@property (nonatomic,assign)BOOL isAll;

//顶部详情视图
@property(nonatomic,strong)UIView *descView;
@property(nonatomic,weak)UIButton *descButton;
@property(nonatomic,weak)UIButton *commonButton;

@property (nonatomic,assign)CGFloat topMargin;

@property(nonatomic,strong)NSIndexPath * currentIndexPath;

@end

@implementation QZHomeInformationController

#pragma mark - life circle 控制器生命周期

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _common = [[QZCommonModel alloc]init];
        _topMargin = 64;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.descView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(locationViewClick:) name:NeedPushMapViewNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - custom methods 自定义方法


#pragma mark - action 响应方法
- (void)changeCommonDisplayMode:(QZInformationFooter *)sender {
    _isAll = !_isAll;
    [self.tableView reloadData];
}

- (void)descViewButtonAction:(UIButton *)sender {
    [sender setTitleColor:[UIColor see_colorWithHex:0x1aa1e6] forState:UIControlStateNormal];
    [sender setBackgroundColor:[UIColor whiteColor]];
    if (sender == self.descButton) {
        [self.commonButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.commonButton setBackgroundColor:[UIColor see_colorWithHex:0x1aa1e6]];
        [self.tableView setContentOffset:CGPointMake(0, -44) animated:YES];
    }
    else {
        [self.descButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.descButton setBackgroundColor:[UIColor see_colorWithHex:0x1aa1e6]];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

- (void)locationViewClick:(NSNotification *)notification {
    QZMapViewController * vc = [[QZMapViewController alloc]init];
    CGRect rect = CGRectFromString(notification.userInfo[@"rect"]);
    vc.animationRect = rect;
    [self presentViewController:vc animated:YES completion:nil];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y >= -40) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        if (_topMargin == 64) {
            _topMargin = 20;
            [UIView animateWithDuration:0.25 animations:^{
                self.descView.transform = CGAffineTransformMakeTranslation(0, -44);
            }];
        }
    }
    else {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        if (_topMargin == 20) {
            _topMargin = 64;
            [UIView animateWithDuration:0.25 animations:^{
                self.descView.transform = CGAffineTransformIdentity;
            }];
        }
    }
    if (scrollView.dragging || scrollView.tracking || scrollView.decelerating) {
        NSArray <NSIndexPath *> * indexPaths = [self.tableView indexPathsForVisibleRows];
        NSIndexPath * indexPath = indexPaths.firstObject;
        if (indexPaths.count > 3) {
            indexPath = indexPaths.lastObject;
        }
        if (indexPath.section == 0 && indexPath.section != self.currentIndexPath.section) {
            [self descViewButtonAction:self.descButton];
            _currentIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        }
        else if (indexPath.section == 1 && indexPath.section != self.currentIndexPath.section) {
            [self descViewButtonAction:self.commonButton];
            _currentIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        }
    }
}

#pragma mark - getter and setter 属性getter、setter
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:@"QZInformationCell" bundle:nil] forCellReuseIdentifier:headerCell];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 700;
        _tableView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"QZInformationCommonCell" bundle:nil] forCellReuseIdentifier:CommonCell];
        _tableView.backgroundColor = [UIColor see_colorWithHex:0x1aa1e6];
//        _tableView.bounces = NO;
    }
    return _tableView;
}

- (UIView *)descView {
    if (_descView == nil) {
        _descView = [[UIView alloc]initWithFrame:CGRectMake(0, 64 , [UIScreen mainScreen].bounds.size.width, 40)];
        _descView.backgroundColor = [UIColor see_colorWithHex:0x1aa1e6];
        CGFloat buttonW = 50;
        CGFloat buttonH = 22;
        CGFloat margin = ([UIScreen mainScreen].bounds.size.width - 100) / 3;
        
        //详情按钮
        UIButton * descButton = [UIButton see_buttonWithFrame:CGRectMake(margin, 9, buttonW, buttonH) title:@"详情" titleColor:[UIColor see_colorWithHex:0x1AA1E6] fontSize:14 backgroundColor:[UIColor whiteColor] target:self selector:@selector(descViewButtonAction:) event:UIControlEventTouchUpInside];
        descButton.layer.cornerRadius = 11;
        descButton.layer.borderColor = [UIColor whiteColor].CGColor;
        descButton.layer.borderWidth = 1;
        _descButton = descButton;
        [_descView addSubview:descButton];
        
        //评价按钮
        UIButton * commonButton = [UIButton see_buttonWithFrame:CGRectMake(margin * 2 + buttonW, 9, buttonW, buttonH) title:@"评价" titleColor:[UIColor whiteColor] fontSize:14 backgroundColor:[UIColor see_colorWithHex:0x1AA1E6] target:self selector:@selector(descViewButtonAction:) event:UIControlEventTouchUpInside];
        commonButton.layer.cornerRadius = 11;
        commonButton.layer.borderColor = [UIColor whiteColor].CGColor;
        commonButton.layer.borderWidth = 1;
        _commonButton = commonButton;
        [_descView addSubview:commonButton];
    }
    return _descView;
}

- (NSIndexPath *)currentIndexPath {
    if (_currentIndexPath == nil) {
        _currentIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    return _currentIndexPath;
}


@end
