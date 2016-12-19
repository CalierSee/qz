//
//  SEEAdvertisement.h
//  SEEQuick
//
//  Created by 景彦铭 on 2016/9/25.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SEEAdvertisement : NSObject
@property (nonatomic,copy) NSString *image;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)advertisementWithDictionary:(NSDictionary *)dict;
@end
