//
//  QZUserInfoView.h
//  qztourist
//
//  Created by 景彦铭 on 2016/11/29.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QZBaseView.h"
@class QZUserInfoView;
@protocol QZUserInfoViewDelegate <NSObject>

@optional
- (void)userInfoView:(QZUserInfoView *)userInfoView didClickLoginButton:(UIButton *)button;

- (void)userInfoView:(QZUserInfoView *)userInfoView didClickRegisterButton:(UIButton *)button;

- (void)userInfoView:(QZUserInfoView *)userInfoView didClickUserImageButton:(UIButton *)button;

- (void)userInfoView:(QZUserInfoView *)userInfoView didClickEditButton:(UIButton *)button;

- (void)userInfoView:(QZUserInfoView *)userInfoView didClickBackground:(UIImageView *)background;

@end

@interface QZUserInfoView : QZBaseView
@property (nonatomic,assign)CGFloat animateHeight;

@property(nonatomic,weak)id <QZUserInfoViewDelegate> delegate;

- (void)updateUI;

@end
