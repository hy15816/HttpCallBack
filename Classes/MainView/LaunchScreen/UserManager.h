//
//  UserManager.h
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/1/11.
//  Copyright © 2016年 yim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserManager : NSObject


/**
 *  用户登录
 *
 *  @param name 用户名
 */
+ (void)login:(NSString *)name;
/**
 *  是否登录
 *
 *  @return <#return value description#>
 */
+ (BOOL)isLogin;
/**
 *  是否登录过（是否保存了密码）
 *
 *  @return <#return value description#>
 */
+ (BOOL)hasLogin;

@end
