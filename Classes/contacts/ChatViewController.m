//
//  ChatViewController.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/3/1.
//  Copyright © 2016年 yim. All rights reserved.
//

#import "ChatViewController.h"
#import "Chat2Cell.h"
#import "ChatMessage.h"
#import "Chat3Cell.h"

@interface ChatViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSMutableArray *_messageList;
}
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *chatTableViewTopConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tool_base_view_constraint;

@property (strong, nonatomic) IBOutlet UITableView *chatTableView;
@property (strong, nonatomic) IBOutlet UIView *tool_base_view;
@property (strong, nonatomic) IBOutlet UIImageView *tool_imgv;
@property (strong, nonatomic) IBOutlet UIButton *tool_left_btn;
@property (strong, nonatomic) IBOutlet UIButton *tool_right_btn;
@property (strong, nonatomic) IBOutlet UIButton *tool_right_btn2;
@property (strong, nonatomic) IBOutlet UITextField *tool_field;

@property (assign,nonatomic) CGFloat lastScrollOffset;

@end

@implementation ChatViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tool_field.delegate = self;
    self.chatTableView.delegate = self;
    self.chatTableView.dataSource = self;
    
    _messageList = [[NSMutableArray alloc] init];
    for (int i=0; i<10; i++) {
        ChatMessage *msg = [[ChatMessage alloc] init];
        msg.msg_content = [NSString stringWithFormat:@"去玩儿推87465132哦11阿斯顿飞1过后寒假快乐156165注31516册在相册VB15616321把31351313你13们13东13方皮3去13维护1汽3配13怒1ip去3武13汉13青1浦我1们31服31了3不会付完%d%d%d",i,i,i];
        if (i%3==0) {
            msg.msg_content = @"ofnnnnnnnnnnaepwuigqw";
        }
        msg.msg_is_from_his = i%2;
        msg.msg_pic_name = i%2 == 0?@"tabbar_first_n":@"tabbar_four_s";
        msg.msg_time = [NSString stringWithFormat:@"16-2-%d 10:00:00",i];
        [_messageList addObject:msg];
    }
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSIndexPath *path = [NSIndexPath indexPathForRow:_messageList.count - 1 inSection:0];
    [self.chatTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIKeyboardWillChangeFrameNotification

// 监听键盘的frame即将改变的时候调用
- (void)keyboardFrameWillChange:(NSNotification *)note{
    // 获得键盘的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    self.chatTableViewTopConstraint.constant = -(self.view.frame.size.height - frame.origin.y);
    // 修改底部约束
    self.tool_base_view_constraint.constant = self.view.frame.size.height - frame.origin.y;
    
//    NNLog(@"constant:%f",self.view.frame.size.height - frame.origin.y);
    
    // 执行动画
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration animations:^{
        
        // 如果有需要,重新排版
//        [self.view layoutIfNeeded];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"_messageList.count:%lu",_messageList.count);
    return _messageList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
//    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chatCellID" forIndexPath:indexPath];
//    Chat2Cell *cell = [Chat2Cell cellViewWithTableView:tableView];
    Chat3Cell *cell = [Chat3Cell cell3ViewWithTableView:tableView];
    cell.chatMsg = _messageList[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return [_messageList[indexPath.row] msg_cell_height];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tool_field resignFirstResponder];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //往上拖动弹出键盘
    if (scrollView == self.chatTableView) {
        CGFloat y = scrollView.contentOffset.y;
        if (y > self.lastScrollOffset) {
            //用户往上拖动，
            if (scrollView.contentSize.height - y <370) {
                [self.tool_field becomeFirstResponder];
            }
//            NSLog(@"y up :%f",y);
        } else {
            
        }
        self.lastScrollOffset = y;
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    if (scrollView == self.chatTableView) {
        CGFloat y = scrollView.contentOffset.y;
        if (y > self.lastScrollOffset) {
            
        }else {
            [self.tool_field resignFirstResponder];
        }
        self.lastScrollOffset = y;
    }

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {

    //    if (scrollView.contentOffset.y > 50) {
//        [self.tool_field becomeFirstResponder];
//    }
    
//    NSLog(@"scrollView.contentOffset.y:%f",scrollView.contentOffset.y);
//    NSLog(@"contentSize.height :%f",scrollView.contentSize.height);
    
}

#pragma mark - 
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    //发送
    ChatMessage *msg = [[ChatMessage alloc] init];
    msg.msg_content = textField.text;
    msg.msg_is_from_his = rand()%2;
    msg.msg_pic_name = rand()%2 == 1?@"tabbar_first_n":@"tabbar_four_s";
    msg.msg_time = @"16-2-%d 10:00:00";
    [_messageList removeObjectAtIndex:0];
    [_messageList addObject:msg];
    
    NSLog(@"_messageList:%@,count:%lu",_messageList,(unsigned long)_messageList.count);
    [self.chatTableView reloadData];
    NSIndexPath *indedPath = [NSIndexPath indexPathForRow:_messageList.count -1 inSection:0];
//    [self.chatTableView reloadRowsAtIndexPaths:@[indedPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.chatTableView scrollToRowAtIndexPath:indedPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        });
    });
    
    
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
