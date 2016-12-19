//
//  QZUserInfoView.m
//  qztourist
//
//  Created by 景彦铭 on 2016/11/29.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZUserInfoView.h"
#import "QZUserManager.h"
#import <UIButton+WebCache.h>
@interface QZUserInfoView ()

@property(nonatomic,weak)UIImageView *imageView;

@property(nonatomic,weak)UIButton *userImage;

@property(nonatomic,strong)UIButton *loginButton;

@property(nonatomic,strong)UIButton *registerButton;

@property(nonatomic,weak)UIVisualEffectView *effectView;

@property(nonatomic,strong)UILabel * nameLabel;

@property(nonatomic,strong)UIButton * vipButton;

@property(nonatomic,strong)UIButton * siginButton;



@end

@implementation QZUserInfoView

- (void)loadUI {
    //创建背景图
    UIImageView * imageV = [[UIImageView alloc]init];
    [self addSubview:imageV];
    _imageView = imageV;
    imageV.contentMode = UIViewContentModeScaleAspectFill;
    imageV.image = [UIImage imageNamed:@"login_background"];
    imageV.clipsToBounds = YES;
    imageV.userInteractionEnabled = YES;
    //添加蒙版
    UIVisualEffectView * effectView = [UIVisualEffectView see_createWithFrame:CGRectZero];
    [self addSubview:effectView];
    _effectView = effectView;
    //添加手势更改背景图片
    UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeImage:)];
    [effectView addGestureRecognizer:gesture];
    //创建用户头像
    UIButton * userImage = [[UIButton alloc]init];
    _userImage = userImage;
    [userImage setBackgroundImage:[UIImage imageNamed:@"avatar_default_big"] forState:UIControlStateNormal];
    [self addSubview:userImage];
    userImage.layer.cornerRadius = 43;
    userImage.layer.borderColor = [UIColor whiteColor].CGColor;
    userImage.layer.borderWidth = 4;
    userImage.clipsToBounds = YES;
    [userImage addTarget:self action:@selector(userImageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self updateUI];
}

- (void)updateUI {
    //添加登录注册按钮
    if([QZUserManager sharedManager].isLogin){
        [_loginButton removeFromSuperview];
        [_registerButton removeFromSuperview];
        _loginButton = nil;
        _registerButton = nil;
        [self addSubview:self.nameLabel];
        [self addSubview:self.vipButton];
        [self addSubview:self.siginButton];
        [_userImage sd_setBackgroundImageWithURL:[NSURL URLWithString:[QZUserManager sharedManager].user.userImage] forState:UIControlStateNormal];
        _nameLabel.text = [QZUserManager sharedManager].user.userName;
    }
    else {
        [_nameLabel removeFromSuperview];
        [_vipButton removeFromSuperview];
        [_siginButton removeFromSuperview];
        _nameLabel = nil;
        _siginButton = nil;
        _vipButton = nil;
        [self addSubview:self.loginButton];
        [self addSubview:self.registerButton];
        [_userImage setBackgroundImage:[UIImage imageNamed:@"avatar_default_big"] forState:UIControlStateNormal];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [_effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_imageView);
    }];
    [_userImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-_animateHeight / 10);
        make.size.mas_equalTo(CGSizeMake(86, 86));
    }];
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userImage.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(63, 23));
        make.centerX.equalTo(self).offset(-20 - 31.5);
    }];
    [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userImage.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(63, 23));
        make.centerX.equalTo(self).offset(20 + 31.5);
    }];
    [_vipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_userImage);
        make.right.equalTo(_userImage.mas_left).offset(-30);
    }];
    [_siginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_userImage);
        make.left.equalTo(_userImage.mas_right).offset(30);
        make.height.equalTo(@(18));
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userImage.mas_bottom).offset(15);
        make.centerX.equalTo(_userImage);
    }];
}


//更改背景图片
- (void)changeImage:(UITapGestureRecognizer *)sender {
    if(_delegate){
        [_delegate userInfoView:self didClickBackground:_imageView];
    }
}

//更改用户头像
- (void)userImageButtonClick:(UIButton *)sender {
    if([_delegate respondsToSelector:@selector(userInfoView:didClickUserImageButton:)]){
        [_delegate userInfoView:self didClickUserImageButton:sender];
    }
}

//登录
- (void)loginButtonClick:(UIButton *)sender {
    if([_delegate respondsToSelector:@selector(userInfoView:didClickLoginButton:)]){
        [_delegate userInfoView:self didClickLoginButton:sender];
    }
}

//注册
- (void)registerButtonClick:(UIButton *)sender {
    if([_delegate respondsToSelector:@selector(userInfoView:didClickRegisterButton:)]){
        [_delegate userInfoView:self didClickRegisterButton:sender];
    }
}

//签到
- (void)signButtonClick:(UIButton *)sender {
    sender.enabled = YES;
    [sender setTitle:@"  已签到  " forState:UIControlStateNormal];
}



#pragma mark - getter & setter

- (UIButton *)loginButton {
    if(_loginButton == nil){
        UIButton * loginButton = [UIButton see_buttonWithTitle:@"登录" titleColor:[UIColor whiteColor] fontSize:12 backgroundColor:[UIColor see_colorWithHex:0x00a1d9] target:self selector:@selector(loginButtonClick:) event:UIControlEventTouchUpInside];
        _loginButton = loginButton;
        loginButton.layer.cornerRadius = 11.5;
        loginButton.clipsToBounds = YES;
        [loginButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UIButton *)registerButton {
    if (_registerButton == nil){
        UIButton * registerButton = [UIButton see_buttonWithTitle:@"注册" titleColor:[UIColor whiteColor] fontSize:12 backgroundColor:[UIColor see_colorWithHex:0x98d361] target:self selector:@selector(registerButtonClick:) event:UIControlEventTouchUpInside];
        _registerButton = registerButton;
        registerButton.layer.cornerRadius = 11.5;
        registerButton.clipsToBounds = YES;
        [registerButton addTarget:self action:@selector(registerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

- (void)setAnimateHeight:(CGFloat)animateHeight {
    _animateHeight = animateHeight;
    [_userImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-_animateHeight / 10);
        make.size.mas_equalTo(CGSizeMake(86, 86));
    }];
    CGFloat alpha = (animateHeight - 117) / 90;
    _userImage.alpha = alpha;
    _loginButton.alpha = alpha;
    _registerButton.alpha = alpha;
    _siginButton.alpha = alpha;
    _vipButton.alpha = alpha;
    _nameLabel.alpha = alpha;
}

- (UILabel *)nameLabel {
    if(_nameLabel == nil){
        UILabel * label = [UILabel see_createWithFrame:CGRectZero textColor:[UIColor lightTextColor] fontSize:14 textAlignment:NSTextAlignmentCenter text:@"昵称"];
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UIButton *)siginButton {
    if(_siginButton == nil) {
        UIButton * button = [UIButton see_buttonWithTitle:@"  签到送积分  " titleColor:[UIColor colorWithWhite:0.9 alpha:1] fontSize:12 backgroundColor:[UIColor see_colorWithHex:0x958575] target:self selector:@selector(signButtonClick:) event:UIControlEventTouchUpInside];
        button.layer.cornerRadius = 9;
        button.layer.masksToBounds = YES;
        _siginButton = button;
    }
    return _siginButton;
}

- (UIButton *)vipButton {
    if(_vipButton == nil){
        UIButton * button = [[UIButton alloc]init];
        [button see_buttonWithImage:@"common_icon_membership_level2" imageSize:CGSizeMake(17, 17) title:@"高级会员" titleColor:[UIColor see_colorWithHex:0x958575] fontSize:12 lineSpace:4];
        _vipButton = button;
    }
    return _vipButton;
}



@end
