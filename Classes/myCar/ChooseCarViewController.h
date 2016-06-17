//
//  ChooseCarViewController.h
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/1/22.
//  Copyright © 2016年 yim. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^chooseCarFinished)(NSDictionary *brand,NSDictionary *model,NSDictionary *detail);

@interface ChooseCarViewController : UIViewController

/**
 *  选择完成后回调
 */
@property (strong,nonatomic) chooseCarFinished chooseCallBack;

@end
