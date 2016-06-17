//
//  Chat3Cell.h
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/3/4.
//  Copyright © 2016年 yim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChatMessage;
@interface Chat3Cell : UITableViewCell

+ (instancetype) cell3ViewWithTableView:(UITableView *)tableView;
@property (strong,nonatomic) ChatMessage *chatMsg;

@end
