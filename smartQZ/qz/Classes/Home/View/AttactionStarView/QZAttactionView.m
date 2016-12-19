//
//  QZAttactionView.m
//  qz
//
//  Created by 景彦铭 on 2016/12/17.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZAttactionView.h"

@interface QZAttactionView ()

@property(nonatomic,strong)NSArray<UIImage *> * images;

@end


@implementation QZAttactionView

- (void)drawWithImages:(NSArray<UIImage *> *)images {
    _images = images;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGFloat magin = 1;
    CGRect baseRect = CGRectMake(0, 0, 15, 15);
    
    NSInteger index = 0;
    for (UIImage * image in _images) {
        [image drawInRect:CGRectOffset(baseRect, (magin + baseRect.size.width) * index, 0) blendMode:0 alpha:1];
        index++;
    }
}



@end
