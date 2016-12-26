//
//  QZInformationView.h
//  qz
//
//  Created by 景彦铭 on 2016/12/19.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QZAttactionModel.h"

typedef NS_ENUM(NSInteger,ShareType) {
    ShareTypeQQ,
    ShareTypeWX,
    ShareTypeSina
};


@interface QZInformationView : UIView

- (void)attaction:(QZAttactionModel *)attaction;


@end
