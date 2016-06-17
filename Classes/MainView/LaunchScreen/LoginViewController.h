//
//  LoginViewController.h
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/1/11.
//  Copyright © 2016年 yim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

/**
 *  登录成功
 */
@property (strong,nonatomic) void (^loginSucBlock)();


@property (assign,nonatomic) BOOL formLaunchVC;

@end
