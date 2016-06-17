//
//  YIMPopView.h
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/1/23.
//  Copyright © 2016年 yim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YIMPopView;
@protocol YIMPopViewDelegate <NSObject>

- (void)popView:(YIMPopView *)popView didSelectAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface YIMPopView : UIView

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSMutableArray *)dataSourceArray;
- (void)showPopInView:(UIView *)view;

@property (strong,nonatomic) NSMutableArray *dataSourceArray;
@property (assign,nonatomic) id<YIMPopViewDelegate> delegate;

@end
