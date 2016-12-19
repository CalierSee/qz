//
//  PLUSNewSpecialView.h
//  smart
//
//  Created by 景彦铭 on 16/9/6.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import <UIKit/UIKit.h>
///  新特性视图ScorllView实现自带PageControl 跳过按钮  详情按钮

@interface SEENewSpecialView : UIView
//新特性图片数组
@property (nonatomic,strong) NSArray<UIImage *>  *images;

///  创建视图
///
///  @param frame          frame
///  @param images         图片数组
///  @param bottomDistance 页控件距离底边间距（正数）
+ (instancetype)newSpecialViewWithFrame:(CGRect)frame images:(NSArray <UIImage *> *)images pageControlBottomDistance:(CGFloat)bottomDistance;

///  设置详情按钮
///
///  @param layout           布局  CGRectMake(与父视图右边距离，与父视图下边距离，按钮宽，按钮高)    与父视图右边距离，与父视图下边距离 均为负数
///  @param normalImage      普通状态图片
///  @param highlightedImage 高亮状态图片
- (void)informationButtonLayout:(CGRect)layout withNormalImageName:(NSString *)normalImage withHighlightedImageName:(NSString *)highlightedImage;

///  创建跳过按钮
///
///  @param layout 布局  CGRectMake(与父视图右边间距，与父视图上边间距，按钮宽，按钮高)  与父视图右边间距 为负数  与父视图上边间距 为正数
- (void)jumpButtonLayout:(CGRect)layout;
@end
