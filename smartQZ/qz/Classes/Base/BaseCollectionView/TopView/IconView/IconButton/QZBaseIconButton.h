//
//  QZBaseIconButton.h
//  qztourist
//
//  Created by 景彦铭 on 2016/12/5.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QZBaseIconButton : UIButton
- (void)buttonWithImage:(NSString *)image title:(NSString *)title titleColor:(UIColor *)color fontSize:(CGFloat)size target:(id)target selector:(SEL)selector event:(UIControlEvents)event ;
@end
