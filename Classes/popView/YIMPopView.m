//
//  YIMPopView.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/1/23.
//  Copyright © 2016年 yim. All rights reserved.
//

#import "YIMPopView.h"
#import "UIImageView+ShowIndicators.h"

@interface YIMPopView ()<UITableViewDelegate,UITableViewDataSource>
/**
 *  遮罩层
 */
@property (strong, nonatomic) UIView *shadowBackgroundView;

/**
 *  显示数据图层
 */
@property (strong, nonatomic) UITableView *showDataTableView;
/**
 *  tableView 的位置
 */
@property (assign, nonatomic) CGRect tableViewRect;
@end

@implementation YIMPopView

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSMutableArray *)dataSourceArray {
    
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        //
        self.dataSourceArray = dataSourceArray;
        self.tableViewRect = frame;
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.shadowBackgroundView];
    self.showDataTableView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, self.tableViewRect.origin.y, 0, 0);
    [self addSubview:self.showDataTableView];
    
    [UIView animateWithDuration:.25f animations:^{
        
        self.showDataTableView.frame = self.tableViewRect;
        
    } completion:^(BOOL finished) {
    }];
    
    //短暂的显示滚动条（提示效果）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.showDataTableView flashScrollIndicators];
    });
    
    /*
     *  2.一直显示
     *  2.1 创建一个UIImageView category，重写setAlpha: 方法
     *  2.2 设置 self.showDataTableVie.tag = 936913
     *  2.3 [self.showDataTableView flashScrollIndicators];
     */

    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellid = @"cellids";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    cell.textLabel.text = self.dataSourceArray[indexPath.row];
    return cell;

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 35;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(popView:didSelectAtIndexPath:)]) {
        [self.delegate popView:self didSelectAtIndexPath:indexPath];
    }
    [self tapCancel];
}

- (void)tapCancel {
    
    [UIView animateWithDuration:.25 animations:^{
        
        self.showDataTableView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, self.tableViewRect.origin.y, 0, 0);

        //self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

- (void)showPopInView:(UIView *)view{
    
    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
    
}

- (void)setDataSourceArray:(NSMutableArray *)dataSourceArray {
    
    _dataSourceArray = dataSourceArray;
    
    [self.showDataTableView reloadData];
}

- (UIView *)shadowBackgroundView {
    
    if (_shadowBackgroundView == nil) {
        _shadowBackgroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _shadowBackgroundView.backgroundColor = [UIColor grayColor];
        _shadowBackgroundView.alpha = .1f;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCancel)];
        tapGesture.numberOfTapsRequired = 1;
        [_shadowBackgroundView addGestureRecognizer:tapGesture];
    }
    
    return _shadowBackgroundView;
}

- (UITableView *)showDataTableView {
    
    if (_showDataTableView == nil) {
        _showDataTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _showDataTableView.delegate = self;
        _showDataTableView.dataSource = self;
        _showDataTableView.layer.borderWidth = .5f;
        _showDataTableView.layer.cornerRadius = 3.f;
        self.showDataTableView.tag = noDisableVerticalScrollTag;
    }
    
    return _showDataTableView;
}


@end
