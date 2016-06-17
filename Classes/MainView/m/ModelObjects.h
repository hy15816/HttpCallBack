//
//  ModelObjects.h
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/1/11.
//  Copyright © 2016年 yim. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ModelObjectsDelegate <NSObject>

- (void)m_actions;

@end

@interface ModelObjects : NSObject

@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *address;
@property (assign,nonatomic) NSInteger age;
@property (strong,nonatomic) NSString *phone;

- (NSDictionary *)feachModelWithRefer:(id<ModelObjectsDelegate>)delegate;


@end
