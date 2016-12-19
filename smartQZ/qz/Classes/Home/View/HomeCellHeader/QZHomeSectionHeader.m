//
//  QZHomeSectionHeader.m
//  qztourist
//
//  Created by 景彦铭 on 2016/12/9.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZHomeSectionHeader.h"
#import "QZHomeModel.h"
@interface QZHomeSectionHeader ()

@property (weak, nonatomic) IBOutlet UIButton *title;

@end

@implementation QZHomeSectionHeader

- (void)setModel:(QZHomeModel *)model {
    _model = model;
    [_title setTitle:model.header forState:UIControlStateNormal];
    [_title setImage:[[UIImage imageNamed:model.icon]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
}

@end
