//
//  Chat2Cell.h
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/3/3.
//  Copyright © 2016年 yim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChatMessage;
@interface Chat2Cell : UITableViewCell

+ (instancetype) cellViewWithTableView:(UITableView *)tableView;
@property (strong,nonatomic) ChatMessage *chatMeassage;

@end
