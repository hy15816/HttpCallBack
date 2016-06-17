//
//  WillLoginView.h
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/1/11.
//  Copyright © 2016年 yim. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^loginButtonActionBlock)();

@interface WillLoginView : UIView

- (instancetype)initWithFrame:(CGRect)frame actions:(loginButtonActionBlock)block;

@end
