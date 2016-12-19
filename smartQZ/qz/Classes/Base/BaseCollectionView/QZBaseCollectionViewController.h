//
//  QZBaseCollectionViewController.h
//  qztourist
//
//  Created by 景彦铭 on 2016/12/4.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SEEAdvertisement.h"
#import "QZBaseTopView.h"
#import "QZHomeModel.h"
static NSString * cellID = @"cell";
static NSString * topID = @"top";
static NSString * header = @"header";
static NSString * footer = @"footer";
@interface QZBaseCollectionViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)NSArray <NSDictionary *> * iconArray;
@property(nonatomic,strong)NSArray <SEEAdvertisement *> * advs;
@property(nonatomic,weak)UICollectionView *collectionView;
@property(nonatomic,strong)NSArray <QZHomeModel *> * datas;
- (void)loadUI;
- (void)loadData:(NSString *)fileName;
//返回icon数组
- (NSArray<NSDictionary *>*)iconArrayData;
//返回广告数组
- (NSArray<SEEAdvertisement *>*)advArrayData;
//icon点击回调
- (void)iconButtonClick:(NSNotification *)notification;

@end
