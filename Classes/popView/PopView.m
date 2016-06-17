//
//  PopView.m
//  SideMenu
//
//  Created by AEF-RD-1 on 15/10/10.
//  Copyright (c) 2015年 hyIm. All rights reserved.
//

#import "PopView.h"

@interface PopView ()

@property (strong,nonatomic) UIView *backgroundView;
@property (strong,nonatomic) UIFont *titleTextLabelFont;
@property (strong,nonatomic) NSArray *dataArray;
@end

@implementation PopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //
        self.titleTextLabelFont = [UIFont systemFontOfSize:14];
        self.dataArray = [[NSArray alloc] init];
    }
    return self;
}

-(void)setTextFont:(UIFont *)textFont{
    
    self.titleTextLabelFont = textFont;
    [self layoutIfNeeded];
}
- (PopView *)initWithViewItems:(NSArray *)views frame:(CGRect)frame {
    
    self = [[PopView alloc] initWithFrame:frame];
    
//    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.1];
//    self.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
//    [self addGestureRecognizer:tapGesture];
    if (self) {
        self.dataArray = views;
        
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        [self setup:frame];
    }
    

    return self;
}

- (void)setup:(CGRect)frame{
    
    for (int i=0; i<self.dataArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, frame.size.height/self.dataArray.count *i+5, frame.size.width, frame.size.height/self.dataArray.count-5);
        button.backgroundColor = [UIColor clearColor];
        button.titleLabel.font = self.titleTextLabelFont;
        [button setTitle:[self.dataArray objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //[button setShowsTouchWhenHighlighted:YES];
        button.tag = i;
        [button addTarget:self action:@selector(popViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        //lebel 线条
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(button.frame), frame.size.width-10, .5)];
        lab.backgroundColor = [UIColor groupTableViewBackgroundColor];
        if (i == self.dataArray.count-1) {//最后一行不要了
            lab.alpha = 0;
        }
        [self addSubview:lab];
        [self addSubview:button];
        
    }
}

- (void)showPopInView:(UIView *)view{
    
    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];

}

- (void)setDataSourceArray:(NSMutableArray *)dataSourceArray {
    
    self.dataArray = dataSourceArray;
    [self setup:self.frame];
}
- (void)tappedCancel{
    
}

-(void)popViewButtonClick:(UIButton *)btn{
    
    if ([self.delegate respondsToSelector:@selector(popViewItemClick:)]) {
        [self.delegate popViewItemClick:btn];
    }
    //[self removeFromSuperview];
}

@end
