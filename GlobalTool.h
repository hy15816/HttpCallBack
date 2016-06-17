//
//  GlobalTool.h
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/1/22.
//  Copyright © 2016年 yim. All rights reserved.
//

#import <Foundation/Foundation.h>

UIKIT_EXTERN NSString *const kLoginNotifyName;


#define kStoryboardFirst(storyboardID)    [[UIStoryboard storyboardWithName:@"FirstStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:storyboardID];


@interface GlobalTool : NSObject

+(GlobalTool *)sharedTool;
@property(nonatomic,strong) NSMutableDictionary *exchangeDic;

@property(nonatomic,strong) NSMutableDictionary *userInfoDic;


#pragma mark --抖动窗口--
+ (void)animateIncorrectMessage:(UIView *)view;

+ (NSString *)stringWithFormat:(NSString *)format;
+ (NSDictionary *)getAreaDic;
@end
