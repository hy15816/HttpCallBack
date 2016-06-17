//
//  YIMPullList.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/1/20.
//  Copyright © 2016年 yim. All rights reserved.
//

#import "YIMPullList.h"

@interface YIMPullList ()<UITableViewDataSource,UITableViewDelegate>
{
    BOOL _pullState;
}
@property (strong, nonatomic) UITableView *y_tableView;
@property (strong, nonatomic) NSMutableArray *y_dataArray;
@property (assign, nonatomic) CGFloat cellHeight;
@property (strong, nonatomic) PullListSelectItemBlock pBlock;

@end

@implementation YIMPullList

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (YIMPullList *)pullLists {
    static YIMPullList *list = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        list = [[YIMPullList alloc] init];
    });
    
    return list;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //
        
        //[self setupWithArray:<#(NSArray *)#>];
    }
    return self;
}

- (void)setupWithArray:(NSArray *)array {
    
    self.cellHeight = 30.f;
    _pullState = YES; //展开
    
//    self.y_dataArray = [NSMutableArray arrayWithArray:array];
    [self.y_dataArray addObjectsFromArray:array];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self addSubview:self.y_tableView];
    });
    
    CGFloat height = _cellHeight * array.count + _cellHeight;
    [YIMPullList pullLists].frame = CGRectMake(0, 0, self.frame.size.width, height);
}

+ (instancetype)pullListWithArray:(NSArray *)dataArray selectItemBlock:(PullListSelectItemBlock)block {
    
    YIMPullList *list = [YIMPullList pullLists];
    list.pBlock = block;
    [list setupWithArray:dataArray];
    return list;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.y_dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
    }
    NSLog(@"cell----%@",self.y_dataArray[indexPath.row]);
    cell.textLabel.text = self.y_dataArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YIMPullList *list = [YIMPullList pullLists];
    if (list.pBlock) {
        
        list.pBlock(indexPath,self.y_dataArray[indexPath.row]);
    }
    NSLog(@"didSelectRowAtIndexPath............data:%@",self.y_dataArray[indexPath.row]);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self retractList];
}
/**
 *  收起下拉框
 */
- (void)retractList {
    
    [UIView animateWithDuration:.25 animations:^{
        //
        if (_pullState) {
            self.alpha = 0;
        }
    }];
}
/**
 *  展开
 */
- (void)spreadList {
    
    [UIView animateWithDuration:.25 animations:^{
        //
        if (_pullState) {
            self.alpha = 1.f;
        }
    }];
    
}

#pragma mark - set & get
- (void)setDataSourceArray:(NSMutableArray *)dataSourceArray {
    _y_dataArray = dataSourceArray;
    [self.y_tableView reloadData];
}

-(NSMutableArray *)y_dataArray {
    
    if (_y_tableView == nil) {
        _y_dataArray = [[NSMutableArray alloc] init];
        [_y_dataArray addObject:@"请选择"];
    }
    return _y_dataArray;
}

-(UITableView *)y_tableView {
    
    if (_y_tableView == nil) {
        _y_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        _y_tableView.delegate = self;
        _y_tableView.dataSource = self;
        _y_tableView.backgroundColor = [UIColor clearColor];
    }
    
    return _y_tableView;
}

@end
