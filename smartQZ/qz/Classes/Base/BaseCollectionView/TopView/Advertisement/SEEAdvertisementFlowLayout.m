//
//  SEEAdvertisementFlowLayout.m
//  SEEQuick
//
//  Created by 景彦铭 on 16/9/18.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "SEEAdvertisementFlowLayout.h"


@implementation SEEAdvertisementFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    //计算item大小
    self.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, self.collectionView.frame.size.height);
    //设置UICollectionView
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
}

@end
