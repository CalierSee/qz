//
//  QZTravelsHotCollectionViewController.m
//  qz
//
//  Created by 景彦铭 on 2016/12/17.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZTravelsHotCollectionViewController.h"
#import "QZTravelsCell.h"
@interface QZTravelsHotCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionViewFlowLayout * layout;

@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation QZTravelsHotCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)loadView {
    self.view = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView = (UICollectionView *)self.view;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:@"QZTravelsCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _informations.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QZTravelsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.information = _informations[indexPath.item];
    // Configure the cell
    
    return cell;
}


#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    cell.layer.shadowOpacity = 0.5;
    cell.layer.masksToBounds = NO;
}

#pragma mark - getter setter

- (UICollectionViewFlowLayout *)layout {
    if(_layout == nil) {
        _layout = [[UICollectionViewFlowLayout alloc]init];
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.itemSize = CGSizeMake(150, 108);
        _layout.minimumLineSpacing = 8;
        _layout.minimumInteritemSpacing = 0;
        _layout.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2);
    }
    return _layout;
}

- (void)setInformations:(NSArray<QZInformationModel *> *)informations {
    _informations = informations;
    [self.collectionView reloadData];
}

@end
