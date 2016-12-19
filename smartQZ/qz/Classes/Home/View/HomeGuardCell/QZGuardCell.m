//
//  QZGuardCell.m
//  qztourist
//
//  Created by 景彦铭 on 2016/12/9.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZGuardCell.h"

@interface QZGuardCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end


@implementation QZGuardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setInformation:(QZInformationModel *)information {
    _information = information;
    _iconView.image = [UIImage imageNamed:[[NSBundle mainBundle]pathForResource:information.icon ofType:@"png"]];
    _titleLabel.text = information.name;
    _detailLabel.text = information.detail;
    
}

@end
