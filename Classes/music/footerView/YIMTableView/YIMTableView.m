//
//  YIMTableView.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/1/22.
//  Copyright © 2016年 yim. All rights reserved.
//

#import "YIMTableView.h"

@interface YIMTableView ()<UITableViewDataSource,UITableViewDelegate>
{
    NSIndexPath *_currentIndexPath;
    
}
@property (strong,nonatomic) UITableView *cTableView;
@property (strong,nonatomic) NSMutableArray *mutArray;
@property (strong,nonatomic) NSMutableArray *selectedArray;
@end

@implementation YIMTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        //
//        [self setupUI:<#(YIMTableView *)#> withArray:<#(NSMutableArray *)#>];
    }
    
    return self;
}

+ (instancetype)tableViewWithFrame:(CGRect)frame dataArray:(NSMutableArray *)dataArray {
    
    YIMTableView *yimView = [[YIMTableView alloc] initWithFrame:frame];
    [yimView setupUI:yimView withArray:dataArray];
    
    return yimView;
}


- (void)setupUI:(YIMTableView *)view withArray:(NSMutableArray *)array {
    
    [view addSubview:self.cTableView];
    
    if (array) {
        
        [self setDataSourceArray:array];
        
    }
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return 1;}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {return self.mutArray.count;}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellid = @"cellids";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
//        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
    }
    NSString *imageName = @"icon_checkbox_serv_false";
    if (_currentIndexPath == indexPath) {
        imageName = @"icon_checkbox_serv_true";
    }
    cell.imageView.image = [UIImage imageNamed:imageName];
    cell.textLabel.text = self.mutArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_currentIndexPath == indexPath) {
        return;
    }
    NSIndexPath *oldIndexPath = _currentIndexPath;
    UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
    newCell.imageView.image = [UIImage imageNamed:@"icon_checkbox_serv_true"];
    
    UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:oldIndexPath];
    oldCell.imageView.image = [UIImage imageNamed:@"icon_checkbox_serv_false"];
    
    if ([self.delegate respondsToSelector:@selector(yimTableView:didSelectRowAtIndexPath:)]) {
        [self.delegate yimTableView:self didSelectRowAtIndexPath:indexPath];
    }
    _currentIndexPath = indexPath;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (void)setDataSourceArray:(NSMutableArray *)dataSourceArray {
    
    _dataSourceArray = dataSourceArray;
    [self.mutArray addObjectsFromArray:dataSourceArray];
    [self.cTableView reloadData];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.mutArray.count * 44);
//    [self.cTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
}

- (UITableView *)cTableView {
    
    if (_cTableView == nil) {
        _cTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        _cTableView.delegate = self;
        _cTableView.dataSource = self;
        _cTableView.tableFooterView = [[UIView alloc] init];
        _currentIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    }
    
    return _cTableView;
}

-(NSMutableArray *)mutArray {
    
    if (_mutArray == nil) {
        _mutArray = [[NSMutableArray alloc] init];
    }
    
    return _mutArray;
}

-(NSMutableArray *)selectedArray {
    
    if (_selectedArray == nil) {
        _selectedArray = [[NSMutableArray alloc] init];
    }
    
    return _selectedArray;
}

@end
