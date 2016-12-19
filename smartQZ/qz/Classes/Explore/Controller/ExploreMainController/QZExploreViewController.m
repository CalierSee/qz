//
//  QZExploreViewController.m
//  qztourist
//
//  Created by 景彦铭 on 2016/11/12.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZExploreViewController.h"
#import "QZExploreTopView.h"
extern NSString * cellID;
extern NSString * topID;
extern NSString * header;
@interface QZExploreViewController ()

@end

@implementation QZExploreViewController

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
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
    [self.collectionView registerClass:[QZExploreTopView class] forCellWithReuseIdentifier:topID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"QZExploreCellHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:header];
}



- (void)iconButtonClick:(NSNotification *)notification {
    
    
    
    
    
}



- (NSArray<NSDictionary *> *)iconArrayData {
    return [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"ExploreIcons.plist" ofType:nil]];
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


#pragma mark - delegate and datasource 代理和数据源协议

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return section == 0 ? 1 : 6;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        QZExploreTopView * item = [collectionView dequeueReusableCellWithReuseIdentifier:topID forIndexPath:indexPath];
        item.iconArray = self.iconArray;
        item.advs = self.advs;
        return item;
    }
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0){
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 500);
    }
    else {
        return CGSizeMake(([UIScreen mainScreen].bounds.size.width - 100) / 2 , 70);
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader] && indexPath.section == 1){
        return [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:header forIndexPath:indexPath];
    }
    return nil;
}

#pragma mark - delegate and datasource 代理和数据源协议

#pragma mark - getter and setter 属性getter、setter

@end
