//
//  UIImage+SEEQuick.h
//  画板Max
//
//  Created by 景彦铭 on 2016/10/1.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SEEQuick)

/**
 得到指定点的颜色

 @param point 点
 */
- (UIColor *)colorAtPixel:(CGPoint)point;


/**
 返回一张透明图片

 @param size 图片大小
 */
+ (instancetype)see_blankImageWithSize:(CGSize)size;

+ (instancetype)see_imageWithSize:(CGSize)size color:(UIColor *)color;

//获得屏幕截图
+ (instancetype)see_screenShot;


@end
