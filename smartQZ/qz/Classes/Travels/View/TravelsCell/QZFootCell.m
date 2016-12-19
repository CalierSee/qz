//
//  QZFootCell.m
//  qz
//
//  Created by 景彦铭 on 2016/12/13.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZFootCell.h"

@interface QZFootCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UILabel *look;

@end

@implementation QZFootCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setInformation:(QZInformationModel *)information {
    _information = information;
    _icon.image = [UIImage imageNamed:[[NSBundle mainBundle] pathForResource:information.icon ofType:@"png"]];
    _name.text = information.name;
    _detail.text = information.detail;
    _look.text = information.look;
    
}

@end
