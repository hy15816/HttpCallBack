//
//  AppDelegate.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 15/12/24.
//  Copyright © 2015年 yim. All rights reserved.
//

#import "AppDelegate.h"
#import "LaunchViewController.h"
#import "ViewController.h"
#import "TabBarViewController.h"
#import <AVFoundation/AVFoundation.h>

NSString *const kIsLogin = @"isLogin";
NSString *const kResetWoindowRootViewControllerNotify = @"ResetWoindowRootViewControllerNotify";
NSString *const kNotifityNameScanAction  = @"kNotifityNameScanAction";

@interface AppDelegate ()
{
    UIBackgroundTaskIdentifier bgTaskIndentifier;
    UIBackgroundTaskIdentifier oldBgTaskIndentifier;
}

@property (assign,nonatomic) NSInteger count;
@property (strong,nonatomic) UINavigationController *navc;
@property (strong,nonatomic) NSTimer *myTimer;

@property (strong,nonatomic) AVAudioPlayer *avPlayer;//播放器


@end



@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kIsLogin];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:kIsLogin]) {
        
        LaunchViewController *containController = [[LaunchViewController alloc] initWithNibName:@"LaunchViewController" bundle:nil];
        containController.view.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:containController];
        navc.navigationBarHidden = YES;
        self.window.rootViewController = navc;
        [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            //
            containController.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        } completion:^(BOOL finished) {
            //
        }];
        
        
    }
    
    ViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController"];
    _navc = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetWindowRootViewController) name:kResetWoindowRootViewControllerNotify object:nil];
    
    
//    [self resetWindowRootViewController];
    
    
    return YES;
}




- (void)resetWindowRootViewController {
    TabBarViewController *tabbar = [[TabBarViewController alloc] init];
    //NNLog(@" add navc");
    self.window.rootViewController = tabbar;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

// 1.在info.plist 加入UIBackgroundModes-voip
// 2.定义UIBackgroundTaskIdentifier bgTask
- (void)applicationDidEnterBackground:(UIApplication *)application {

    
//    [[NSNotificationCenter defaultCenter] postNotificationName:kNotifityNameScanAction object:nil];
    
//    if ([self m_isMultitaskingSupported] == NO) {
//        return;
//    }
//    
//    bgTaskIndentifier = [application beginBackgroundTaskWithExpirationHandler:^{
//        //
//        NSLog(@"beginBackgroundTaskWithExpirationHandler");
//    }];
//    
//    oldBgTaskIndentifier = bgTaskIndentifier;
//    if (self.myTimer == nil) {
//        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerMethod:) userInfo:nil repeats:YES];
//        self.myTimer = timer;
//        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
//    }
    
}



- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    if (bgTaskIndentifier != UIBackgroundTaskInvalid) {
        [application endBackgroundTask:bgTaskIndentifier];
        if ([self.myTimer isValid]) {
            [self.myTimer invalidate];
            self.myTimer = nil;
        }
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - ==============

- (BOOL)m_isMultitaskingSupported {
    
    BOOL result = NO;
    if ([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)]) {
        result = [[UIDevice currentDevice] isMultitaskingSupported];
    }
    
    return result;
}

- (void)timerMethod:(NSTimer *)paramSender {
    
    self.count ++ ;
    NSLog(@"count .........%ld",(long)self.count);
    NSTimeInterval t = [[UIApplication sharedApplication] backgroundTimeRemaining];
    NSLog(@"    t .........%f",t);

    
    if ((int)t <= 160) {
        [[UIApplication  sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
            //
            NSLog(@"(int)t <= 160 ---count:%ld",(long)self.count);
        }];
    }
    
    
}

@end
