//
//  QZAttactionLocation.m
//  qz
//
//  Created by 景彦铭 on 2016/12/20.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZAttactionLocation.h"

@interface QZAttactionLocation () <AMapSearchDelegate>

@property (nonatomic,copy) void(^distanceBlock)(double distance);

@property (nonatomic,copy) void(^weatherCompleteBlock)(NSString * weather);

@property(nonatomic,strong)AMapSearchAPI * searchAPI;

@property (nonatomic,assign)double distance;

@property(nonatomic,strong)CLLocation * userLocation;

@property (nonatomic,assign)BOOL hasGeo;

@property(nonatomic,strong)CLLocation * geoLocation;

@property (nonatomic,copy) NSString *geo;

@property (nonatomic,copy) NSString *weather;

@property (nonatomic,copy) NSString *adcode;

@end

@implementation QZAttactionLocation

- (instancetype)initWithGeoString:(NSString *)geo {
    if (self = [super init]) {
        _geo = geo;
    }
    return self;
}

- (void)distanceWithUserLocation:(CLLocation *)location complete:(void (^)(double))complete{
    if (_distance == 0){
        _distanceBlock = complete;
        _userLocation = location;
        AMapGeocodeSearchRequest * geoRequest = [[AMapGeocodeSearchRequest alloc]init];
        geoRequest.address = _geo;
        [self.searchAPI AMapGeocodeSearch:geoRequest];
        return;
    }
    _distanceBlock(_distance);
}

- (void)weatherStringWithCity:(NSString *)city complete:(void(^)(NSString *))complete {
    if (_weather == nil) {
        _weatherCompleteBlock = complete;
        AMapWeatherSearchRequest *request = [[AMapWeatherSearchRequest alloc] init];
        request.city = _adcode;
        request.type = AMapWeatherTypeForecast; //AMapWeatherTypeLive为实时天气；AMapWeatherTypeForecase为预报天气
        [self.searchAPI AMapWeatherSearch:request];
        return ;
    }
    _weatherCompleteBlock(_weather);
}

#pragma mark - AMapSearchDelegate

/**
 地理查询
 */
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response {
    AMapGeocode * code = response.geocodes[0];
    self.geoLocation = [[CLLocation alloc]initWithLatitude:code.location.latitude longitude:code.location.longitude];
    double distance = 0;
    _adcode = code.adcode;
    distance = [self.userLocation distanceFromLocation:self.geoLocation];
    _distance = distance;
    _distanceBlock(distance);
}


/**
 天气查询
 */
- (void)onWeatherSearchDone:(AMapWeatherSearchRequest *)request response:(AMapWeatherSearchResponse *)response{
    AMapLocalDayWeatherForecast * cast = response.forecasts[0].casts[0];
    NSString * date = [cast.date componentsSeparatedByString:@"-"][1];
    date = [date stringByAppendingString:[NSString stringWithFormat:@"月%@日  %@℃ - %@℃  %@",[cast.date componentsSeparatedByString:@"-"][2],cast.dayTemp,cast.nightTemp,cast.dayWeather]];
    _weather = date;
    _weatherCompleteBlock(date);
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", error);
}
#pragma mark - getter setter

- (AMapSearchAPI *)searchAPI {
    if (_searchAPI == nil) {
        _searchAPI = [[AMapSearchAPI alloc]init];
        _searchAPI.delegate = self;
    }
    return _searchAPI;
}

@end
