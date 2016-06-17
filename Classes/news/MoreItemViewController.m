//
//  MoreItemViewController.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/1/8.
//  Copyright © 2016年 yim. All rights reserved.
//

#import "MoreItemViewController.h"
#import "YIMGrideViewModel.h"
#import "YIMGridView.h"

@interface MoreItemViewController ()

@property (nonatomic, weak) YIMGridView *mainView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MoreItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupMainView];
}

- (void)setupMainView
{
    YIMGridView *mainView = [[YIMGridView alloc] initWithFrame:self.view.bounds];
    mainView.showsVerticalScrollIndicator = NO;
    
    NSArray *titleArray = @[@"淘宝",
                            @"生活缴费",
                            @"教育缴费",
                            @"红包",
                            @"物流",
                            @"信用卡",
                            @"转账",
                            @"爱心捐款",
                            @"彩票",
                            @"当面付",
                            @"余额宝",
                            @"AA付款",
                            @"国际汇款",
                            @"淘点点",
                            @"淘宝电影",
                            @"亲密付",
                            @"股市行情",
                            @"汇率换算",
                            ];
    
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0; i < 18; i++) {
        YIMGrideViewModel *model = [[YIMGrideViewModel alloc] init];
        model.destinationClass = [UIViewController class];
        model.imageResString = @"tabbar_first_n";//[NSString stringWithFormat:@"i%02d", i];
        model.title = titleArray[i];
        [temp addObject:model];
    }
    
    _dataArray = [temp copy];
    mainView.gridModelsArray = [temp copy];
    
    [self.view addSubview:mainView];
    _mainView = mainView;
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

@end
