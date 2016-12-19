//
//  QZThiedLoginViewController.h
//  qztourist
//
//  Created by 景彦铭 on 2016/11/27.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZBaseViewController.h"
#import "QZUserManager.h"
@interface QZThiedLoginViewController : QZBaseViewController
@property (nonatomic,assign)THIRDLOGIN type;
- (instancetype)initWithType:(THIRDLOGIN)type complete:(void(^)(QZBaseUser *user))complete;
@end
