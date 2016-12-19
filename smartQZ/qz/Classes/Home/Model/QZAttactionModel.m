//
//  QZAttactionModel.m
//  qz
//
//  Created by 景彦铭 on 2016/12/17.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZAttactionModel.h"

@implementation QZAttactionModel

- (NSAttributedString *)descAttributeString {
    NSMutableAttributedString * stringM = [[NSMutableAttributedString alloc]initWithString:self.name attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14],NSForegroundColorAttributeName: [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1]}];
    [stringM appendAttributedString:[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"  %@",self.desc] attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12],NSForegroundColorAttributeName: [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1]}]];
    return stringM.copy;
}

- (UIImage *)iconImage {
    return [UIImage imageNamed:[[NSBundle mainBundle]pathForResource:self.icon ofType:@"png"]];
}

- (NSArray<UIImage *> *)starImage {
    NSInteger index = self.star.integerValue;
    BOOL flag = NO;
    if ((self.star.floatValue - index) != 0) {
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

+ (NSArray<QZAttactionModel *> *)sortWithMode:(QZAttactionSortMode)mode data:(NSArray<QZAttactionModel *> *)data {
    switch (mode) {
        case QZAttactionSortModeNormal:
            return data;
            break;
        case QZAttactionSortModePrice:
            return [data sortedArrayUsingComparator:^NSComparisonResult(QZAttactionModel * obj1, QZAttactionModel * obj2) {
                return obj1.price.floatValue > obj2.price.floatValue;
            }];
            break;
        case QZAttactionSortModeNumber:
            return [data sortedArrayUsingComparator:^NSComparisonResult(QZAttactionModel * obj1, QZAttactionModel * obj2) {
                return obj1.common.floatValue < obj2.common.floatValue;
            }];
            break;
        case QZAttactionSortModeDistance:
            return data;
            break;
            
        default:
            break;
    }
}

@end
