//
//  QZInformationView.m
//  qz
//
//  Created by 景彦铭 on 2016/12/19.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZInformationView.h"
#import "SEEAdvertisementView.h"
#import "SEEAdvertisement.h"
#import "QZDateCell.h"
#import "QZShareBackgroundView.h"
#import "UIImage+ImageEffects.h"
#import <UMSocialCore/UMSocialCore.h>
@interface QZInformationView ()<UICollectionViewDelegate,UICollectionViewDataSource,POPAnimationDelegate>
@property (weak, nonatomic) IBOutlet UILabel *desc;
//门票抬头
@property (weak, nonatomic) IBOutlet UILabel *ticketTitleLabel;
//价格
@property (weak, nonatomic) IBOutlet UILabel *prictLabel;
//立减
@property (weak, nonatomic) IBOutlet UIButton *freeLabel;
//门票使用时间
@property (weak, nonatomic) IBOutlet UILabel *ticketDescLabels;
//预定限制
@property (weak, nonatomic) IBOutlet UILabel *order;
//门票使用方式
@property (weak, nonatomic) IBOutlet UILabel *userMethod;
@property (weak, nonatomic) IBOutlet SEEAdvertisementView *advView;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *weather;

@property(nonatomic,weak)IBOutlet UICollectionView *collectionView;

@property(nonatomic,weak)IBOutlet UICollectionViewFlowLayout *layout;

@property(nonatomic,weak)IBOutlet UIView *locationView;
@property(nonatomic,weak)IBOutlet UIImageView *locationIcon;

@property(nonatomic,weak)IBOutlet UIView *hotalView;

//分享内容
@property(nonatomic,strong)NSDictionary * shareInfo;


//分享面板
@property(nonatomic,strong)QZShareBackgroundView * shareView;

//分享类型按钮
@property(nonatomic,strong)NSArray <UIButton *> * shareTypeButtons;

@end

@implementation QZInformationView

- (void)awakeFromNib {
    [super awakeFromNib];
    _freeLabel.layer.borderColor = _freeLabel.titleLabel.textColor.CGColor;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"QZDateCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    _collectionView.pagingEnabled = YES;
    _layout.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width - 60) / 5 , 50);
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hotilGestureClick:)];
    [_hotalView addGestureRecognizer:tap1];
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(locationGestureClick:)];
    [_locationView addGestureRecognizer:tap2];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    });
}


#pragma mark - privateMethod

- (void)pushShareView {
    for (UIButton * button in self.shareTypeButtons) {
        [self.shareView addSubview:button];
    }
    [self sharButtonAnimationWithFlag:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication].keyWindow addSubview:self.shareView];
    });
}

- (void)sharButtonAnimationWithFlag:(BOOL)flag {
    for (UIButton * button in self.shareTypeButtons) {
        POPSpringAnimation * animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
        animation.beginTime = CACurrentMediaTime() + button.tag * 0.1;
        animation.springSpeed = 10;
        animation.springBounciness = 16;
        animation.toValue = flag ? ([NSValue valueWithCGPoint:CGPointMake(button.center.x, [UIScreen mainScreen].bounds.size.height - 300)]) : ([NSValue valueWithCGPoint:CGPointMake(button.center.x, [UIScreen mainScreen].bounds.size.height + 100)]);
        [button pop_addAnimation:animation forKey:nil];
    }
}

//分享网页
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:_shareInfo[@"name"] descr:_shareInfo[@"desc"] thumImage:[UIImage imageNamed:[[NSBundle mainBundle] pathForResource:_shareInfo[@"url"] ofType:@"png"]]];
    //设置网页地址
    shareObject.webpageUrl =@"http://mobile.umeng.com/social";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}


//分享消息
- (void)shareImageAndTextToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //设置文本
    messageObject.text = _shareInfo[@"desc"];
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    //shareObject.thumbImage = [UIImage imageNamed:[[NSBundle mainBundle]pathForResource:_shareInfo[@"url"] ofType:@"png"]];
    [shareObject setShareImage:[UIImage imageNamed:[[NSBundle mainBundle] pathForResource:_shareInfo[@"url"] ofType:@"png"]]];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

#pragma mark - Action

//关闭分享界面
- (void)dismiss:(UIButton *)sender {
    _shareView.userInteractionEnabled = NO;
    [self sharButtonAnimationWithFlag:NO];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [sender removeFromSuperview];
        _shareView = nil;
    });
}

- (void)chooseShareType:(UIButton *)sender {
    [self dismiss:self.shareView];
    switch (sender.tag) {
        case ShareTypeQQ:
            [self shareWebPageToPlatformType:UMSocialPlatformType_Qzone];
            break;
        case ShareTypeSina:
            [self shareImageAndTextToPlatformType:UMSocialPlatformType_Sina];
            break;
        case ShareTypeWX:
            [self shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine];
            break;
    }
}

//分享按钮
- (IBAction)shareButtonClick:(UIButton *)sender {
    [self pushShareView];
}
//定位按钮
- (void)locationGestureClick:(UITapGestureRecognizer *)sender {
    CGRect rect = [self.locationView convertRect:self.locationIcon.frame toView:self.window];
    [[NSNotificationCenter defaultCenter] postNotificationName:NeedPushMapViewNotification object:nil userInfo:@{@"rect": NSStringFromCGRect(rect)}];
}
//套餐说明按钮
- (IBAction)directionsButtonClick:(UIButton *)sender {
}
//景点酒店按钮
- (void)hotilGestureClick:(UITapGestureRecognizer *)sender {
}

#pragma mark - delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QZDateCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell loadDateWithIndex:indexPath.row];
    return cell;
}



#pragma mark - private method
- (void)attaction:(QZAttactionModel *)attaction {
    _desc.attributedText = attaction.descAttributeString;
    NSMutableArray * arr = [NSMutableArray array];
    for (NSString *str in attaction.images) {
        SEEAdvertisement * adv = [SEEAdvertisement advertisementWithDictionary:@{@"image": [str stringByAppendingString:@".png"]}];
        [arr addObject:adv];
    }
    _advView.advertisements = arr.copy;
    
    [attaction weatherStringWithComplete:^(NSString *weather) {
        _weather.text = weather;
    }];
    
    _location.text = attaction.location;
    
    _order.text = attaction.ticket[0];
    _userMethod.text = attaction.ticket[1];
    _ticketDescLabels.text = attaction.ticket[2];
    
    _shareInfo = @{
                   @"name":attaction.name,
                   @"desc":attaction.desc,
                   @"url":attaction.icon
                   };
    
}

- (QZShareBackgroundView *)shareView {
    if (_shareView == nil) {
        QZShareBackgroundView * buttonView = [[QZShareBackgroundView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        buttonView.backgroundColor = [UIColor clearColor];
        UIImage * backgroundImage = [UIImage see_screenShot];
        backgroundImage = [backgroundImage applyLightEffect];
        [buttonView setBackgroundImage:backgroundImage forState:UIControlStateNormal];
        [buttonView addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
        _shareView = buttonView;
        buttonView.showsTouchWhenHighlighted = NO;
    }
    _shareView.userInteractionEnabled = YES;
    return _shareView;
}

- (NSArray<UIButton *> *)shareTypeButtons {
    if (_shareTypeButtons == nil) {
        NSMutableArray * arr = [NSMutableArray array];
        NSArray * info = @[@"qq",@"wechat",@"sina"];
        CGFloat WH = 60;
        CGFloat margin = ([UIScreen mainScreen].bounds.size.width - WH * 3) / 4;
        CGRect base = CGRectMake(margin, ([UIScreen mainScreen].bounds.size.height + WH), WH, WH);
        for (NSInteger i  = 0; i < 3; i++) {
            UIButton * button = [UIButton see_buttonWithImage:[UIImage imageNamed:info[i]] target:self selector:@selector(chooseShareType:) event:UIControlEventTouchUpInside];
            button.imageView.contentMode = UIViewContentModeScaleAspectFill;
            button.layer.cornerRadius = WH / 2;
            button.clipsToBounds = YES;
            button.frame = CGRectOffset(base, (margin + WH) * i, 0);
            button.backgroundColor = [UIColor redColor];
            button.tag = i;
            [arr addObject:button];
        }
        _shareTypeButtons = arr.copy;
    }
    return _shareTypeButtons;
}

@end
