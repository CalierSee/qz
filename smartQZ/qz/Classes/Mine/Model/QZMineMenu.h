//
//  QZMineMenu.h
//  qztourist
//
//  Created by 景彦铭 on 2016/11/29.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QZMineMenu : NSObject

@property (nonatomic,copy) NSString *icon;

@property (nonatomic,copy) NSString *name;

@property (nonatomic,copy) NSString *viewController;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)mineMenuWithDictionary:(NSDictionary *)dict;

@end
