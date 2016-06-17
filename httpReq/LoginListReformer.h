//
//  OrderListReformer.h
//  HttpCallBack
//
//  Created by AEF-RD-1 on 15/12/26.
//  Copyright © 2015年 yim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIManager.h"
#import "LoginList.h"

extern NSString *const kLoginListDataKeyCode;
extern NSString *const kLoginListDataKeyExtrDatas;
extern NSString *const kLoginListDataKeyMsg;

@interface LoginListReformer : APIManager

- (NSDictionary *)reformData:(NSDictionary *)originData fromManager:(APIManager *)manager;


@end
