//
//  QZCommonModel.m
//  qz
//
//  Created by 景彦铭 on 2016/12/24.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZCommonModel.h"

@implementation QZCommonModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}


#pragma mark - getter & setter
- (NSArray<QZCommonModel *> *)commons {
    if (_commons == nil) {
        NSArray * arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"common" ofType:@"plist"]];
        _commons = [NSArray yy_modelArrayWithClass:[QZCommonModel class] json:arr];
    }
    return _commons;
}

- (NSArray<UIImage *> *)starImage {
    NSInteger index = self.level.integerValue;
    BOOL flag = NO;
    if ((self.level.floatValue - index) != 0) {
        index++;
        flag = YES;
    }
    UIImage * image;
    NSMutableArray * arr = [NSMutableArray arrayWithCapacity:index];
    for (NSInteger i  = 0; i < 5; i++) {
        if (i < index - 1){
            image = [UIImage imageNamed:@"starfull"];
        }
        else if (i > index - 1) {
            image = [UIImage imageNamed:@"starempty"];
        }
        else if (flag){
            image = [UIImage imageNamed:@"starharf"];
        }
        else {
            image = [UIImage imageNamed:@"starfull"];
        }
        [arr addObject:image];
    }
    return arr.copy;
}

@end
