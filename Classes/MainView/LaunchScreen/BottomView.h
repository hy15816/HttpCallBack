//
//  BottomView.h
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/1/11.
//  Copyright © 2016年 yim. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^bottomViewActionBlock)(BOOL login,BOOL reg);

@interface BottomView : UIView

- (instancetype)initWithFrame:(CGRect)frame actions:(bottomViewActionBlock)block;


@end
