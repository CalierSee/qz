//
//  QZTravelsViewController.m
//  qztourist
//
//  Created by 景彦铭 on 2016/12/5.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZTravelsViewController.h"
#import "QZTravelsTopView.h"
#import "QZTravelsHeader.h"
#import "QZTravelsHotCell.h"
#import "QZFootCell.h"
extern NSString * cellID;
static NSString * cellID1 = @"cellID1";
static NSString * cellID2 = @"cellID2";
extern NSString * topID;
extern NSString * header;
extern NSString * footer;
@interface QZTravelsViewController ()

@property(nonatomic,strong)UIButton * moveToTop;

@property(nonatomic,strong)UIButton * edit;

@property(nonatomic,strong)UIAlertController * editView;

@end

@implementation QZTravelsViewController

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
    [self.collectionView registerClass:[QZTravelsTopView class] forCellWithReuseIdentifier:topID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"QZTravelsHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:header];
    [self.collectionView registerClass:[QZTravelsHotCell class] forCellWithReuseIdentifier:cellID1];
    [self.collectionView registerNib:[UINib nibWithNibName:@"QZFootCell" bundle:nil] forCellWithReuseIdentifier:cellID2];
    [self loadData:@"Travels.plist"];
    
    //添加滚动到顶部按钮
    [self.view addSubview:self.moveToTop];
    
    //添加编辑按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.edit];
}



- (void)buttonAnimation:(NSInteger)flag button:(UIButton *)button{
    if(button.alpha != flag) {
        [UIView animateWithDuration:0.25 animations:^{
            button.alpha = flag;
        }];
    }
}

#pragma mark - Action
- (void)moveToTopButtonClick:(UIButton *)sender {
    [self.collectionView setContentOffset:CGPointZero animated:YES];
}

- (void)editButtonClick {
#warning
    [self presentViewController:self.editView animated:YES completion:nil];
}

#pragma mark - delegate and datasource 代理和数据源协议

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.datas.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return section == 0 || section == 1 ? 1 : self.datas[section].informations.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        QZTravelsTopView * item = [collectionView dequeueReusableCellWithReuseIdentifier:topID forIndexPath:indexPath];
        item.iconArray = self.iconArray;
        item.advs = self.advs;
        return item;
    }
    else if (indexPath.section == 1){
        QZTravelsHotCell * item = [collectionView dequeueReusableCellWithReuseIdentifier:cellID1 forIndexPath:indexPath];
        item.informations = self.datas[indexPath.section].informations;
        return item;
    }
    else {
        QZFootCell * item = [collectionView dequeueReusableCellWithReuseIdentifier:cellID2 forIndexPath:indexPath];
        item.information = self.datas[indexPath.section].informations[indexPath.item];
        return item;
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.collectionView) {
        if(scrollView.contentOffset.y <= [UIScreen mainScreen].bounds.size.height) {
            [self buttonAnimation:NO button:self.moveToTop];
        }
        else {
            [self buttonAnimation:YES button:self.moveToTop];
        }
        if (scrollView.contentOffset.y <= 196 - 64) {
            [self buttonAnimation:YES button: self.edit];
        }
        else {
            [self buttonAnimation:NO button:self.edit];
        }
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0){
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 196);
    }
    else if (indexPath.section == 1) {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width , 112);
    }
    else {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width - 16 , 136);
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader] && indexPath.section != 0){
        QZTravelsHeader * headers = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:header forIndexPath:indexPath];
        headers.model = self.datas[indexPath.section];
        if (indexPath.section == 2){
            headers.hiddenAll = YES;
        }
        else {
            headers.hiddenAll = NO;
        }
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

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section != 0){
        return UIEdgeInsetsMake(0, 8, 0, 8);
    }
    else {
        return UIEdgeInsetsZero;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 8;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark - getter and setter 属性getter、setter
- (UIButton *)moveToTop {
    if (_moveToTop == nil) {
        _moveToTop = [UIButton see_buttonWithImage:[UIImage imageNamed:@"movetotop"] target:self selector:@selector(moveToTopButtonClick:) event:UIControlEventTouchUpInside];
        _moveToTop.alpha = 0;
        _moveToTop.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 48 - 16, [UIScreen mainScreen].bounds.size.height - 48 - 60, 0, 0);
        [_moveToTop sizeToFit];
    }
    return _moveToTop;
}

- (NSArray<SEEAdvertisement *> *)advArrayData {
    NSArray * arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"TravelsADV.plist" ofType:nil]];
    NSMutableArray * array = [NSMutableArray array];
    for (NSDictionary * dict in arr) {
        SEEAdvertisement * adv = [SEEAdvertisement advertisementWithDictionary:dict];
        [array addObject:adv];
    }
    return array.copy;
}

- (UIButton *)edit {
    if (_edit == nil) {
        _edit = [UIButton see_buttonWithImage:[UIImage imageNamed:@"edit"] target:self selector:@selector(editButtonClick) event:UIControlEventTouchUpInside];
    }
    return _edit;
}

- (UIAlertController *)editView {
    if (_editView == nil) {
        _editView = [UIAlertController alertControllerWithTitle:@"发布游记" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction * life = [UIAlertAction actionWithTitle:@"记录生活" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction * photo = [UIAlertAction actionWithTitle:@"照片/视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction * choosePicture = [UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [_editView addAction:life];
        [_editView addAction:photo];
        [_editView addAction:choosePicture];
        [_editView addAction:cancel];
    }
    return _editView;
}


@end
