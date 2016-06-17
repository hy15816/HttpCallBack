//
//  YIMGrideViewListItemView.h
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/1/8.
//  Copyright © 2016年 yim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YIMGrideViewModel;

#pragma mark - YIMGrideViewButtonItem
/**
 *  这里是button，通过重写父类方法修改了button的布局
 */
@interface YIMGrideViewButtonItem : UIButton


@end


#pragma mark - YIMGrideViewListItemView

/**
 *  生成一个grideItem
 */
@interface YIMGrideViewListItemView : UIView

@property (strong,nonatomic) YIMGrideViewModel *itemModel;
@property (assign,nonatomic) BOOL hidenIcon;
@property (strong,nonatomic) UIImage *iconImage;

@property (strong,nonatomic) void (^itemLongPressedActionBlock)(UILongPressGestureRecognizer *longPress);
@property (strong,nonatomic) void (^buttonClickActionBlock)(YIMGrideViewListItemView *item);
@property (strong,nonatomic) void (^iconViewClickActionBlock)(YIMGrideViewListItemView *view);

 @end
