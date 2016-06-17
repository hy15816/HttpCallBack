//
//  UITextField+YIMPullList.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/1/20.
//  Copyright © 2016年 yim. All rights reserved.
//

#import "UITextField+YIMPullList.h"
#import "YIMPullList.h"

@implementation UITextField (YIMPullList)
@dynamic y_pullList;

-(void)setY_pullList:(YIMPullList *)y_pullList {
    
    CGFloat listViewX = self.frame.origin.x;
    CGFloat listViewY = self.frame.origin.y + self.frame.size.height;
    
    CGFloat listViewW = self.frame.size.width;
    
    CGFloat listViewH = y_pullList.frame.size.height;
    
    if (listViewH > [UIScreen mainScreen].bounds.size.height /3) {
        listViewH = [UIScreen mainScreen].bounds.size.height /3;
    }
    
    y_pullList.frame = CGRectMake(listViewX, listViewY, listViewW, listViewH);
    y_pullList.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.superview addSubview:y_pullList];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [super touchesBegan:touches withEvent:event];
    
    //判断触摸点是否在 listView上,不是则收起listView
    
    
}




@end
