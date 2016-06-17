//
//  A.h
//  HttpCallBack
//
//  Created by AEF-RD-1 on 15/12/29.
//  Copyright © 2015年 yim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TestModel : NSObject

@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *detail;
@property (strong,nonatomic) NSString *imageName;

@property (assign,nonatomic) CGFloat cellHeight;

+ (instancetype)model;
+ (instancetype)modelWithTitle:(NSString *)title detail:(NSString *)detailStr imageName:(NSString *)imgName;

@end
