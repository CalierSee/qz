//
//  QSPullDownRefreshControl.m
//  自定义下拉刷新控件
//
//  Created by zhangping on 16/5/20.
//  Copyright © 2016年 zhangping. All rights reserved.
//

#import "SEEPullDownRefreshControl.h"

/**
 *  刷新控件高度
 */
#define CZRefreshControlHeight 60

/**
 *  刷新控件宽度
 */
#define CZRefreshControlWidth 200

#pragma mark - 3种状态文字
#define NormalText @"下拉刷新"

#define PullingText @"释放刷新"

#define RefreshingText @"正在刷新..."

#pragma mark - 2种状态图片
/**
 正常状态图片
 */
#define NormalImage [UIImage imageNamed:@"dropdown_anim__0001"]
/**
 释放刷新图片
 */
#define PullingImage [UIImage imageNamed:@"dropdown_anim__00060"]


/// 刷新控件刷新状态
typedef enum {
    SEEPullDownRefreshStatusNormal = 0,     // 箭头向下
    SEEPullDownRefreshStatusPulling,  // 箭头向上,松手就刷新
    SEEPullDownRefreshStatusRefreshing      // 正在刷新
} SEEPullDownRefreshStatus;

@interface SEEPullDownRefreshControl ()

/**
 *  当前状态
 */
@property(nonatomic, assign) SEEPullDownRefreshStatus currentStatus;

/**
 *  父控件
 */
@property(nonatomic, strong) UIScrollView *superScrollView;

/**
 *  正在刷新图片数组
 */
@property (nonatomic, strong) NSArray *refreshingImages;

// MARK: - UI
/// 显示图片的imageView
@property (nonatomic, strong) UIImageView *animView;

/// 显示文本的label
@property (nonatomic, strong) UILabel *label;

@end

@implementation SEEPullDownRefreshControl

#pragma mark - 公开方法
/**
 *  结束刷新
 */
- (void)endRefreshing {
    // 从刷新状态切换到正常状态
    if (self.currentStatus == SEEPullDownRefreshStatusRefreshing) {
        self.currentStatus = SEEPullDownRefreshStatusNormal;
        
        // 正在刷新切换到正常状态,tableView往上走下拉刷新控件的高度,让下拉刷新控件在导航栏下面
        [UIView animateWithDuration:0.25 animations:^{
            UIEdgeInsets newInsets = self.superScrollView.contentInset;
            self.superScrollView.contentInset = UIEdgeInsetsMake(newInsets.top - CZRefreshControlHeight, newInsets.left, newInsets.bottom, newInsets.right);
        }];
    }
}

/**
 *  开始刷新
 */
- (void)beginRefreshing {
    if (self.currentStatus == SEEPullDownRefreshStatusNormal) {
        self.currentStatus = SEEPullDownRefreshStatusRefreshing;
    }
}

/**
 *  构造方法
 *  @param frame frame
 *  @return instancetype
 */
- (instancetype)initWithFrame:(CGRect)frame {
    CGRect newFrame = CGRectMake(0, -CZRefreshControlHeight, CZRefreshControlWidth, CZRefreshControlHeight);
    if (self = [super initWithFrame:newFrame]) {
//        self.backgroundColor = [UIColor brownColor];
        
        [self setupUI];
    }
    
    return self;
}



/// 设置UI
- (void)setupUI {
    // 添加子控件
    [self addSubview:self.animView];
    [self addSubview:self.label];
    
    self.animView.translatesAutoresizingMaskIntoConstraints = NO;
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    
    // 添加约束
    /// 图片
    NSLayoutConstraint *animViewCenterX = [NSLayoutConstraint constraintWithItem:self.animView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:-30];
    [self addConstraint:animViewCenterX];
    
    NSLayoutConstraint *animViewCenterY = [NSLayoutConstraint constraintWithItem:self.animView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self addConstraint:animViewCenterY];
    
    // label
    NSLayoutConstraint *labelViewCenterX = [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.animView attribute:NSLayoutAttributeTrailing multiplier:1 constant:15];
    [self addConstraint:labelViewCenterX];
    
    NSLayoutConstraint *labelViewCenterY = [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self addConstraint:labelViewCenterY];
    
    
    
}

/// 在对象销毁的时候移除监听
- (void)dealloc {
    [self.superScrollView removeObserver:self forKeyPath:@"contentOffset"];
}

/// View即将添加到父控件上面
- (void)willMoveToSuperview:(UIView *)newSuperview {
    // 先调用父类的方法
    [super willMoveToSuperview:newSuperview];
    // 判断是否是 UIScrollView或子类
    if ([newSuperview isKindOfClass:[UIScrollView class]]) {
        // 记录下这个控件,后续访问会使用到
        _superScrollView = (UIScrollView *)newSuperview;
        
        // 使用KVO监听父控件的滚动
        [_superScrollView addObserver:self forKeyPath:@"contentOffset" options:0 context:nil];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    /*
     状态切换
     1.用户拖动:
        SEEPullDownRefreshStatusNormal ==> SEEPullDownRefreshStatusPulling
        SEEPullDownRefreshStatusPulling ==> SEEPullDownRefreshStatusNormal
     2.用户松手:
         SEEPullDownRefreshStatusPulling ==> SEEPullDownRefreshStatusRefreshing
     */
    self.frame = CGRectMake(0, self.frame.origin.y, _superScrollView.frame.size.width, self.frame.size.height);
    CGFloat NormalToPullingOffset = -self.superScrollView.contentInset.top - CZRefreshControlHeight;
    if (self.superScrollView.isDragging) {
        if (self.currentStatus == SEEPullDownRefreshStatusPulling && self.superScrollView.contentOffset.y > NormalToPullingOffset) {
            self.currentStatus = SEEPullDownRefreshStatusNormal;
            NSLog(@"切换状态: %@", @"Normal");
        } else if (self.currentStatus == SEEPullDownRefreshStatusNormal && self.superScrollView.contentOffset.y < NormalToPullingOffset) {
            self.currentStatus = SEEPullDownRefreshStatusPulling;
            NSLog(@"切换状态: %@", @"Pulling");
        }
    } else {
        if (self.currentStatus == SEEPullDownRefreshStatusPulling) {
            self.currentStatus = SEEPullDownRefreshStatusRefreshing;
            NSLog(@"切换状态: %@", @"Refreshing");
        }
    }
}

/**
 *  设置当前状态
 *  @param currentStatus 当前状态
 */
- (void)setCurrentStatus:(SEEPullDownRefreshStatus)currentStatus {
    // 设置属性
    _currentStatus = currentStatus;
    
    // 设置完属性,判断当前状态
    switch (_currentStatus) {
        case SEEPullDownRefreshStatusNormal: {
            // 从正在刷新状态切换回来.停止动画,清除动画图片
            [self.animView stopAnimating];
            self.animView.animationImages = nil;
            
            self.label.text = NormalText;
            self.animView.image = NormalImage;
            break;
        }
            
        case SEEPullDownRefreshStatusPulling: {
            self.label.text = PullingText;
            self.animView.image = PullingImage;
            break;
        }
            
        case SEEPullDownRefreshStatusRefreshing: {
            self.label.text = RefreshingText;
            self.animView.animationImages = self.refreshingImages;
            self.animView.animationDuration = self.refreshingImages.count * 0.2;
            [self.animView startAnimating];
            
            // 停到导航栏下方,`contentInset.top` 在当前基础上添加 下拉刷新控件的高度
            [UIView animateWithDuration:0.25 animations:^{
                UIEdgeInsets insets = self.superScrollView.contentInset;
                self.superScrollView.contentInset = UIEdgeInsetsMake(insets.top + CZRefreshControlHeight, insets.left, insets.bottom, insets.right);
            }];
            
            // 调用block
            if (self.refreshingHandler) {
                self.refreshingHandler();
            }
            break;
        }
    }
}

#pragma mark - 懒加载
/**
 *  返回刷新时的图片数组
 *  @return 刷新时的图片数组
 */
- (NSArray *)refreshingImages {
    if (_refreshingImages == nil) {
        NSMutableArray *images = [NSMutableArray array];
        
        for (int i = 1; i <= 2; i++) {
#ifdef IMAGESNAMEFORMAT
            NSString *name = [NSString stringWithFormat:IMAGESNAMEFORMAT, i];
            UIImage *image = [UIImage imageNamed:name];
            [images addObject:image];
#endif
        }
        
        _refreshingImages = images;
    }
    
    return _refreshingImages;
}

/**
 *  懒加载显示图片的imageView
 *  @return 显示图片的imageView
 */
- (UIImageView *)animView {
    if (_animView == nil) {
        _animView = [[UIImageView alloc] initWithImage:NormalImage];
    }
    
    return _animView;
}

/**
 *  懒加载显示文字的label
 *  @return 显示文字的label
 */
- (UILabel *)label {
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.textColor = [UIColor darkGrayColor];
        _label.font = [UIFont systemFontOfSize:16];
        _label.text = NormalText;
        [_label sizeToFit];
    }
    
    return _label;
}
@end
