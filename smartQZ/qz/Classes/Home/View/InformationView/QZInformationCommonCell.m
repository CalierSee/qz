//
//  QZInformationCommonCell.m
//  qz
//
//  Created by 景彦铭 on 2016/12/25.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZInformationCommonCell.h"
#import "QZAttactionView.h"
@interface QZInformationCommonCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet QZAttactionView *star;
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *commonText;



@end

@implementation QZInformationCommonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configerCell:(QZCommonModel *)model {
    _userIcon.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:model.icon ofType:nil]];
    _userName.text = model.name;
    [_star drawWithImages:[model starImage]];
    _score.text = model.level;
    _date.text = model.date;
    _commonText.text = model.text;
}

@end
