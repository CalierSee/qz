//
//  QZCommonModel.h
//  qz
//
//  Created by 景彦铭 on 2016/12/24.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QZCommonModel : NSObject

@property (nonatomic,copy) NSString *name;

@property (nonatomic,copy) NSString *icon;

@property (nonatomic,copy) NSString *level;

@property (nonatomic,copy) NSString *text;

@property (nonatomic,copy) NSString *date;

@property(nonatomic,strong)NSArray <NSString *> * images;

@property(nonatomic,strong)NSArray <QZCommonModel *> * commons;

- (NSArray<UIImage *>*)starImage;


@end
