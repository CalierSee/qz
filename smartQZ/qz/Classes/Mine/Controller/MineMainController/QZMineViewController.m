//
//  QZMineViewController.m
//  qztourist
//
//  Created by 景彦铭 on 2016/11/12.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZMineViewController.h"
#import "QZUserInfoView.h"
#import "QZUserManager.h"
#import "QZMineMenu.h"
#import "QZMenuCell.h"
#import "QZBaseNavigationController.h"
#import "QZEditViewController.h"
#import "QZLoginViewController.h"
@interface QZMineViewController ()<UITableViewDataSource,UITableViewDelegate,QZUserInfoViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,weak)UITableView *tableView;

@property(nonatomic,weak)UIImageView *imageView;

@property(nonatomic,weak)QZUserInfoView *topView;

@property(nonatomic,strong)NSArray<NSArray<QZMineMenu *>*> * menu;

@property (nonatomic,weak) UIImageView *bradgeImageView;

@property(nonatomic,strong)UIButton * editButton;

@end

@implementation QZMineViewController

#pragma mark - life circle 控制器生命周期

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    QZBaseNavigationController * nav = (QZBaseNavigationController *)self.navigationController;
    nav.hiddenCustomMode = HiddenCustomModeHidden;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    QZBaseNavigationController * nav = (QZBaseNavigationController *)self.navigationController;
    nav.hiddenCustomMode = HiddenCustomModeShow;

}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    
}
#pragma mark - custom methods 自定义方法

#pragma mark - 载入UI界面
- (void)loadUI {
    
    
    self.navigationController.navigationBar.translucent = YES;
    self.navigationItem.title = @"";
    self.automaticallyAdjustsScrollViewInsets = NO;
    //[self.navigationController.navigationBar setBarTintColor:[UIColor clearColor]];
    self.navigationController.navigationBar.shadowImage = [UIImage see_blankImageWithSize:CGSizeMake(1, 1)];
    [[QZUserManager sharedManager] addObserver:self forKeyPath:@"user" options:NSKeyValueObservingOptionNew context:nil];
    
    if ([QZUserManager sharedManager].isLogin){
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.editButton];
    }
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changLoginStatus) name:LoginSuccess object:nil];
    //添加tableview
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView = tableView;
    [self.view addSubview:tableView];
    tableView.backgroundColor = [UIColor see_colorWithHex:0xf0ede2];
    tableView.tableFooterView = [[UIView alloc]init];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [tableView registerNib:[UINib nibWithNibName:@"QZMenuCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 43;
    _tableView.contentInset = UIEdgeInsetsMake(207, 0, 0, 0);
    //添加顶部视图
    QZUserInfoView * topView = [[QZUserInfoView alloc]init];
    _topView = topView;
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(207);
    }];
    topView.backgroundColor = [UIColor see_colorWithHex:0xf0ede2];
    topView.animateHeight = 207;
    topView.delegate = self;
    [self loadPlistData];
    
    //添加表头
    [self addTableHeaderView];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([QZUserManager sharedManager].isLogin){
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.editButton];
    }
    else {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (void)addTableHeaderView {
    UIView * header = [[UIView alloc]init];
    header.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 45);
    header.backgroundColor = [UIColor whiteColor];
    CGFloat buttonW = [UIScreen mainScreen].bounds.size.width / 2;
    UIButton * leftButton = [UIButton see_buttonWithFrame:CGRectMake(0, 0, buttonW, 45) title:@"积分" titleColor:[UIColor darkGrayColor] fontSize:14 target:self selector:@selector(headerLeftButtonClick:) event:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"score"] forState:UIControlStateNormal];
    [header addSubview:leftButton];
    UIButton * rightButton = [UIButton see_buttonWithFrame:CGRectMake(buttonW, 0, buttonW, 45) title:@"现金券" titleColor:[UIColor darkGrayColor] fontSize:14 target:self selector:@selector(headerRightButtonClick:) event:UIControlEventTouchUpInside];
    [rightButton setImage:[UIImage imageNamed:@"money"] forState:UIControlStateNormal];
    [header addSubview:rightButton];
    _tableView.tableHeaderView = header;
}

//编辑
- (void)editButtonClick:(UIButton *)sender {
    QZEditViewController * vc = [[UIStoryboard storyboardWithName:@"QZEditViewController" bundle:nil]instantiateInitialViewController];
    vc.hidesBottomBarWhenPushed = YES;
    vc.title = @"修改资料";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)headerLeftButtonClick:(UIButton *)sender {
    
}

- (void)headerRightButtonClick:(UIButton *)sender {
    
}

- (void)changLoginStatus {
    [_topView updateUI];
}

#pragma mark - 加载plist数据
- (void)loadPlistData {
    NSArray * arr = [NSArray arrayWithContentsOfURL:[[NSBundle mainBundle]URLForResource:@"MineMenu.plist" withExtension:nil]];
    NSMutableArray * list = [NSMutableArray array];
    for (NSArray *arrs in arr) {
        NSMutableArray * arrM = [NSMutableArray array];
        for (NSDictionary * dict in arrs) {
            [arrM addObject:[[QZMineMenu alloc]initWithDictionary:dict]];
        }
        [list addObject:arrM];
    }
    _menu = list.copy;
    [self.tableView reloadData];
}

#pragma mark - delegate and datasource 代理和数据源协议
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _menu.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _menu[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QZMenuCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.menu = _menu[indexPath.section][indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 13;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc]init];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentOffset.y > 0 ? 0 : -scrollView.contentOffset.y;
    [_topView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(y);
    }];
    _topView.animateHeight = y;
}

#pragma mark QZUserInfoViewDelegate

- (void)userInfoView:(QZUserInfoView *)userInfoView didClickLoginButton:(UIButton *)button {
    [self presentViewController:[[UINavigationController alloc]initWithRootViewController:[[QZLoginViewController alloc]init]] animated:YES completion:nil];
}

- (void)userInfoView:(QZUserInfoView *)userInfoView didClickBackground:(UIImageView *)background {
    _bradgeImageView = background;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        UIImagePickerController * picV = [[UIImagePickerController alloc]init];
        picV.delegate = self;
        [self presentViewController:picV animated:YES completion:nil];
    }
    else {
        
    }
}

#pragma mark UIImagePickerController
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [_bradgeImageView setImage:info[@"UIImagePickerControllerOriginalImage"]];
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - getter and setter 属性getter、setter
- (UIButton *)editButton {
    if(_editButton == nil){
        UIButton * button = [UIButton see_buttonWithTitle:@"编辑" titleColor:[UIColor see_colorWithHex:0x958575] fontSize:12 target:self selector:@selector(editButtonClick:) event:UIControlEventTouchUpInside];
        _editButton = button;
    }
    return _editButton;
}
@end
