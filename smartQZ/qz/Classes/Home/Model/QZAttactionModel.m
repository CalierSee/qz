//
//  QZAttactionModel.m
//  qz
//
//  Created by 景彦铭 on 2016/12/17.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZAttactionModel.h"
#import "QZAttactionLocation.h"
@interface QZAttactionModel ()
@property(nonatomic,strong)CLLocation * userLocation;
@property(nonatomic,strong)QZAttactionLocation * attactionLocation;
@property(nonatomic,strong)AMapLocationManager * locationManager;

@end

@implementation QZAttactionModel

- (instancetype)initWithFile:(NSString *)file {
    if (self = [super init]) {
        [self attactionsWithFile:file];
        [self loadUserLocation];
    }
    return self;
}

- (void)weatherStringWithComplete:(void (^)(NSString *))complete {
    [self.attactionLocation weatherStringWithCity:self.location complete:complete];
}

- (NSAttributedString *)descAttributeString {
    NSMutableAttributedString * stringM = [[NSMutableAttributedString alloc]initWithString:self.name attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14],NSForegroundColorAttributeName: [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1]}];
    [stringM appendAttributedString:[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"  %@",self.desc] attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12],NSForegroundColorAttributeName: [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1]}]];
    return stringM.copy;
}

- (UIImage *)iconImage {
    return [UIImage imageNamed:[[NSBundle mainBundle]pathForResource:self.icon ofType:@"png"]];
}

- (NSArray<UIImage *> *)starImage {
    NSInteger index = self.star.integerValue;
    BOOL flag = NO;
    if ((self.star.floatValue - index) != 0) {
        index++;
        flag = YES;
    }
    UIImage * image;
    NSMutableArray * arr = [NSMutableArray arrayWithCapacity:index];
    for (NSInteger i  = 0; i < 5; i++) {
        if (i < index - 1){
            image = [UIImage imageNamed:@"starfull"];
        }
        else if (i > index - 1) {
            image = [UIImage imageNamed:@"starempty"];
        }
        else if (flag){
            image = [UIImage imageNamed:@"starharf"];
        }
        else {
            image = [UIImage imageNamed:@"starfull"];
        }
        [arr addObject:image];
    }
    return arr.copy;
}

- (void)sortWithMode:(QZAttactionSortMode)mode {
    switch (mode) {
        case QZAttactionSortModeNormal:
            break;
        case QZAttactionSortModePrice:
            self.attactions = [self.attactions sortedArrayUsingComparator:^NSComparisonResult(QZAttactionModel * obj1, QZAttactionModel * obj2) {
                return obj1.price.floatValue > obj2.price.floatValue;
            }];
            break;
        case QZAttactionSortModeNumber:
            self.attactions = [self.attactions sortedArrayUsingComparator:^NSComparisonResult(QZAttactionModel * obj1, QZAttactionModel * obj2) {
                return obj1.common.floatValue < obj2.common.floatValue;
            }];
            break;
        case QZAttactionSortModeDistance:
            self.attactions = [self.attactions sortedArrayUsingComparator:^NSComparisonResult(QZAttactionModel * obj1, QZAttactionModel * obj2) {
                return obj1.distance < obj2.distance;
            }];
            break;
    }
}



- (void)attactionsWithFile:(NSString *)file {
    if (_attactions == nil) {
        NSArray * arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:nil]];
        NSArray * dataArray = [NSArray yy_modelArrayWithClass:[QZAttactionModel class] json:arr];
        _attactions = dataArray;
    }
}

- (AMapLocationManager *)locationManager {
    if (_locationManager == nil) {
        _locationManager = [[AMapLocationManager alloc]init];
        // 带逆地理信息的一次定位（返回坐标和地址信息）
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
        //   定位超时时间，最低2s，此处设置为2s
        _locationManager.locationTimeout =2;
        //   逆地理请求超时时间，最低2s，此处设置为2s
        _locationManager.reGeocodeTimeout = 2;
        
    }
    return _locationManager;
}

- (void)loadUserLocation {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.locationManager requestLocationWithReGeocode:NO completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
            if (error){
                if (error.code == AMapLocationErrorLocateFailed){
                    [self loadUserLocation];
                    return;
                }
            }
            _userLocation = location;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                for (QZAttactionModel * mode in self.attactions) {
                    [mode.attactionLocation distanceWithUserLocation:_userLocation complete:^(double distance) {
                        mode.distance = distance;
                        
                        
                        
                        
                    }];
                }
            });
        }];
    });
}

- (QZAttactionLocation *)attactionLocation {
    if (_attactionLocation == nil) {
        _attactionLocation = [[QZAttactionLocation alloc]initWithGeoString:self.location];
    }
    return _attactionLocation;
}


@end
