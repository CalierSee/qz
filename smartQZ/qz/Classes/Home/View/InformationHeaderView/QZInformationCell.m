//
//  QZInformationCell.m
//  qz
//
//  Created by 景彦铭 on 2016/12/20.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZInformationCell.h"
#import "QZAttactionModel.h"
#import "QZInformationView.h"
@interface QZInformationCell ()
@property (weak, nonatomic) IBOutlet QZInformationView *informationView;

@end

@implementation QZInformationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)attraction:(QZAttactionModel *)attaction {
    [self.informationView attaction:attaction];
}

@end
