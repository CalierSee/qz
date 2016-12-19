//
//  QZTravelsHeader.h
//  qz
//
//  Created by 景彦铭 on 2016/12/13.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QZHomeModel.h"
@interface QZTravelsHeader : UICollectionReusableView
@property(nonatomic,strong)QZHomeModel * model;

@property (nonatomic,assign)BOOL hiddenAll;

@end
