//
//  QZInformationFooter.m
//  qz
//
//  Created by 景彦铭 on 2016/12/25.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZInformationFooter.h"

@interface QZInformationFooter ()

@property(nonatomic,weak)IBOutlet UIButton *button;

@end

@implementation QZInformationFooter

- (void)awakeFromNib {
    [super awakeFromNib];
    _button.layer.borderColor = [UIColor see_colorWithHex:0x009AE5].CGColor;
}

- (void)title:(NSString *)title {
    [_button setTitle:title forState:UIControlStateNormal];
}

- (IBAction)buttonClick:(UIButton *)sender {
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
