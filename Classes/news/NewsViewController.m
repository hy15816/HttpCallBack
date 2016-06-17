//
//  NewsViewController.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/1/7.
//  Copyright © 2016年 yim. All rights reserved.
//

#import "NewsViewController.h"
#import "YIMGridView.h"
#import "YIMGrideViewModel.h"
#import "MoreItemViewController.h"
#import "MJRefresh.h"
#import "CommunityInfo.h"
#import "WiFiViewController.h"

@interface NewsViewController ()<YIMGridViewDelegate>

@property (nonatomic, weak) YIMGridView *gridView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation NewsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    CommunityInfo *comm = [CommunityInfo info];
    NSLog(@"%@%@%@%@",comm.provinceName,comm.cityName,comm.areaName,comm.communityName);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"left" style:UIBarButtonItemStylePlain target:self action:@selector(lefAction)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"right" style:UIBarButtonItemStylePlain target:self action:@selector(rigAction)];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [self setupView];
    
    
    
}


- (void)setupView {
    YIMGridView *gridView = [[YIMGridView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    gridView.gridViewDelegate = self;
    gridView.showsVerticalScrollIndicator = NO;
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
                            ];
    
    NSMutableArray *temp = [NSMutableArray array];
    
    for (int i = 0; i < titleArray.count; i++) {
        YIMGrideViewModel *model = [[YIMGrideViewModel alloc] init];
        model.destinationClass = [UIViewController class];
        model.imageResString = @"tabbar_first_n";//[NSString stringWithFormat:@"i%02d", i];
        model.title = titleArray[i];
        [temp addObject:model];
    }
    _dataArray = [temp copy];
    gridView.gridModelsArray = [temp copy];
    gridView.scrollADImageURLStringsArray = @[@"http://ww3.sinaimg.cn/bmiddle/9d857daagw1er7lgd1bg1j20ci08cdg3.jpg",
                                              @"http://ww4.sinaimg.cn/bmiddle/763cc1a7jw1esr747i13xj20dw09g0tj.jpg",
                                              @"http://ww4.sinaimg.cn/bmiddle/67307b53jw1esr4z8pimxj20c809675d.jpg"];
    [self.view addSubview:gridView];
    _gridView = gridView;
    
//    _gridView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
//        //
//        NSLog(@".....mj_header....Refreshing....");
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [_gridView.mj_header endRefreshing];
//            });
//        });
//    }];
//    [_gridView.mj_header beginRefreshing];
    
}

- (void)yimGrideView:(YIMGridView *)grideView selectedAtIndex:(NSInteger)index {
    
    if (index == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kLoginNotifyName object:nil];
        return;
    }
    
    if (index == 1) {
        
        WiFiViewController *wifiVC = [[WiFiViewController alloc] init];
        wifiVC.view.backgroundColor = [UIColor whiteColor];
        wifiVC.title = @"wifi";
        [self.navigationController pushViewController:wifiVC animated:YES];
        return;
    }
    
    YIMGrideViewModel *model = _dataArray[index];
    UIViewController *vc = [[model.destinationClass alloc] init];
    vc.title = model.title;
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)yimGrideView:(YIMGridView *)grideViewDidClickMoreItem {
    
    MoreItemViewController *more = [[MoreItemViewController alloc] init];
    more.view.backgroundColor = [UIColor whiteColor];
    more.title = @"添加更多";
    [self.navigationController pushViewController:more animated:YES];
}


- (void)lefAction {
    
    
}
- (void)rigAction {
    
    UIViewController *contr = [[UIViewController alloc] init];
    contr.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:contr animated:YES];
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
