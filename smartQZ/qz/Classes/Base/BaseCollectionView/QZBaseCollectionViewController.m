//
//  QZBaseCollectionViewController.m
//  qztourist
//
//  Created by 景彦铭 on 2016/12/4.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZBaseCollectionViewController.h"
#import "SEEAdvertisement.h"
#import "QZBaseTopView.h"
#import "QZBaseNavigationController.h"
@interface QZBaseCollectionViewController ()


@end

@implementation QZBaseCollectionViewController

#pragma mark - life circle 控制器生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = @"";
    self.automaticallyAdjustsScrollViewInsets = NO;
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
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView = collectionView;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [collectionView registerNib:[UINib nibWithNibName:@"QZCollectionViewFooter" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footer];
    collectionView.backgroundColor = [UIColor see_colorWithHex:0xf0ede2];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(iconButtonClick:) name:IconButtonClickNotification object:nil];
}
- (void)iconButtonClick:(NSNotification *)notification {
    
}

#pragma mark - 加载plist数据
- (void)loadData:(NSString *)fileName {
    NSArray * arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:fileName ofType:nil]];
    _datas = [NSArray yy_modelArrayWithClass:[QZHomeModel class] json:arr];
}

#pragma mark - delegate and datasource 代理和数据源协议

#pragma mark - UICollectionView数据源协议
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0){
        return CGSizeZero;
    }
    else {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 31);
    }
}




#pragma mark - getter and setter 属性getter、setter
- (NSArray<NSDictionary *> *)iconArray {
    if (_iconArray == nil){
        _iconArray = [self iconArrayData];
    }
    return _iconArray;
}
- (NSArray<SEEAdvertisement *> *)advs {
    if (_advs == nil) {
        _advs = [self advArrayData];
    }
    return _advs;
}

- (NSArray<NSDictionary *> *)iconArrayData {
    return nil;
}

- (NSArray<SEEAdvertisement *> *)advArrayData {
    return nil;
}

- (void)setDatas:(NSArray<QZHomeModel *> *)datas {
    _datas = datas;
    [_collectionView reloadData];
}

@end
