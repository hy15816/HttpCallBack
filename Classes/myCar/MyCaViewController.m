//
//  MyCaViewController.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/3/2.
//  Copyright © 2016年 yim. All rights reserved.
//

#import "MyCaViewController.h"
#import "ChooseCarViewController.h"
#import "NSString+TextHeight.h"

@interface MyCaViewController ()

{
    UILabel *_label;
    
}

@property (strong, nonatomic) IBOutlet UILabel *currentChooseLabel;
- (IBAction)chooseButtonAction:(UIButton *)sender;

@end

@implementation MyCaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, DEVICE_WIDTH, 30)];
    _label.numberOfLines = 0;
    _label.text = @"当前选择：";
    
    [self.view addSubview:_label];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(chooseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(10, 200, DEVICE_WIDTH-20, 35);
    [btn setTitle:@"选择车型" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor greenColor];
    
    [self.view addSubview:btn];
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

- (IBAction)chooseButtonAction:(UIButton *)sender {
    
    ChooseCarViewController *choose = [[ChooseCarViewController alloc] init];
    choose.chooseCallBack = ^(NSDictionary *brand,NSDictionary *model,NSDictionary *detail){
        NSLog(@"choose:%@\n%@\n%@",brand,model,detail);
        
        _label.text = [NSString stringWithFormat:@"当前选择: %@ - %@\n - %@",brand[@"brandname"],model[@"modelname"],detail[@"detailname"]];
        CGFloat labelH = [_label.text heightWithText:_label.text font:[UIFont systemFontOfSize:14] width:DEVICE_WIDTH *.5];
        NSLog(@"labelH:%f",labelH);
        _label.frame = CGRectMake(0, _label.frame.origin.y, DEVICE_WIDTH, labelH);
    };
    
    [self.navigationController pushViewController:choose animated:YES];
}
@end
