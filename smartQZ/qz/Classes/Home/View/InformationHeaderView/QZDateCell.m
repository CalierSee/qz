//
//  QZDateCell.m
//  qz
//
//  Created by 景彦铭 on 2016/12/20.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZDateCell.h"

@interface QZDateCell ()

@property(nonatomic,strong)UIView * customSelectedBackgroundView;
@property (weak, nonatomic) IBOutlet UILabel *weekLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIView *background;

@end

@implementation QZDateCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.selectedBackgroundView = self.customSelectedBackgroundView;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (UIView *)customSelectedBackgroundView {
    if (_customSelectedBackgroundView == nil) {
        _customSelectedBackgroundView = [[UIView alloc]initWithFrame:self.bounds];
        _customSelectedBackgroundView.layer.cornerRadius = 8;
        _customSelectedBackgroundView.backgroundColor = [UIColor see_colorWithHex:0x1aa1e6];
    }
    return _customSelectedBackgroundView;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected){
        _dateLabel.textColor = [UIColor whiteColor];
        _weekLabel.textColor = [UIColor whiteColor];
        _background.backgroundColor = [UIColor see_colorWithHex:0x1aa1e6];
    }
    else {
        _dateLabel.textColor = [UIColor see_colorWithHex:0x948476];
        _weekLabel.textColor = [UIColor see_colorWithHex:0x666666];
        _background.backgroundColor = [UIColor whiteColor];
    }
}

@end
