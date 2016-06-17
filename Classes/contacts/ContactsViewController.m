//
//  ContactsViewController.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/3/1.
//  Copyright © 2016年 yim. All rights reserved.
//  联系人列表

#import "ContactsViewController.h"
#import "ChatViewController.h"
#import "TestChatTableViewController.h"

@interface ContactsViewController () <UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_rowArray;
    NSArray *_sectionArray;
    
    NSMutableDictionary *_showDic;//用来判断分组展开与收缩的
}

@property(nonatomic,strong)UITableView *contactsTableView;

@end

@implementation ContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //2.初始化_tableView
    self.contactsTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    //3.设置代理，头文件也要包含 UITableViewDelegate,UITableViewDataSource
    self.contactsTableView.delegate = self;
    self.contactsTableView.dataSource = self;
    //4.添加_tableView
    [self.view addSubview:self.contactsTableView];
    
    
    self.contactsTableView.tableFooterView = [[UIView alloc]init];
    
    
    _sectionArray = [NSArray arrayWithObjects:@"好友",@"家人",@"朋友",@"同学",@"陌生人",@"黑名单", nil];
    
    _rowArray = [NSArray arrayWithObjects:@"张三",@"李四",@"王五",@"未命名",@"未命名", nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_sectionArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_rowArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellids"];
    if(cell==NULL){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellids"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.separatorInset=UIEdgeInsetsZero;
        cell.clipsToBounds = YES;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"    第 %ld 行： %@",indexPath.row,_rowArray[indexPath.row]];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_showDic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.section]]) {
        return 44;
    }
    return 0;
}
//section头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
//section头部显示的内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.contactsTableView.frame.size.width, 40)];
    header.backgroundColor = [UIColor whiteColor];
    header.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    header.layer.borderWidth = .5f;
    
    // button------------- 左边
    UIButton *buttonLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *key = [NSString stringWithFormat:@"%ld",section];
    if (![_showDic objectForKey:key]) {
        [buttonLeft setImage:[UIImage imageNamed:@"triangle_right"] forState:UIControlStateNormal];
    }else{
        [buttonLeft setImage:[UIImage imageNamed:@"triangle_down"] forState:UIControlStateNormal];
    }
    [buttonLeft setTitle:[NSString stringWithFormat:@"--第 %ld 组",section] forState:UIControlStateNormal];
    [buttonLeft setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    buttonLeft.frame = CGRectMake(10, 5, header.frame.size.width, 30);
    buttonLeft.tag = section;
    [buttonLeft setTitleEdgeInsets:UIEdgeInsetsMake(5, -buttonLeft.frame.size.width * .55f, 0, 0)];
    [buttonLeft setImageEdgeInsets:UIEdgeInsetsMake(5, -buttonLeft.frame.size.width * .6f, 5, 0)];
    [buttonLeft addTarget:self action:@selector(buttonLeftAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // button------------- 右边
    UIButton *buttonRight = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonRight.frame = CGRectMake(header.frame.size.width-30,10 , 20, 20);
    buttonRight.titleLabel.font = [UIFont systemFontOfSize:14];
    buttonRight.backgroundColor = [UIColor redColor];
    buttonRight.layer.cornerRadius = 10.f;
    [buttonRight setTitle:@"5" forState:UIControlStateNormal];
    buttonRight.userInteractionEnabled = NO;
    
    [header addSubview:buttonLeft];
    [header addSubview:buttonRight];
    
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        ChatViewController *chat = [[UIStoryboard storyboardWithName:@"ContactsStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"ChatViewController"];
        chat.title = _rowArray[indexPath.row];
        [self.navigationController pushViewController:chat animated:YES];
    }
    if (indexPath.section == 5) {
        TestChatTableViewController *chat = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TestTableViewController"];
        chat.title = _rowArray[indexPath.row];
        [self.navigationController pushViewController:chat animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark 展开收缩section中cell 监听

- (void)buttonLeftAction:(UIButton *)button {
    
    NSInteger didSection = button.tag;
    
    
    if (!_showDic) {
        _showDic = [[NSMutableDictionary alloc]init];
    }
    
    NSString *key = [NSString stringWithFormat:@"%ld",didSection];
    if (![_showDic objectForKey:key]) {
        [_showDic setObject:@(YES) forKey:key];
        [button setImage:[UIImage imageNamed:@"triangle_right"] forState:UIControlStateNormal];
        
    }else{
        [_showDic removeObjectForKey:key];
        [button setImage:[UIImage imageNamed:@"triangle_down"] forState:UIControlStateNormal];
    }
    
    NSLog(@"_showDic:%@",_showDic);
    
    [self.contactsTableView reloadSections:[NSIndexSet indexSetWithIndex:didSection] withRowAnimation:UITableViewRowAnimationFade];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
