//
//  CommunityInfo.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/1/29.
//  Copyright © 2016年 yim. All rights reserved.
//

#import "CommunityInfo.h"

@implementation CommunityInfo

+ (CommunityInfo *)info {
    static CommunityInfo *comm = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        comm = [[CommunityInfo alloc] init];
    });
    
    return comm;
}

- (void)setCommDict:(NSDictionary *)commDict {
    
    self.areaName = commDict[@"area_name"];
    self.cityName = commDict[@"city_name"];
    self.communityName = commDict[@"community_name"];
    self.provinceName = commDict[@"province_name"];
    
}

- (NSString *)communityName {
    if (_communityName) {
        return _communityName;
    }
    return @"小区名称";
}

-(NSString *)provinceName {
    if (_provinceName) {
        return _provinceName;
    }
    return @"省名称";
}

- (NSString *)cityName {

    if (_cityName) {
        return _cityName;
    }
    return @"城市名称";
}

- (NSString *)areaName {
    if (_areaName) {
        return _areaName;
    }
    
    return @"区域";
}

@end
