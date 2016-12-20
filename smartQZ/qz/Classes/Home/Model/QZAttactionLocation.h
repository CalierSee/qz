//
//  QZAttactionLocation.h
//  qz
//
//  Created by 景彦铭 on 2016/12/20.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QZAttactionLocation : NSObject

- (void)weatherStringWithCity:(NSString *)city complete:(void(^)(NSString *))complete;

- (void)distanceWithUserLocation:(CLLocation *)location complete:(void(^)(double distance))complete;

- (instancetype)initWithGeoString:(NSString * )geo;


@end
