//
//  QZBaseIconView.m
//  qztourist
//
//  Created by 景彦铭 on 2016/12/5.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZBaseIconView.h"

@interface QZBaseIconView ()
@property (nonatomic,assign)CGSize buttonSize;
@property (nonatomic,assign)NSInteger numberOfLine;
@end

@implementation QZBaseIconView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadUI];
    }
    return self;
}

- (void)loadUI {
    self.backgroundColor = [UIColor whiteColor];
}

- (void)setIconArray:(NSArray<NSDictionary *> *)iconArray {
    _iconArray = iconArray;
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    CGFloat margin = ([UIScreen mainScreen].bounds.size.width - self.numberOfLine * self.buttonSize.width) / (_numberOfLine + 1);
    CGRect base = CGRectMake(margin, 10, _buttonSize.width, _buttonSize.height);
    NSInteger index = 0;
    for (NSDictionary * dict in iconArray) {
        QZBaseIconButton * button = [[QZBaseIconButton alloc]init];
        button.frame = CGRectOffset(base, (margin + _buttonSize.width) * (index % _numberOfLine), (10 + _buttonSize.height) * (index / _numberOfLine));
        [button buttonWithImage:dict[@"icon"] title:dict[@"title"] titleColor:[UIColor darkGrayColor] fontSize:14 target:self selector:@selector(iconButtonClick:) event:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",dict[@"icon"]]] forState:UIControlStateHighlighted];
        [self addSubview:button];
        button.tag = index;
        index ++;
    }
}

- (void)iconButtonClick:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:IconButtonClickNotification object:nil userInfo:@{@"sender":sender,@"vc":_iconArray[sender.tag][@"viewController"],@"title":_iconArray[sender.tag][@"title"]}];
}

- (NSInteger)numberOfLine {
    if (_numberOfLine == 0){
        _numberOfLine = [self numberOfLineInView];
    }
    return _numberOfLine;
}

- (CGSize)buttonSize {
    if(CGSizeEqualToSize(_buttonSize, CGSizeZero)) {
        _buttonSize = [self sizeForButton];
    }
    return _buttonSize;
}

- (NSInteger)numberOfLineInView {
    return 3;
}

- (CGSize)sizeForButton {
    return CGSizeZero;
}

@end
