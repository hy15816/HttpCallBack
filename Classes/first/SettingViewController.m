//
//  SettingViewController.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/3/10.
//  Copyright © 2016年 yim. All rights reserved.
//

#import "SettingViewController.h"
#import "ConsultationsViewController.h"
#import "AvatarBrowser.h"

@interface SettingViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *userImageView;
- (IBAction)tapUserImageView:(UITapGestureRecognizer *)sender;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addRightItemWithTitle:@"OK"];
}

-(void)rightBarButtonItemClick:(UIBarButtonItem *)item {
    
    NSLog(@"......ok");
    
    ConsultationsViewController *cons = [[ConsultationsViewController alloc] init];
    [self.navigationController pushViewController:cons animated:YES];
    
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

- (IBAction)tapUserImageView:(UITapGestureRecognizer *)sender {
    
    [AvatarBrowser showImage:self.userImageView];
}
@end
