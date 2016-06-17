//
//  CommunityInfo.h
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/1/29.
//  Copyright © 2016年 yim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommunityInfo : NSObject

@property (strong,nonatomic) NSString *areaName;
@property (strong,nonatomic) NSString *cityName;
@property (strong,nonatomic) NSString *communityName;
@property (strong,nonatomic) NSString *provinceName;

@property (strong,nonatomic) NSDictionary *commDict;


+ (CommunityInfo *)info;

@end
