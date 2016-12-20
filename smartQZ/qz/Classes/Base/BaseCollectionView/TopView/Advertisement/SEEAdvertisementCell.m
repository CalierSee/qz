//
//  SEEAdvertisementCell.m
//  SEEQuick
//
//  Created by 景彦铭 on 16/9/18.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "SEEAdvertisementCell.h"
@interface SEEAdvertisementCell ()
@property(nonatomic,weak)UIImageView *imageView;
@end
@implementation SEEAdvertisementCell
#pragma mark - 跟据模型中的图片地址通过url转换为图片


- (void)setAdvertisement:(SEEAdvertisement *)advertisement {
    _advertisement = advertisement;
    //根据image前缀判断是否为网址
    NSURL * url = nil;
    if([advertisement.image hasPrefix:@"http"]){
        url = [NSURL URLWithString:advertisement.image];
    }
    else {
        url = [[NSBundle mainBundle]URLForResource:advertisement.image withExtension:nil];
    }
    UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    _imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadUI];
    }
    return self;
}

#pragma mark - 载入UI界面
- (void)loadUI {
    UIImageView * imageV = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
    imageV.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView = imageV;
    imageV.clipsToBounds = YES;
    [self.contentView addSubview:imageV];
}



@end
