//
//  UserManager.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/1/11.
//  Copyright © 2016年 yim. All rights reserved.
//

#import "UserManager.h"

@interface UserManager ()

@property (strong,nonatomic) NSString *user_name;

@end

@implementation UserManager

#pragma mark - singletone
+ (UserManager *)user {
    
    static UserManager *cuser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (cuser == nil) {
            cuser = [[UserManager alloc] init];
        }
    });
    return cuser;
}

#pragma mark - public method
+ (void)login:(NSString *)name {
    
   [[UserManager user] loginWithName:name];
    
}

+ (BOOL)isLogin {
    
    return [[UserManager user] userIsLogin];
}

+ (BOOL)hasLogin {
    
    return [[UserManager user] userHasLogin];
}




#pragma mark - private method
- (void)loginWithName:(NSString *)name {
    
    self.user_name = name;
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"name"];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[NSString stringWithFormat:@"%@state",name]];
}

- (BOOL)userIsLogin {
    BOOL login = [[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"%@state",self.user_name]];
    return login;
}


- (BOOL)userHasLogin {
    BOOL hasLogin = [[[NSUserDefaults standardUserDefaults] valueForKey:@"name"] length];
    return hasLogin;
}
@end
