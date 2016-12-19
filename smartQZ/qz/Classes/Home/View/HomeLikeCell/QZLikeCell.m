//
//  QZLikeCell.m
//  qztourist
//
//  Created by 景彦铭 on 2016/12/9.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZLikeCell.h"

@interface QZLikeCell ()
@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIButton *local;

@end

@implementation QZLikeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setInformation:(QZInformationModel *)information {
    _information = information;
    _background.image = [UIImage imageNamed:[[NSBundle mainBundle]pathForResource:information.icon ofType:@"png"]];
    _name.text = information.name;
    [_local setTitle:information.location forState:UIControlStateNormal];
}

@end
