//
//  LaunchViewController.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/1/6.
//  Copyright © 2016年 yim. All rights reserved.
//

#import "LaunchViewController.h"
#import <ImageIO/ImageIO.h>
#import "YIMPlayGifView.h"
#import "LoginViewController.h"
#import "BottomView.h"

UIKIT_EXTERN NSString *const kIsLogin;
UIKIT_EXTERN NSString *const kResetWoindowRootViewControllerNotify;

@interface LaunchViewController ()


@property (strong, nonatomic) BottomView *bottomView;

@end

@implementation LaunchViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //隐藏导航栏
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    /*
    if ([UserManager hasLogin]) {
        //自动登录
        [SVProgressHUD showWithStatus:@"正在登录..." maskType:SVProgressHUDMaskTypeClear];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [self dismissLaunchView];
        });
    }else {
     */
        //显示按钮
        [UIView animateWithDuration:.3 animations:^{
            self.bottomView.frame = CGRectMake(0,self.view.frame.size.height - self.bottomView.frame.size.height, self.bottomView.frame.size.width, self.bottomView.frame.size.height);
        }];
//    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self prefersStatusBarHidden];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    //播放gif图片
    NSString *imagePath =[[NSBundle mainBundle] pathForResource:@"2199069246da47b56054e06397a75a74" ofType:@"gif"];
    YIMPlayGifView *gifView = [[YIMPlayGifView alloc] initWithFrame:self.view.frame filePath:imagePath];
    [self.view addSubview:gifView];
    
    //创建一个灰色的蒙版，提升效果（可选）
    UIView *filter = [[UIView alloc] initWithFrame:self.view.bounds];
    filter.backgroundColor = [UIColor groupTableViewBackgroundColor];
    filter.alpha = 0.1f;
    //[self.view addSubview:filter];
    
    [self.view addSubview:self.bottomView];
    //修改登录按钮和注册按钮的显示层级
    [self.view bringSubviewToFront:self.bottomView];
    
    
}

- (BOOL)prefersStatusBarHidden {
    [super prefersStatusBarHidden];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self dismissLaunchView];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)regButtonAction  {
}

- (void)loginButtonAction  {
    
    //[[NSUserDefaults standardUserDefaults] setBool:YES forKey:isLogin];
    //[self dismissViewControllerAnimated:YES completion:nil];
    LoginViewController *loginView = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    loginView.formLaunchVC = YES;
    loginView.loginSucBlock = ^(){
        [self dismissLaunchView];
    };
    [self.navigationController pushViewController:loginView animated:YES];
    
}


- (void)dismissLaunchView {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //
        [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            //
            self.view.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        } completion:^(BOOL finished) {
            //
            NNLog(@" remove launch");
            [[NSNotificationCenter defaultCenter] postNotificationName:kResetWoindowRootViewControllerNotify object:nil];
            [self removeFromParentViewController];
        }];
    });
    
}


- (BottomView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [[BottomView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 100) actions:^(BOOL login, BOOL reg) {
            //
            if (login) {
                //
                [self loginButtonAction];
            }
            if (reg) {
                [self regButtonAction];
            }
            
        }];
        
    }
    
    return _bottomView;
}


@end
