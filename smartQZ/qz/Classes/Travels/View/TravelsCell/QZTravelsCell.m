//
//  QZTravelsCell.m
//  qz
//
//  Created by 景彦铭 on 2016/12/13.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZTravelsCell.h"

@interface QZTravelsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation QZTravelsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setInformation:(QZInformationModel *)information {
    _information = information;
    _icon.image = [UIImage imageNamed:[[NSBundle mainBundle]pathForResource:information.icon ofType:@"png"]];
    _title.text = information.name;
}

@end
