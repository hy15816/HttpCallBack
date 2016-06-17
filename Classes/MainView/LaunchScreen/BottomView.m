//
//  BottomView.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/1/11.
//  Copyright © 2016年 yim. All rights reserved.
//

#import "BottomView.h"

@interface BottomView ()

@property (strong,nonatomic) bottomViewActionBlock bottomBlock;

@end

@implementation BottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame actions:(bottomViewActionBlock)block {
    
    self = [super initWithFrame:frame];
    if (self) {
        if (block) {
            self.bottomBlock = block;
        }
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    NSArray *titles = @[@"登录",@"注册"];
    NNLog(@"self.w:%f",self.frame.size.width);
    CGFloat btnW = (self.frame.size.width - 20 * 3)/2;
    for (int i=0; i<titles.count; i++) {
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.backgroundColor = [UIColor greenColor];
        if (i==1) {
            but.backgroundColor = [UIColor redColor];
        }
        but.frame = CGRectMake(20 *(i+1) + btnW *i, 0, btnW, 35);
        [but setTitle:titles[i] forState:UIControlStateNormal];
        but.tag = i;
        [but addTarget:self action:@selector(butActions:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:but];
    }
    
}

- (void)butActions:(UIButton *)btn {
    if (btn.tag == 0) {
        self.bottomBlock(YES,NO);
    }
    if (btn.tag == 1) {
        self.bottomBlock(NO,YES);
    }
}


@end
