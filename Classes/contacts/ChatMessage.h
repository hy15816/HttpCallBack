//
//  ChatMessage.h
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/3/1.
//  Copyright © 2016年 yim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatMessage : NSObject


@property (strong, nonatomic) NSString *msg_content;

@property (strong, nonatomic) NSString *msg_time;

@property (assign, nonatomic) BOOL msg_is_from_his;

@property (strong, nonatomic) NSString *msg_pic_name;

@property (assign ,nonatomic) CGFloat msg_cell_height;


@end
