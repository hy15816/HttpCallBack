//
//  FirstViewController.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/3/8.
//  Copyright © 2016年 yim. All rights reserved.
//

#define kCOLORRANDOM [UIColor colorWithRed:(arc4random() % 255)/255.f green:(arc4random() % 255)/255.f blue:(arc4random() % 255)/255.f alpha:1];


#import "FirstViewController.h"

@interface FirstViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) UISegmentedControl *segmentedControl;
@property (strong,nonatomic) NSArray *itemsArray;

@property (strong,nonatomic) UITableView *table_view;
@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) NSMutableArray *tableViewDataList;

@end

@implementation FirstViewController

#pragma mark - view life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.segmentedControl];
    [self.view addSubview:self.scrollView];
//    [self.scrollView addSubview:self.table_view];
    
    [self addRightItemWithTitle:@"设置"];
}

- (void)rightBarButtonItemClick:(UIBarButtonItem *)item {
    
    UIViewController *setting = kStoryboardFirst(@"SettingViewController");//[[UIStoryboard storyboardWithName:@"FirstStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:];
    [self.navigationController pushViewController:setting animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tableViewDataList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid"];
    }
    cell.textLabel.text = self.tableViewDataList[indexPath.row];
    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == _scrollView) {
        _scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
        
        
        NSInteger index = scrollView.contentOffset.x / DEVICE_WIDTH;
        self.segmentedControl.selectedSegmentIndex = index;
    }
    
    
}

#pragma mark - UISegmentedControl Actions
- (void)segmentedControlAction:(UISegmentedControl *)segment {
    
    NSLog(@"segment.selectedSegmentIndex:%ld",(long)segment.selectedSegmentIndex);
    [_scrollView setContentOffset:CGPointMake(segment.selectedSegmentIndex * DEVICE_WIDTH, 0) animated:YES] ;
    
}



#pragma mark - getter & setter
- (UISegmentedControl *)segmentedControl {
    
    if (_segmentedControl == nil) {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:self.itemsArray];
        _segmentedControl.frame = CGRectMake(0, 64, DEVICE_WIDTH, 36);
        _segmentedControl.selectedSegmentIndex = 0;
        _segmentedControl.backgroundColor = [UIColor whiteColor];
        _segmentedControl.tintColor = [UIColor greenColor];
        [_segmentedControl addTarget:self action:@selector(segmentedControlAction:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _segmentedControl;
}

-(NSArray *)itemsArray {
    
    return @[@"123",@"456",@"789",@"1122"];//,@"3344",@"5566",@"8899"];
}

- (UITableView *)table_view {
  
    if (_table_view == nil) {
        
        _table_view = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, _scrollView.frame.size.height ) style:UITableViewStylePlain];
        _table_view.dataSource = self;
        _table_view.delegate = self;
        
    }
    
    return _table_view;
}

- (NSMutableArray *)tableViewDataList {
    
    if (_tableViewDataList == nil) {
        _tableViewDataList = [[NSMutableArray alloc] init];
        for (int i=0; i<30; i++) {
            [_tableViewDataList addObject:[NSString stringWithFormat:@"item--------- %d",i]];
        }
    }
    
    return _tableViewDataList;
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, DEVICE_WIDTH, DEVICE_HEIGHT-100 - 49)];
        _scrollView.contentSize = CGSizeMake(DEVICE_WIDTH * 4, DEVICE_HEIGHT- 100 - 49);
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        
        for (int i=0; i < 4; i++) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(DEVICE_WIDTH *i, 0, DEVICE_WIDTH, _scrollView.frame.size.height)];
            view.backgroundColor = kCOLORRANDOM;
            if (i == 1) {
                [view addSubview:self.table_view];
            }
            [_scrollView addSubview:view];
        }
        
    }
    
    return _scrollView;
}

#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
