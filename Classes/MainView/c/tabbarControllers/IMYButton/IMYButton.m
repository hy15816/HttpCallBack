//
//  IMYButton.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/2/28.
//  Copyright © 2016年 yim. All rights reserved.
//

#import "IMYButton.h"

@implementation IMYButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype)buttonWithType:(UIButtonType)buttonType {
    
    IMYButton *button = [super buttonWithType:buttonType];
    if (button) {
        //
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return button;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
        
    CGFloat titleY = contentRect.size.height *0.8;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    
    return CGRectMake(0, titleY, titleW, titleH);
}

//设置图片位置
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    CGFloat imageH = contentRect.size.height * 0.8;
    CGFloat imageW = imageH;
    CGFloat imageX = (contentRect.size.width - imageW)/2;
    CGFloat imageY = contentRect.size.height *0.0;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}

//- (void)setTitle:(NSString *)title forState:(UIControlState)state
//
//@end
@end

