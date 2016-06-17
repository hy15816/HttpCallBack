//
//  OrderListReformer.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 15/12/26.
//  Copyright © 2015年 yim. All rights reserved.
//

#import "LoginListReformer.h"

NSString * const kLoginListDataKeyCode      = @"code";
NSString * const kLoginListDataKeyExtrDatas = @"extrDatas";
NSString * const kLoginListDataKeyMsg       = @"msg";


@implementation LoginListReformer


- (NSDictionary *)reformData:(NSDictionary *)originData fromManager:(APIManager *)manager {

    NSDictionary *resultData = nil;
    if ([manager isKindOfClass:[LoginList class]]) {
        resultData = @{
                       kLoginListDataKeyCode:originData[@"code"],
                       kLoginListDataKeyExtrDatas:originData[@"extrDatas"],
                       kLoginListDataKeyMsg:originData[@"msg"]
                       };
    }
    
    NSLog(@"[resultData:fromManager:],resultData:%@",resultData);
    return resultData;
}

@end
