//
//  QZAttactionModel.h
//  qz
//
//  Created by 景彦铭 on 2016/12/17.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,QZAttactionSortMode) {
    QZAttactionSortModeNormal = 1,
    QZAttactionSortModePrice,
    QZAttactionSortModeNumber,
    QZAttactionSortModeDistance
};

@interface QZAttactionModel : NSObject

@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *desc;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *old_price;
@property (nonatomic,copy) NSString *star;
@property (nonatomic,copy) NSString *location;
@property (nonatomic,copy) NSString *common;

- (NSAttributedString *)descAttributeString;

- (UIImage *)iconImage;

- (NSArray<UIImage *>*)starImage;

+ (NSArray<QZAttactionModel *>*)sortWithMode:(QZAttactionSortMode)mode data:(NSArray<QZAttactionModel *>*)data;

@end
