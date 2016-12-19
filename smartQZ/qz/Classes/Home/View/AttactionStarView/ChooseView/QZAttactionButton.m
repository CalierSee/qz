//
//  QZAttactionButton.m
//  qz
//
//  Created by 景彦铭 on 2016/12/17.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZAttactionButton.h"

@implementation QZAttactionButton


- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 50,self.imageView.frame.origin.y, self.imageView.frame.size.width,self.imageView.frame.size.height);
    self.titleLabel.frame = CGRectMake(16, self.titleLabel.frame.origin.y, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
}

@end
