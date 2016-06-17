//
//  Chat3Cell.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/3/4.
//  Copyright © 2016年 yim. All rights reserved.
//

#import "Chat3Cell.h"
#import "ChatMessage.h"
#import "NSString+TextHeight.h"

@interface Chat3Cell ()

@property (strong, nonatomic) IBOutlet UILabel *msg_time;
@property (strong, nonatomic) IBOutlet UIButton *msg_his_pic;
@property (strong, nonatomic) IBOutlet UIButton *msg_my_pic;
@property (strong, nonatomic) IBOutlet UIButton *msg_his_con;
@property (strong, nonatomic) IBOutlet UIButton *msg_my_con;

@end

@implementation Chat3Cell

+ (instancetype)cell3ViewWithTableView:(UITableView *)tableView {
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    Chat3Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"chatCell3ID"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"Chat3Cell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}


- (void)setChatMsg:(ChatMessage *)chatMsg {
    _chatMsg = chatMsg;
    
    CGFloat btnW = self.msg_my_pic.frame.size.width;
    self.msg_my_pic.layer.cornerRadius = btnW *.5f;
    self.msg_his_pic.layer.cornerRadius = btnW *.5f;
    [self.msg_his_pic setImage:[UIImage imageNamed:chatMsg.msg_pic_name] forState:UIControlStateNormal];
    [self.msg_my_pic setImage:[UIImage imageNamed:chatMsg.msg_pic_name] forState:UIControlStateNormal];
    
    self.msg_my_con.titleLabel.numberOfLines = 0;
    [self.msg_my_con setTitle:chatMsg.msg_content forState:UIControlStateNormal];
    
    self.msg_his_con.titleLabel.numberOfLines = 0;
    [self.msg_his_con setTitle:chatMsg.msg_content forState:UIControlStateNormal];
    
    self.msg_time.text = chatMsg.msg_time;
    
    if (chatMsg.msg_is_from_his) {
        self.msg_my_pic.hidden = YES;
        self.msg_my_con.hidden = YES;
        self.msg_his_pic.hidden = NO;
        self.msg_his_con.hidden = NO;
    }else {
        self.msg_my_pic.hidden = NO;
        self.msg_my_con.hidden = NO;
        self.msg_his_pic.hidden = YES;
        self.msg_his_con.hidden = YES;
//        self.msg_content.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    
    
    CGFloat contentHeight = [chatMsg.msg_content heightWithText:chatMsg.msg_content font:self.msg_my_con.titleLabel.font width:190];
//    NSLog(@"contentHeight:%f",contentHeight);
    CGFloat cellHeight = contentHeight + self.msg_time.frame.size.height +  self.msg_time.frame.origin.y + 10.f *3 +10;
    
    chatMsg.msg_cell_height = cellHeight;
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
