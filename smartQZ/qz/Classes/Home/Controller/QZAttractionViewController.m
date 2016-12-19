//
//  QZAttractionViewController.m
//  qz
//
//  Created by 景彦铭 on 2016/12/17.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZAttractionViewController.h"
#import "QZAttactionCell.h"
#import "QZAttactionModel.h"
#import "QZAttactionChooseView.h"
#import "QZHomeInformationController.h"
static NSString * cellID = @"cell";

@interface QZAttractionViewController ()

@property(nonatomic,strong)NSArray <QZAttactionModel *> * attactions;

@property(nonatomic,strong)QZAttactionChooseView *chooseView;

@property(nonatomic,weak)UIButton *chooseButton;

@property(nonatomic,strong)UIButton * backgroundView;

@end

@implementation QZAttractionViewController

#pragma mark - life circle 控制器生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadPlistData];
    [self.tableView registerNib:[UINib nibWithNibName:@"QZAttactionCell" bundle:nil] forCellReuseIdentifier:cellID];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 250;
    
    //设置右侧按钮
    UIButton * button = [UIButton see_buttonWithImage:[UIImage imageNamed:@"chooseList"] target:self selector:@selector(chooseButtonClick:) event:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    _chooseButton = button;

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.chooseView removeFromSuperview];
    [self.backgroundView removeFromSuperview];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}


#pragma mark - custom methods 自定义方法

- (void)loadPlistData {
    NSArray * arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"Attaction" ofType:@"plist"]];
    NSArray * dataArray = [NSArray yy_modelArrayWithClass:[QZAttactionModel class] json:arr];
    _attactions = dataArray;
    [self.tableView reloadData];
}

- (void)showChooseView:(BOOL)flag complete:(void(^)())complete{
    if (flag){
        QZBaseNavigationController * nav = (QZBaseNavigationController *)self.navigationController;
        [self.navigationController.view insertSubview:self.backgroundView belowSubview:nav.see_navigationItem];
        [self.navigationController.view insertSubview:self.chooseView belowSubview:nav.see_navigationItem];
        POPSpringAnimation * pop = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        pop.fromValue = [NSValue valueWithCGRect:self.chooseView.frame];
        pop.toValue = [NSValue valueWithCGRect:CGRectOffset(self.chooseView.frame, 0, 208)];
        pop.springSpeed = 20;
        pop.springBounciness = 15;
        [self.chooseView pop_addAnimation:pop forKey:nil];
    }
    else {
        POPSpringAnimation * pop = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        pop.fromValue = [NSValue valueWithCGRect:self.chooseView.frame];
        pop.toValue = [NSValue valueWithCGRect:CGRectOffset(self.chooseView.frame, 0, -208)];
        [pop setCompletionBlock:^(POPAnimation * ani, BOOL flag) {
            [self.chooseView removeFromSuperview];
            [self.backgroundView removeFromSuperview];
            if (complete) {
                complete();
            }
        }];
        [self.chooseView pop_addAnimation:pop forKey:nil];
    }
}

#pragma mark - Action

- (void)chooseButtonClick:(UIButton *)button {
    button.selected = !button.selected;
    [self showChooseView:button.selected complete:nil];
}

- (void)sortModeChoose:(QZAttactionChooseView *)sender {
    _attactions = [QZAttactionModel sortWithMode:sender.sortMode data:_attactions];
    [self showChooseView:NO complete:^{
        [self.tableView reloadData];
        _chooseButton.selected = NO;
    }];
}

- (void)backgroundViewClick {
    [self showChooseView:NO complete:^{
        _chooseButton.selected = NO;
    }];
}

#pragma mark - delegate and datasource 代理和数据源协议

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _attactions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QZAttactionCell * cell = [tableView dequeueReusableCellWithIdentifier: cellID forIndexPath:indexPath];
    [cell showWithModel:_attactions[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegete
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QZHomeInformationController * vc = [[QZHomeInformationController alloc]init];
    vc.attaction = _attactions[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - getter and setter 属性getter、setter

- (QZAttactionChooseView *)chooseView {
    if(_chooseView == nil) {
        _chooseView = [[NSBundle mainBundle]loadNibNamed:@"QZAttactionChooseView" owner:nil options:nil].lastObject;
        _chooseView.frame = CGRectMake(0, - 208, [UIScreen mainScreen].bounds.size.width, 272);
        [_chooseView addTarget:self action:@selector(sortModeChoose:) forControlEvents:UIControlEventValueChanged];
    }
    return _chooseView;
}

- (UIButton *)backgroundView {
    if(_backgroundView == nil){
        _backgroundView = [[UIButton alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _backgroundView.backgroundColor = [UIColor darkTextColor];
        _backgroundView.alpha = 0.7;
        [_backgroundView addTarget:self action:@selector(backgroundViewClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backgroundView;
}
@end
