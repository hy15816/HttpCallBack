//
//  YIMGridView.h
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/1/8.
//  Copyright © 2016年 yim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YIMGridView;
@protocol YIMGridViewDelegate <NSObject>

- (void)yimGrideView:(YIMGridView *)grideView selectedAtIndex:(NSInteger )index;

- (void)yimGrideView:(YIMGridView *)grideViewDidClickMoreItem;

@end

@interface YIMGridView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic, assign) id<YIMGridViewDelegate> gridViewDelegate;
/**
 *  是否显示adv 控件及图片， df = YES
 */
@property (nonatomic, assign) BOOL showADVLoopView;

/**
 *
 */
@property (nonatomic, strong) NSArray *gridModelsArray;

/**
 *  adv的图片URL
 */
@property (nonatomic, strong) NSArray *scrollADImageURLStringsArray;

@end
