//
//  SEETimer.m
//  SEEQuick
//
//  Created by 景彦铭 on 2016/10/14.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "SEETimer.h"

@interface SEETimer ()
@property(nonatomic,weak)id target;
@property (nonatomic,assign)SEL aSelector;
@end

@implementation SEETimer

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo {
    SEETimer * target = [[SEETimer alloc]init];
    target.target = aTarget;
    target.aSelector = aSelector;
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:ti target:target selector:@selector(targetSEL:) userInfo:userInfo repeats:yesOrNo];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    return timer;
}

+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo {
    SEETimer * target = [[SEETimer alloc]init];
    target.target = aTarget;
    target.aSelector = aSelector;
    NSTimer * timer = [NSTimer timerWithTimeInterval:ti target:target selector:@selector(targetSEL:) userInfo:userInfo repeats:yesOrNo];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    return timer;
}

- (void)targetSEL:(NSTimer *)timer {
    [_target performSelector:_aSelector withObject:timer];
}

@end
