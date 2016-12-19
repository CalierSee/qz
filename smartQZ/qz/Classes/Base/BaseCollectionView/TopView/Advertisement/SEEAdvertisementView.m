//
//  SEEAdvertisementView.m
//  SEEQuick
//
//  Created by 景彦铭 on 16/9/18.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "SEEAdvertisementView.h"
#import "UICollectionView+SEEQuick.h"
#import "SEEAdvertisementCell.h"
#import "SEEAdvertisementFlowLayout.h"
#import "UICollectionViewFlowLayout+SEEQuick.h"
#import "UIPageControl+SEEQuick.h"
#import "Masonry.h"
#import "SEETimer.h"
#define ScaleSeeds 100  //解决滚屏卡顿
static NSString * cellID = @"cell";
static NSInteger timeInterval = 2;
@interface SEEAdvertisementView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,weak)UICollectionView *collectionView;
@property(nonatomic,weak)UIPageControl *pageControl;
@property(nonatomic,weak)NSTimer * timer;
@end


@implementation SEEAdvertisementView
//代码入口
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadUI];
    }
    return self;
}
//nib入口
- (void)awakeFromNib {
    [super awakeFromNib];
    [self loadUI];
}

#pragma mark - 载入UI界面
- (void)loadUI {
    //创建UICollectionView
    SEEAdvertisementFlowLayout * layout = [SEEAdvertisementFlowLayout see_createWithClassName:[SEEAdvertisementFlowLayout class] minimumLineSpacing:0 minimumInteritemSpacing:0 scrollDirection:UICollectionViewScrollDirectionHorizontal];
    UICollectionView * collectionV = [UICollectionView see_createWithFrame:self.bounds registerClass:[SEEAdvertisementCell class] cellReuseIdentifier:@"cell" layout:layout delegate:self dataSource:self];
    _collectionView = collectionV;
    [self addSubview:collectionV];
    //创建pageControl
    UIPageControl * pageC = [[UIPageControl alloc]init];
    _pageControl = pageC;
    [self addSubview:pageC];
    [pageC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self);
    }];
    pageC.userInteractionEnabled = NO;
}
#pragma mark 父控件确定后重新计算子控件位置
- (void)layoutSubviews{
    [super layoutSubviews];
    _collectionView.frame = self.bounds;
    _collectionView.bounces = NO;
}
#pragma mark - 载入数据创建pageControl重新重新载入CollectionView
- (void)setAdvertisements:(NSArray<SEEAdvertisement *> *)advertisements{
    if(_advertisements == advertisements){//判断重新输入的数据是否与现在的数据相同
        return ;
    }
    if (advertisements.count == 1){
        _collectionView.scrollEnabled = NO;
        _pageControl.hidden = YES;
        _advertisements = advertisements;
        return ;
    }
    _advertisements = advertisements;
    //销毁定时器
    [_timer invalidate];
    //重新载入CollectionView数据
    [_collectionView reloadData];
    //配置pageControl
    [_pageControl see_numberOfPage:advertisements.count currentPage:0 currentPageIndicatorTintColor:[UIColor see_colorWithHex:0x1aa1e6] pageIndicatorTintColor:[UIColor whiteColor]];
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:advertisements.count * ScaleSeeds inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    //创建定时器
    NSTimer * timer = [SEETimer timerWithTimeInterval:timeInterval target:self selector:@selector(startScroll) userInfo:nil repeats:YES];
    _timer = timer;
}

#pragma mark - 定时器监听方法
- (void)startScroll {
    //判断当前视图是否正在显示，如果不显示就暂停滚动
    if(self.window == nil){
        return ;
    }
    if (_advertisements.count != 1){
        //找到当前显示的item的indexpath
        NSInteger index = [_collectionView indexPathsForVisibleItems].lastObject.item;
        //设置滚动到下一个item
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index + 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
}


#pragma mark - UICollectionViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //设置pageControl
    NSInteger page = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
    _pageControl.currentPage = page % _advertisements.count;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //设置无线滚
    NSInteger page = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
    if(page == _advertisements.count * 2 * ScaleSeeds - 1){
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_advertisements.count * ScaleSeeds - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }
    else if(page == 0){
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_advertisements.count * ScaleSeeds inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }
}
//判断是否该切换item
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self scrollViewDidEndDecelerating:scrollView];
}
//拖拽停止自动滚动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _timer.fireDate = [NSDate distantFuture];
}
//停止拖拽开始自动滚动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    _timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:3];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _advertisements.count * 2 * ScaleSeeds;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SEEAdvertisementCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.advertisement = _advertisements[indexPath.item % _advertisements.count];
    return cell;
}

#pragma mark - UICollectionViewDelegate
//选中广告返回对应广告模型对象
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [[NSNotificationCenter defaultCenter]postNotificationName:SEEAdvertisementViewNotification object:self userInfo:@{@"advertisement":_advertisements[indexPath.row % _advertisements.count]}];
}

@end
