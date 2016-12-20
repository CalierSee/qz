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
@interface QZInformationView ()
@property (weak, nonatomic) IBOutlet UILabel *desc;
//门票抬头
@property (weak, nonatomic) IBOutlet UILabel *ticketTitleLabel;
//价格
@property (weak, nonatomic) IBOutlet UILabel *prictLabel;
//立减
@property (weak, nonatomic) IBOutlet UIButton *freeLabel;
//门票须知
@property (weak, nonatomic) IBOutlet UILabel *ticketDescLabels;
@property (weak, nonatomic) IBOutlet SEEAdvertisementView *advView;

@end

@implementation QZInformationView

- (void)awakeFromNib {
    [super awakeFromNib];
    _freeLabel.layer.borderColor = _freeLabel.titleLabel.textColor.CGColor;
}

//分享按钮
- (IBAction)shareButtonClick:(UIButton *)sender {
}
//定位按钮
- (IBAction)locationGestureClick:(UITapGestureRecognizer *)sender {
}
//套餐说明按钮
- (IBAction)directionsButtonClick:(UIButton *)sender {
}
//景点酒店按钮
- (IBAction)hotilGestureClick:(UITapGestureRecognizer *)sender {
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
}

@end
