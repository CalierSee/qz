//
//  QZHomeViewController.m
//  qztourist
//
//  Created by 景彦铭 on 2016/11/12.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZHomeViewController.h"
#import "QZHomeTopView.h"
#import "QZHomeSectionHeader.h"
#import "QZGuardCell.h"
#import "QZLikeCell.h"
extern NSString * cellID;
static NSString * cellID1 = @"cellID1";
static NSString * cellID2 = @"cellID2";
extern NSString * topID;
extern NSString * header;
extern NSString * footer;
@interface QZHomeViewController ()

@property(nonatomic,strong)NSIndexPath * currentIndexPath;

@property (nonatomic,assign)NSInteger flag;

@end

@implementation QZHomeViewController

#pragma mark - life circle 控制器生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
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
    [super loadUI];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(functionButtonClick:) name:FunctionButtonClick object:nil];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
    [self.collectionView registerClass:[QZHomeTopView class] forCellWithReuseIdentifier:topID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeSectionHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:header];
    [self.collectionView registerNib:[UINib nibWithNibName:@"QZGuardCell" bundle:nil] forCellWithReuseIdentifier:cellID1];
    [self.collectionView registerNib:[UINib nibWithNibName:@"QZLikeCell" bundle:nil] forCellWithReuseIdentifier:cellID2];
    [self loadData:@"Home.plist"];
}



- (void)iconButtonClick:(NSNotification *)notification {
    UIButton * sender = notification.userInfo[@"sender"];
    UIViewController * vc ;
    switch (sender.tag) {
        case 0: //走进泉州
            
            break;
        case 1: //景点索引
        {
            vc = [[NSClassFromString(notification.userInfo[@"vc"]) alloc] init];
            break;
        }
        case 2: //特色特产
            
            break;
        case 3: //交通出行
            
            break;
        case 4: //娱乐购物
            
            break;
        case 5: //酒店民俗
            
            break;
    }
    vc.hidesBottomBarWhenPushed = YES;
    vc.title = notification.userInfo[@"title"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)functionButtonClick:(NSNotification *)notification {
    UIButton * sender = notification.userInfo[@"sender"];
    UIViewController * vc ;
    switch (sender.tag) {
        case 100: //文化日历
            
            break;
        case 101: //热门场馆
            
            break;
        case 102: //传统艺术
            
            break;
        case 103: //民间曲艺
            
            break;
        case 104: //民风民俗
            
            break;
        case 105: //文化传统
            
            break;
    }
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}



- (NSArray<NSDictionary *> *)iconArrayData {
    return [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"icons.plist" ofType:nil]];
}

- (NSArray<SEEAdvertisement *> *)advArrayData {
    NSArray * arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"HomeADV.plist" ofType:nil]];
    NSMutableArray * array = [NSMutableArray array];
    for (NSDictionary * dict in arr) {
        SEEAdvertisement * adv = [SEEAdvertisement advertisementWithDictionary:dict];
        [array addObject:adv];
    }
    return array.copy;
}

- (void)cellAnimationWithCell:(UICollectionViewCell *)cell flag:(BOOL)flag{
    CGFloat height = -10;
    if (flag) {
        height = -height;
    }
    cell.transform = CGAffineTransformMakeTranslation(0, height);
    [UIView animateWithDuration:0.2 delay:0.1 options:0 animations:^{
        cell.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
    }];
    _flag = flag;
}


#pragma mark - delegate and datasource 代理和数据源协议

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.datas.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return section == 0 ? 1 : self.datas[section].informations.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        QZHomeTopView * item = [collectionView dequeueReusableCellWithReuseIdentifier:topID forIndexPath:indexPath];
        item.iconArray = self.iconArray;
        item.advs = self.advs;
        return item;
    }else if (indexPath.section == 1){
        QZGuardCell * item = [collectionView dequeueReusableCellWithReuseIdentifier:cellID1 forIndexPath:indexPath];
        item.information = self.datas[indexPath.section].informations[indexPath.row];
        return item;
    }
    else {
        QZLikeCell * item = [collectionView dequeueReusableCellWithReuseIdentifier:cellID2 forIndexPath:indexPath];
        item.information = self.datas[indexPath.section].informations[indexPath.row];
        return item;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0){
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 196 + 170 + 190 + 4);
    }
    else if (indexPath.section == 1) {
        return CGSizeMake(([UIScreen mainScreen].bounds.size.width) / 2 , 155);
    }
    else {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 212);
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader] && indexPath.section != 0){
        QZHomeSectionHeader * headers = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:header forIndexPath:indexPath];
        headers.model = self.datas[indexPath.section];
        return headers;
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter] && indexPath.section != 2) {
        return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footer forIndexPath:indexPath];
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section != 2){
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 8);
    }
    else {
        return CGSizeZero;
    }
}

//cell动画
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == self.datas.count - 1 && indexPath.item != 0){
        if (indexPath.item > _currentIndexPath.item){
            [self cellAnimationWithCell:cell flag:1];
        }
        else if (indexPath.item < _currentIndexPath.item) {
            [self cellAnimationWithCell:cell flag:0];
        }
        else if (_flag){
            [self cellAnimationWithCell:cell flag:1];
        }
        else {
            [self cellAnimationWithCell:cell flag:0];
        }
        _currentIndexPath = indexPath;
    }
}

#pragma mark - getter and setter 属性getter、setter
- (NSIndexPath *)currentIndexPath {
    if (_currentIndexPath == nil){
        _currentIndexPath = [NSIndexPath indexPathForItem:0 inSection:self.datas.count - 1];
    }
    return _currentIndexPath;
}

@end
