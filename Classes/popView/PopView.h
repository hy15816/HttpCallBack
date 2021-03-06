//
//  PopView.h
//  SideMenu
//
//  Created by AEF-RD-1 on 15/10/10.
//  Copyright (c) 2015年 hyIm. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopViewDelegate <NSObject>
@optional
/**
 *  pop view items click action
 *
 *  @param btn item
 */
-(void)popViewItemClick:(UIButton *)btn;

@end

@interface PopView : UIView

/**
 *  标题的font
 */
@property (strong,nonatomic) UIFont *textFont;

@property (strong,nonatomic) NSArray *dataSourceArray;

@property (weak,nonatomic) id<PopViewDelegate> delegate;

/**
 *  创建一个popview
 *
 *  @param views    sub views is a Array
 *  @param frame    frame
 *
 *  @return PopView
 */
- (PopView *)initWithViewItems:(NSArray *)views frame:(CGRect)frame ;

/**
 *  显示在哪个view上
 *
 *  @param view view
 */
- (void)showPopInView:(UIView *)view;

@end
