//
//  SnowView.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/3/4.
//  Copyright © 2016年 yim. All rights reserved.
//

#import "SnowView.h"

@interface SnowView ()

@property (strong,nonatomic) UIImageView *bgImageView;
@end

@implementation SnowView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        //
        [self createBG];
        [self createLabel];
        [self createSnow];
    }
    
    return self;
}

- (void)createBG {
    
    _bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _bgImageView.image = [UIImage imageNamed:@"snowbg3"];
    [self addSubview:_bgImageView];
    
}

- (void)createLabel {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, self.frame.size.width, 100)];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:24];
    label.text = nil;//@"这里展示一个粒子效果模仿下雨或下雪的效果！";
    
    [self addSubview:label];
}

- (void)createSnow {
    
    CAEmitterLayer *snowEmitterLayer = [CAEmitterLayer layer];
    snowEmitterLayer.emitterPosition = CGPointMake(self.bounds.size.width *.5, -20);    //粒子发射位置
    //发射源的尺寸大小
    snowEmitterLayer.emitterSize = CGSizeMake(self.bounds.size.width * 1.5, 0);
    //发射模式
    snowEmitterLayer.emitterMode = kCAEmitterLayerSurface;
    //发射源的形状
    snowEmitterLayer.emitterShape = kCAEmitterLayerLine;
    
    //创建雪花类型的粒子
    CAEmitterCell *snowflake = [CAEmitterCell emitterCell];
    //粒子的名字
    snowflake.name = @"snow";
    //粒子产生的速度
    snowflake.birthRate = 10.0;
    snowflake.lifetime = 60.0;
    //粒子速度
    snowflake.velocity =3.0;
    //粒子的速度范围
    snowflake.velocityRange = 10;
    //粒子y方向的加速度分量
    snowflake.yAcceleration = 2;
    //周围发射角度
    snowflake.emissionRange = 0.5 * M_PI;
    //子旋转角度范围
    snowflake.spinRange = 0.25 * M_PI;
    snowflake.contents = (id)[[UIImage imageNamed:@"emitterBG"] CGImage];
    //设置雪花形状的粒子的颜色
    snowflake.color = [[UIColor colorWithRed:0.600 green:0.658 blue:0.743 alpha:1.000] CGColor];
    
    snowEmitterLayer.shadowOpacity = 1.0;
    snowEmitterLayer.shadowRadius = 0.0;
    snowEmitterLayer.shadowOffset = CGSizeMake(0.0, 1.0);
    //粒子边缘的颜色
    snowEmitterLayer.shadowColor = [[UIColor whiteColor] CGColor];
    
    snowEmitterLayer.emitterCells = [NSArray arrayWithObjects:snowflake,nil];
    [self.layer addSublayer:snowEmitterLayer];
    
}


- (void)setSnowBackgroundImage:(UIImage *)snowBackgroundImage {
    
    _snowBackgroundImage = snowBackgroundImage;
    _bgImageView.image = snowBackgroundImage;
    
}

@end
