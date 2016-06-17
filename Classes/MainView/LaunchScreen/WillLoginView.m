//
//  WillLoginView.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/1/11.
//  Copyright © 2016年 yim. All rights reserved.
//

#import "WillLoginView.h"

@interface WillLoginView ()

@property (strong,nonatomic) void (^loginBlock)();

@end

@implementation WillLoginView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame actions:(loginButtonActionBlock)block {
    self = [super initWithFrame:frame];
    if (self) {
        //
        if (block) {
            self.loginBlock = block;
        }
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    //imageView
    UIImageView *imagv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 200)];
    imagv.image = [UIImage imageNamed:@"userinfo_vc_top"];
    
    [self addSubview:imagv];
    
    //创建button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"登录" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];
    [button addTarget:self action:@selector(WillLoginViewButtonActions) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(20, (self.frame.size.height - 35)/2, self.frame.size.width-20 * 2, 35);
    
    [self addSubview:button];
    
}

- (void)WillLoginViewButtonActions {
    
    self.loginBlock();
    
}


@end
