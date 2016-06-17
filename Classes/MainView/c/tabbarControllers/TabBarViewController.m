//
//  TabBarViewController.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/1/7.
//  Copyright © 2016年 yim. All rights reserved.
//

#import "TabBarViewController.h"
#import "NewsViewController.h"
#import "MusicViewController.h"
#import "YIMNavigationController.h"
#import "APIManager.h"
#import "NSDictionary+Assemble.h"
#import "MyCaViewController.h"
#import "LoginTableViewController.h"
#import "ContactsViewController.h"
#import "FirstViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //添加子控制器
    [self setupChildNavigationControllerWithClass:[YIMNavigationController class] tabBarImageName:@"tabbar_first" rootViewControllerClass:[FirstViewController class] rootViewControllerTitle:@"first"];
    
    [self setupChildNavigationControllerWithClass:[YIMNavigationController class] tabBarImageName:@"tabbar_first" rootViewControllerClass:[NewsViewController class] rootViewControllerTitle:@"news"];
    
    [self setupChildNavigationControllerWithClass:[YIMNavigationController class] tabBarImageName:@"tabbar_four" rootViewControllerClass:[MusicViewController class] rootViewControllerTitle:@"music"];
    
    [self setupChildNavigationControllerWithClass:[YIMNavigationController class] tabBarImageName:@"tabbar_four" rootViewControllerClass:[MyCaViewController class] rootViewControllerTitle:@"myCar"];
    
    [self setupChildNavigationControllerWithClass:[YIMNavigationController class] tabBarImageName:@"tabbar_four" rootViewControllerClass:[ContactsViewController class] rootViewControllerTitle:@"contacts"];
    
    //NSLog(@"%@",[NSString stringWithUTF8String:__FILE__]);
    //NSLog(@"%@",NSStringFromSelector(_cmd));

    
//    NSDictionary *sdata = [NSDictionary userName:@"l" documentCode:@"g"];
    
//    //测试并发
//    __block int receiveCount = 0;
//    
//    for (int i=0; i<555; i++) {
//        NSLog(@"send=============================================:%d",i);
//        //sleep(1);
//        [APIManager getUserInfoWithName:@"18565667965" documentCode:@"cfe20c55178723848121e11d9ff9cedc" result:^(id response) {
//            //
//            receiveCount ++;
//            NSLog(@"receive_i=============================================:%d",receiveCount);
//            NSLog(@"response:%@",response);
//            
//        }];
//
//    }
    
    // n = 1
    // i=0      17:22:53.208
    // i=999    17:23:00.423
    // lose     138
    
    // n = 2
    // i = 0    17:25:09.301
    // i=999    17:25:14.717
    // lose     86
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentLoginViewController) name:kLoginNotifyName object:nil];
}



- (void)setupChildNavigationControllerWithClass:(Class)class tabBarImageName:(NSString *)name rootViewControllerClass:(Class)rootViewControllerClass rootViewControllerTitle:(NSString *)title {
    
    UIViewController *rootVC = [[rootViewControllerClass alloc] init];
    rootVC.title = title;
    YIMNavigationController *navc = [[class alloc] initWithRootViewController:rootVC];
    navc.tabBarItem.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_n",name]];
    navc.tabBarItem.title = title;
    navc.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_s", name]];
    [self addChildViewController:navc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)presentLoginViewController{
    
    LoginTableViewController *login = [[UIStoryboard storyboardWithName:@"TabStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginTableViewController"];
    YIMNavigationController *navigation = [[YIMNavigationController alloc] initWithRootViewController:login];
    [self presentViewController:navigation animated:YES completion:^{
        //
    }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
