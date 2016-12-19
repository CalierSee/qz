//
//  QZHomeModel.h
//  qztourist
//
//  Created by 景彦铭 on 2016/12/9.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QZInformationModel.h"
@interface QZHomeModel : NSObject

@property (nonatomic,copy) NSString *icon;

@property (nonatomic,copy) NSString *header;

@property(nonatomic,strong) NSArray <QZInformationModel *> * informations;

@end
