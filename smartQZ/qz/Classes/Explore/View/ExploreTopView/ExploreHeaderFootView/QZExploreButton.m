//
//  QZExploreButton.m
//  qztourist
//
//  Created by 景彦铭 on 2016/12/5.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZExploreButton.h"

@interface QZExploreButton ()

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *detail;

@property(nonatomic,strong)UIImage * image;

@end

@implementation QZExploreButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadUI];
    }
    return self;
}

- (void)loadUI {
    UILabel * label = [[UILabel alloc]init];
    
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return CGRectContainsPoint(self.bounds, point);
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.userInteractionEnabled && self.hidden == NO && self.alpha > 0.01){
        if ([self pointInside:point withEvent:event]){
            return self;
        }
        else {
            return nil;
        }
    }else {
        return nil;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
