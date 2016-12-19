//
//  QSPullDownRefreshControl.h
//  自定义下拉刷新控件
//
//  Created by zhangping on 16/5/20.
//  Copyright © 2016年 zhangping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SEEPullDownRefreshControl : UIView

/**
 *  回调block
 */
@property (nonatomic, copy) void(^refreshingHandler)();

/**
 *  结束刷新
 */
- (void)endRefreshing;

/**
 *  开始刷新
 */
- (void)beginRefreshing;


@end
