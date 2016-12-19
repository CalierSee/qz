//
//  QZAttactionChooseView.m
//  qz
//
//  Created by 景彦铭 on 2016/12/17.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZAttactionChooseView.h"
#import "QZAttactionButton.h"
@interface QZAttactionChooseView ()

@property(nonatomic,weak)UIButton *selectButton;
@property (weak, nonatomic) IBOutlet QZAttactionButton *defaultButton;

@end

@implementation QZAttactionChooseView

- (void)awakeFromNib {
    [super awakeFromNib];
    _selectButton = _defaultButton;
}

- (IBAction)sortButtonClick:(UIButton *)sender {
    _selectButton.selected = NO;
    _selectButton = sender;
    sender.selected = YES;
    _sortMode = sender.tag;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}


@end
