//
//  SEEAdvertisementView.h
//  SEEQuick
//
//  Created by 景彦铭 on 16/9/18.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SEEAdvertisement.h"
static NSString * SEEAdvertisementViewNotification = @"SEEAdvertisementViewNotification";
@interface SEEAdvertisementView : UIView

@property(nonatomic,strong)NSArray<SEEAdvertisement *> * advertisements;



@end
