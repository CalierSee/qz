//
//  QZBaseIconButton.m
//  qztourist
//
//  Created by 景彦铭 on 2016/12/5.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZBaseIconButton.h"

@implementation QZBaseIconButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.width);
    self.titleLabel.frame = CGRectMake(0, self.bounds.size.width, self.bounds.size.width, self.bounds.size.height - self.bounds.size.width);
}

- (void)loadUI {
    [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)buttonWithImage:(NSString *)image title:(NSString *)title titleColor:(UIColor *)color fontSize:(CGFloat)size target:(id)target selector:(SEL)selector event:(UIControlEvents)event {
    [self setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:color forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:size];
    [self addTarget:target action:selector forControlEvents:event];
}


@end
