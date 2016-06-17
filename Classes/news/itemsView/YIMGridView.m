//
//  YIMGridView.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/1/8.
//  Copyright © 2016年 yim. All rights reserved.
//

#import "YIMGridView.h"
#import "YIMGrideViewModel.h"
#import "YIMGrideViewListItemView.h"
#import "SDCycleScrollView.h"
#import "UIView+Extension.h"

#define kHomeGridViewPerRowItemCount 4
#define kHomeGridViewTopSectionRowCount 3

@implementation YIMGridView

{
    NSMutableArray *_itemsArray;
    NSMutableArray *_rowSeparatorsArray;
    NSMutableArray *_columnSeparatorsArray;
    BOOL _hasAdjustedSeparators;
    CGPoint _lastPoint;
    UIButton *_placeholderButton;

    YIMGrideViewListItemView *_currentPressedView;
    SDCycleScrollView *_cycleScrollADView;
    UIView *_cycleScrollADViewBackgroundView;
    UIButton *_moreItemButton;
    CGRect _currentPresssViewFrame;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        _itemsArray = [[NSMutableArray alloc] init];
        _rowSeparatorsArray = [[NSMutableArray alloc] init];
        _columnSeparatorsArray = [[NSMutableArray alloc] init];
        _hasAdjustedSeparators = NO;
        _placeholderButton = [[UIButton alloc] init];
        
        //scroller loop view (底图)
        UIView *advView = [[UIView alloc] init];
        advView.backgroundColor = [UIColor colorWithRed:(235 / 255.0) green:(235 / 255.0) blue:(235 / 255.0) alpha:1];
        [self addSubview:advView];
        _cycleScrollADViewBackgroundView = advView;
        
        SDCycleScrollView *cycleView = [[SDCycleScrollView alloc] init];
        cycleView.autoScrollTimeInterval = 2.0;
        [self addSubview:cycleView];
        _cycleScrollADView = cycleView;
        
        [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(deviceOrientationDidChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];

        
    }
    
    return self;
}

- (void)deviceOrientationDidChanged:(NSNotification *)notify {
    [self layoutSubviews];
}

- (void)setGridModelsArray:(NSArray *)gridModelsArray
{
    _gridModelsArray = gridModelsArray;
    
    [_itemsArray removeAllObjects];
    [_rowSeparatorsArray removeAllObjects];
    [_columnSeparatorsArray removeAllObjects];
    
    [gridModelsArray enumerateObjectsUsingBlock:^(YIMGrideViewModel *model, NSUInteger idx, BOOL *stop) {
        YIMGrideViewListItemView *item = [[YIMGrideViewListItemView alloc] init];
        item.itemModel = model;
        __weak typeof(self) weakSelf = self;
        item.itemLongPressedActionBlock = ^(UILongPressGestureRecognizer *longPressed){
            [weakSelf buttonLongPressed:longPressed];
        };
        item.iconViewClickActionBlock = ^(YIMGrideViewListItemView *view){
            [weakSelf deleteView:view];
        };
        item.buttonClickActionBlock = ^(YIMGrideViewListItemView *view){
            if (!_currentPressedView.hidenIcon && _currentPressedView) {
                _currentPressedView.hidenIcon = YES;
                return;
            }
            if ([self.gridViewDelegate respondsToSelector:@selector(yimGrideView:selectedAtIndex:)]) {
                [self.gridViewDelegate yimGrideView:self selectedAtIndex:[_itemsArray indexOfObject:view]];
            }
        };
        
        [self addSubview:item];
        [_itemsArray addObject:item];
    }];
    
    UIButton *more = [[UIButton alloc] init];
    [more setImage:[UIImage imageNamed:@"tf_home_more"] forState:UIControlStateNormal];
    [more addTarget:self action:@selector(moreItemButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:more];
    [_itemsArray addObject:more];
    _moreItemButton = more;
    
    long rowCount = [self rowCountWithItemsCount:gridModelsArray.count];
    
    
    for (int i = 0; i < (rowCount + 1); i++) {
        UIView *rowSeparator = [[UIView alloc] init];
        rowSeparator.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:rowSeparator];
        [_rowSeparatorsArray addObject:rowSeparator];
    }
    
    for (int i = 0; i < (kHomeGridViewPerRowItemCount + 1); i++) {
        UIView *columnSeparator = [[UIView alloc] init];
        columnSeparator.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:columnSeparator];
        [_columnSeparatorsArray addObject:columnSeparator];
    }
    
    [self bringSubviewToFront:_cycleScrollADView];
}

- (void)setShowADVLoopView:(BOOL)showADVLoopView {
    _showADVLoopView = showADVLoopView;
    if (!showADVLoopView) {
        //隐藏广告图片,更新页面布局
        
    }
}

- (void)moreItemButtonClicked
{
    if ([self.gridViewDelegate respondsToSelector:@selector(yimGrideView:)]) {
        [self.gridViewDelegate yimGrideView:self];
    }
}

- (void)setScrollADImageURLStringsArray:(NSArray *)scrollADImageURLStringsArray
{
    _scrollADImageURLStringsArray = scrollADImageURLStringsArray;
    
    _cycleScrollADView.imageURLStringsGroup = scrollADImageURLStringsArray;
}

- (NSInteger)rowCountWithItemsCount:(NSInteger)count
{
    long rowCount = (count + kHomeGridViewPerRowItemCount - 1) / kHomeGridViewPerRowItemCount;
    rowCount = (rowCount < 4) ? 4 : ++rowCount;
    return rowCount;
}

- (void)buttonLongPressed:(UILongPressGestureRecognizer *)longPressed
{
    YIMGrideViewListItemView *pressedView = (YIMGrideViewListItemView *)longPressed.view;
    CGPoint point = [longPressed locationInView:self];
    //    CGPoint superViewPoint = [longPressed locationInView:self.superview];
    //    if (point.y >= self.sd_height - 20) {
    //        [self setContentOffset:CGPointMake(0, self.contentSize.height - self.sd_height) animated:YES];
    //    } else if (self.contentOffset.y == self.contentSize.height - self.sd_height) {
    //        [self scrollsToTop];
    //    }
    
    
    
    
    if (longPressed.state == UIGestureRecognizerStateBegan) {
        _currentPressedView.hidenIcon = YES;
        _currentPressedView = pressedView;
        _currentPresssViewFrame = pressedView.frame;
        longPressed.view.transform = CGAffineTransformMakeScale(1.1, 1.1);
        pressedView.hidenIcon = NO;
        long index = [_itemsArray indexOfObject:longPressed.view];
        [_itemsArray  removeObject:longPressed.view];
        [_itemsArray  insertObject:_placeholderButton atIndex:index];
        _lastPoint = point;
        [self bringSubviewToFront:longPressed.view];
    }
    /*
     if (_isMoving) return;
     
     if ((point.y - _lastPoint.y) > 0 && point.y >= self.sd_height - 20 && self.contentOffset.y != self.contentSize.height - self.sd_height) {
     _isMoving = YES;
     NSLog(@">>>>>>>>>>> %@", NSStringFromCGPoint(point));
     //        [UIView animateWithDuration:.4 animations:^{
     //            self.contentOffset = CGPointMake(0, self.contentSize.height - self.sd_height);
     //        }];
     value = self.contentSize.height - self.sd_height;
     NSTimer *timer = [NSTimer timerWithTimeInterval:0.02 target:self selector:@selector(moveToValue) userInfo:nil repeats:YES];
     [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
     _timer = timer;
     } else if ((point.y - _lastPoint.y) < 0 && point.y <= self.contentSize.height - self.sd_height + 20) {
     _isMoving = YES;
     NSLog(@">>>>>>>>>>>****** %@", NSStringFromCGPoint(point));
     [UIView animateWithDuration:.4 animations:^{
     self.contentOffset = CGPointMake(0, 0);
     }];
     }
     
     */
    
    CGRect temp = longPressed.view.frame;
    temp.origin.x += point.x - _lastPoint.x;
    temp.origin.y += point.y - _lastPoint.y;
    longPressed.view.frame = temp;
    
    _lastPoint = point;
    
    
    [_itemsArray enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        if (button == _moreItemButton) return;
        if (CGRectContainsPoint(button.frame, point) && button != longPressed.view) {
            [_itemsArray removeObject:_placeholderButton];
            [_itemsArray insertObject:_placeholderButton atIndex:idx];
            *stop = YES;
            
            
            [UIView animateWithDuration:0.5 animations:^{
                [self setupSubViewsFrame];
            }];
        }
        
    }];
    
    
    if (longPressed.state == UIGestureRecognizerStateEnded) {
        long index = [_itemsArray indexOfObject:_placeholderButton];
        [_itemsArray removeObject:_placeholderButton];
        [_itemsArray insertObject:longPressed.view atIndex:index];
        
        [self sendSubviewToBack:longPressed.view];
        
        [UIView animateWithDuration:0.4 animations:^{
            longPressed.view.transform = CGAffineTransformIdentity;
            [self setupSubViewsFrame];
        } completion:^(BOOL finished) {
            if (!CGRectEqualToRect(_currentPresssViewFrame, _currentPressedView.frame)) {
                _currentPressedView.hidenIcon = YES;
            }
        }];
    }
    
}


- (void)setupSubViewsFrame
{
    CGFloat itemW = self.sd_width / kHomeGridViewPerRowItemCount;
    CGFloat itemH = itemW * 1.1;
    [_itemsArray enumerateObjectsUsingBlock:^(UIView *item, NSUInteger idx, BOOL *stop) {
        long rowIndex = idx / kHomeGridViewPerRowItemCount;
        long columnIndex = idx % kHomeGridViewPerRowItemCount;
        
        CGFloat x = itemW * columnIndex;
        CGFloat y = 0;
        if (idx < kHomeGridViewPerRowItemCount * kHomeGridViewTopSectionRowCount) {
            y = itemH * rowIndex;
        } else {
            y = itemH * (rowIndex + 1);
        }
        item.frame = CGRectMake(x, y, itemW, itemH);
        if (idx == (_itemsArray.count - 1)) {
            self.contentSize = CGSizeMake(0, item.sd_height + item.sd_y);
        }
    }];
}

- (void)deleteView:(YIMGrideViewListItemView *)view
{
    [_itemsArray removeObject:view];
    [view removeFromSuperview];
    [UIView animateWithDuration:0.4 animations:^{
        [self setupSubViewsFrame];
    }];
}

#pragma mark - life circles

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat itemW = self.sd_width / kHomeGridViewPerRowItemCount;
    CGFloat itemH = itemW * 1.1;
    
    
    
    if (YES) {
        [self setupSubViewsFrame];
        [_rowSeparatorsArray enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
            CGFloat w = self.sd_width;
            CGFloat h = 0.4;
            CGFloat x = 0;
            CGFloat y = idx * itemH;
            view.frame = CGRectMake(x, y, w, h);
        }];
        
        [_columnSeparatorsArray enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
            CGFloat w = 0.4;
            CGFloat h = MAX(self.contentSize.height, self.sd_height);
            CGFloat x = idx * itemW;
            CGFloat y = 0;
            view.frame = CGRectMake(x, y, w, h);
        }];
        _hasAdjustedSeparators = YES;
    }
    
    _cycleScrollADViewBackgroundView.frame = CGRectMake(0, itemH * kHomeGridViewTopSectionRowCount, self.sd_width, itemH);
    _cycleScrollADView.frame = CGRectMake(0, _cycleScrollADViewBackgroundView.sd_y , self.sd_width, itemH);
}

#pragma mark - scroll view delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _currentPressedView.hidenIcon = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
