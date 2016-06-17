//
//  LoginViewController.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/1/11.
//  Copyright © 2016年 yim. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)loginButtonAction:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UITextField *userNameField;
@property (strong, nonatomic) IBOutlet UITextField *userPwdField;

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //显示导航栏
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginButtonAction:(UIButton *)sender {
    
    self.editing = NO;
    
    //保存用户名及登录状态
    [UserManager login:self.userNameField.text];
    
    if (self.formLaunchVC) {
        [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            //
            self.view.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        } completion:^(BOOL finished) {
            //
            NNLog(@" remove loginvc");
            
            [self removeFromParentViewController];
        }];
        
        if (self.loginSucBlock) {
            self.loginSucBlock();
        }
        return;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
@end
