//
//  Chat2Cell.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/3/3.
//  Copyright © 2016年 yim. All rights reserved.
//

#import "Chat2Cell.h"
#import "ChatMessage.h"
#import "NSString+TextHeight.h"

@interface Chat2Cell ()
@property (strong, nonatomic) IBOutlet UIButton *msg_time;
@property (strong, nonatomic) IBOutlet UIButton *msg_his_pic;
@property (strong, nonatomic) IBOutlet UIButton *msg_my_pic;
@property (strong, nonatomic) IBOutlet UIButton *msg_content;

@end

@implementation Chat2Cell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)cellViewWithTableView:(UITableView *)tableView {
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    Chat2Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"chatCellID"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"Chat2Cell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
    
}

- (void)setChatMeassage:(ChatMessage *)chatMeassage {
    NNLog(@" 111111 ");
    _chatMeassage = chatMeassage;
    
    CGFloat btnW = self.msg_my_pic.frame.size.width;
    self.msg_my_pic.layer.cornerRadius = btnW *.5f;
    self.msg_his_pic.layer.cornerRadius = btnW *.5f;
    [self.msg_his_pic setImage:[UIImage imageNamed:chatMeassage.msg_pic_name] forState:UIControlStateNormal];
    [self.msg_my_pic setImage:[UIImage imageNamed:chatMeassage.msg_pic_name] forState:UIControlStateNormal];
    
    self.msg_content.titleLabel.numberOfLines = 0;
    [self.msg_content setTitle:chatMeassage.msg_content forState:UIControlStateNormal];
    
    [self.msg_time setTitle:chatMeassage.msg_time forState:UIControlStateNormal];
    
    if (chatMeassage.msg_is_from_his) {
        self.msg_my_pic.hidden = YES;
        self.msg_his_pic.hidden = NO;
    }else {
        self.msg_my_pic.hidden = NO;
        self.msg_his_pic.hidden = YES;
        self.msg_content.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    
    
    
    CGFloat contentHeight = [chatMeassage.msg_content heightWithText:chatMeassage.msg_content font:self.msg_content.titleLabel.font width:self.msg_content.frame.size.width];
    
    CGFloat cellHeight = contentHeight + self.msg_time.frame.size.height +  self.msg_time.frame.origin.y + 10.f *3;
    chatMeassage.msg_cell_height = cellHeight;
    
}

@end
