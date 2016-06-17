//
//  AlertView.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 15/12/28.
//  Copyright © 2015年 yim. All rights reserved.
//

#import "AlertView.h"

static AlertView *alert = nil;
@implementation AlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (AlertView *)shard{
    
    @synchronized(self) {
        if (alert == nil) {
            alert = [[AlertView alloc] init];
        }
    }
    
    return alert;
}

/// 指定时间后自动消失的提示窗
+ (void)showMessage:(NSString*)message time:(float)time
{

    CGSize size = [self getSizeForText:message font:[UIFont systemFontOfSize:16] withConstrainedSize:CGSizeMake(280, 200)];
    
    if(size.width < 50) {
    size.width = 50;
    }
    if(size.height < 40) {
    size.height = 40;
    }

    UILabel * label = [self LabelWithFrame:CGRectMake(0, 0, size.width + 20, size.height + 10) withText:message withTextColor:[UIColor whiteColor] withFont:16 withTextAlignment:NSTextAlignmentCenter withBackColor:[UIColor blackColor]];
    [label.layer setCornerRadius:10.0];
    label.clipsToBounds = YES;
    label.alpha = 0;
    CGPoint center = CGPointMake([UIApplication sharedApplication].keyWindow.center.x, [UIApplication sharedApplication].keyWindow.center.y-50);
    [label setCenter:center];
    [[UIApplication sharedApplication].keyWindow addSubview:label];
    
    [UIView animateWithDuration:0.3 animations:^{
        label.alpha = 0.8;
    }];
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        
        //[NSThread sleepForTimeInterval:time];
        NSLog(@"show msg str.length:%lu",(unsigned long)message.length);
        NSLog(@"show time.................:%f",message.length/50.f);
        
        [NSThread sleepForTimeInterval:message.length/50.f>=1?size.width/50.f:1];
    });
    
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:0.3 animations:^{
                label.alpha = 0;
            } completion:^(BOOL finished) {
                [label removeFromSuperview];
            }];
        });
    });
}

/// 动态获取文字所占长宽
+ (CGSize)getSizeForText:(NSString *)text font:(UIFont *)font withConstrainedSize:(CGSize)size
{
    CGSize new;
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        NSDictionary *attribute = @{NSFontAttributeName: font};
        new = [text boundingRectWithSize:size options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    }
    
    return new;
}

/// label
+ (UILabel *)LabelWithFrame:(CGRect)rect withText:(NSString *)text withTextColor:(UIColor *)textColor withFont:(int)fontSize withTextAlignment:(NSTextAlignment)alignment withBackColor:(UIColor *)backColor
{
    UILabel *label        = [[UILabel alloc] initWithFrame:rect];
    label.numberOfLines   = 0;
    label.text            = text;
    label.textColor       = textColor;
    label.font            = [UIFont systemFontOfSize:fontSize];
    label.textAlignment   = alignment;
    label.backgroundColor = backColor;
    return label;
}

@end
