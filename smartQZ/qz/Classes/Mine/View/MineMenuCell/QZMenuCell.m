//
//  QZMenuCell.m
//  qztourist
//
//  Created by 景彦铭 on 2016/11/29.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZMenuCell.h"

@interface QZMenuCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation QZMenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _iconView.layer.cornerRadius = 14;
    _iconView.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setMenu:(QZMineMenu *)menu {
    _menu = menu;
    _iconView.image = [UIImage imageNamed:menu.icon];
    _nameLabel.text = menu.name;
}


@end
