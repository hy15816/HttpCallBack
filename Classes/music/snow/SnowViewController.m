//
//  SnowViewController.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/3/4.
//  Copyright © 2016年 yim. All rights reserved.
//

#import "SnowViewController.h"
#import "SnowView.h"

@interface SnowViewController ()
{
    BOOL _isShow;
}
@end

@implementation SnowViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _isShow = NO;
    self.navigationController.navigationBarHidden = YES;
    [UIApplication sharedApplication].statusBarHidden = YES;
    
    SnowView *snowView = [[SnowView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:snowView];
    
}

-(BOOL)prefersStatusBarHidden {
    
    [super prefersStatusBarHidden];
    
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    _isShow = !_isShow;
    if (_isShow) {
        self.navigationController.navigationBarHidden = NO;
        [UIApplication sharedApplication].statusBarHidden = NO;
    }else {
        self.navigationController.navigationBarHidden = YES;
        [UIApplication sharedApplication].statusBarHidden = YES;
    }
    
    [super prefersStatusBarHidden];
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
