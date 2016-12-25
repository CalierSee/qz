//
//  QZInformationView.m
//  qz
//
//  Created by 景彦铭 on 2016/12/19.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZInformationView.h"
#import "SEEAdvertisementView.h"
#import "SEEAdvertisement.h"
#import "QZDateCell.h"
@interface QZInformationView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *desc;
//门票抬头
@property (weak, nonatomic) IBOutlet UILabel *ticketTitleLabel;
//价格
@property (weak, nonatomic) IBOutlet UILabel *prictLabel;
//立减
@property (weak, nonatomic) IBOutlet UIButton *freeLabel;
//门票使用时间
@property (weak, nonatomic) IBOutlet UILabel *ticketDescLabels;
//预定限制
@property (weak, nonatomic) IBOutlet UILabel *order;
//门票使用方式
@property (weak, nonatomic) IBOutlet UILabel *userMethod;
@property (weak, nonatomic) IBOutlet SEEAdvertisementView *advView;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *weather;

@property(nonatomic,weak)IBOutlet UICollectionView *collectionView;

@property(nonatomic,weak)IBOutlet UICollectionViewFlowLayout *layout;

@property(nonatomic,weak)IBOutlet UIView *locationView;

@property(nonatomic,weak)IBOutlet UIView *hotalView;

@end

@implementation QZInformationView

- (void)awakeFromNib {
    [super awakeFromNib];
    _freeLabel.layer.borderColor = _freeLabel.titleLabel.textColor.CGColor;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"QZDateCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    _collectionView.pagingEnabled = YES;
    _layout.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width - 60) / 5 , 50);
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hotilGestureClick:)];
    [_hotalView addGestureRecognizer:tap1];
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(locationGestureClick:)];
    [_locationView addGestureRecognizer:tap2];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    });
}



//分享按钮
- (IBAction)shareButtonClick:(UIButton *)sender {
}
//定位按钮
- (void)locationGestureClick:(UITapGestureRecognizer *)sender {
}
//套餐说明按钮
- (IBAction)directionsButtonClick:(UIButton *)sender {
}
//景点酒店按钮
- (void)hotilGestureClick:(UITapGestureRecognizer *)sender {
}

#pragma mark - delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QZDateCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell loadDateWithIndex:indexPath.row];
    return cell;
}



#pragma mark - private method
- (void)attaction:(QZAttactionModel *)attaction {
    _desc.attributedText = attaction.descAttributeString;
    NSMutableArray * arr = [NSMutableArray array];
    for (NSString *str in attaction.images) {
        SEEAdvertisement * adv = [SEEAdvertisement advertisementWithDictionary:@{@"image": [str stringByAppendingString:@".png"]}];
        [arr addObject:adv];
    }
    _advView.advertisements = arr.copy;
    
    [attaction weatherStringWithComplete:^(NSString *weather) {
        _weather.text = weather;
    }];
    
    _location.text = attaction.location;
    
    _order.text = attaction.ticket[0];
    _userMethod.text = attaction.ticket[1];
    _ticketDescLabels.text = attaction.ticket[2];
    
}

@end
