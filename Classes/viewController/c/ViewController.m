//
//  ViewController.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 15/12/24.
//  Copyright © 2015年 yim. All rights reserved.
//

/** 登录*/
#define kTAG_ALERT_LOGIN 122801

#import "ViewController.h"
#import "APIManager.h"
#import "XXXView.h"
#import "YYYView.h"
#import "NSString+MD5.h"
#import "AlertView.h"
//#import "SVProgressHUD.h"
#import "MBProgressHUD.h"
#import "TestChatTableViewController.h"
#import "LaunchViewController.h"

@interface ViewController ()<APIManagerDelegate,ReformerProtocol,UIAlertViewDelegate>

@property (strong,nonatomic) id<ReformerProtocol> XXXReformer;
@property (strong,nonatomic) id<ReformerProtocol> YYYReformer;


@property (strong,nonatomic) XXXView *xxxView;
@property (strong,nonatomic) YYYView *yyyView;



- (IBAction)reqAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *textViewShowResult;
- (IBAction)alertAction:(UIBarButtonItem *)sender;

@end

@implementation ViewController
{   //在这里定义私有成员变量？
    NSInteger _value;
}
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self.view addSubview:self.xxxView];
    [self.view addSubview:self.yyyView];
    
    //抛出一个异常
    //[self performSelector:@selector(thowWithException) withObject:nil afterDelay:5];
    
}

- (void)thowWithException {
    
    NSException *exception = [NSException exceptionWithName:@"ViewController viewDidLoad error" reason:@"the child class must conforms to 123" userInfo:nil];
    @throw exception;
}

/**
 *  这个里面创建Constraints并添加
 */
- (void)layoutPageSubviews{
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //一般<更新Form数据>,
    //NSLog(@"[viewWillAppear:]");
}
//在viewWillLayoutSubviews 或 viewDidLayoutSubviews 改变view的位置(只有在页面元素调整之后才会调用,<实测只要有界面元素调整都会调用>)，
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    //NSLog(@"[viewWillLayoutSubviews]");
    
    
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    //NSLog(@"[viewDidLayoutSubviews]");
    
    _xxxView.frame = CGRectMake(0, 65, 100, 50);
    _yyyView.frame = CGRectMake(self.view.frame.size.width - 100, 65,100 , 50);
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  ViewController 代码结构规定<顺序>
 *  1)life cycle:           生命周期管理
 *  2)CustomDelegate:       每一个delegate都把对应的protocol名字带上
 *  3)Event Response:       所有button、gestureRecognizer的响应事件都放在这个区域里面
 *  4)Private Methods:      正常情况下ViewController里面不应该写
 *  5)getters and setters:  所有的属性都使用getter和setter
 */
#pragma mark - UITableViewDelegate

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == kTAG_ALERT_LOGIN) {
        if (buttonIndex == 1) {
            //获取输入的info
            NSString *userName = [[alertView textFieldAtIndex:0] text];
            NSString *userPwds = [[alertView textFieldAtIndex:1] text];
            userPwds = [userPwds stringWithMD5];
            if ([[userName purify] length] <=0) {
                [AlertView showMessage:@"11111111请输入正确的账号111111111111113333333333333344444444444444444455555" time:2.5];
                return;
            }
            if ([[userPwds purify] length] <=0) {
                [AlertView showMessage:@"输入密码" time:1];
                return;
            }
            APIManager *manager = [APIManager managerWithDelegate:self];
            NSString *url = kHTTP(uLogin);
            NSDictionary *sdict = @{@"user_name":userName,@"password":userPwds,@"currentEquipment":@2 };
            [manager postWithUrl:url patamer:sdict];
            _xxxView.user_name = userName;
        }
        
    }
    
}

#pragma mark - CustomDelegate
#pragma mark - APIManagerDelegate
- (void)apiManagerDidSuccess:(APIManager *)manager {
    
    NSDictionary *reformedXXXData = [manager fetchDataWithReformer:self.XXXReformer];
    [self.xxxView configWithData:reformedXXXData];
    
    NSDictionary *reformedYYYData = [manager fetchDataWithReformer:self.YYYReformer];
    [self.yyyView configWithData:reformedYYYData];
    
}

- (void)apiManagerDidFailure:(NSError *)error {
    
    //NSString *reqErr = [NSString stringWithFormat:@"err.code:%ld....err.s:%@",(long)error.code,error.localizedDescription];
    //NSLog(reqErr,nil);
}

#pragma mark -
- (NSDictionary *)reformDataWithManager:(APIManager *)manager {
    
    return [manager fetchDataWithReformer:self.XXXReformer];
}
#pragma mark - Event Response
- (IBAction)reqAction:(id)sender {

    /*
    UIAlertView *loginsAlert = [[UIAlertView alloc] initWithTitle:@"login" message:@"input" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"log in", nil];
    loginsAlert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    loginsAlert.tag = kTAG_ALERT_LOGIN;
    [loginsAlert show];
    */
    
    
}

- (IBAction)alertAction:(UIBarButtonItem *)sender {
    
    LaunchViewController *launchView = [[LaunchViewController alloc] initWithNibName:@"LaunchViewController" bundle:nil];

    [self.navigationController presentViewController:launchView animated:YES completion:nil];
    
    return;
    
    //[AlertView showMessage:@"请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账" time:1.5];
    //[SVProgressHUD showSuccessWithStatus:@"请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号请输入账号成功"];
    //[SVProgressHUD showWithStatus:@"loading..." maskType:SVProgressHUDMaskTypeBlack];       //覆盖所有页面之上<灰色>
    //[SVProgressHUD showWithStatus:@"loading..." maskType:SVProgressHUDMaskTypeClear];     //覆盖所有页面之上<透明色>
    //[SVProgressHUD showWithStatus:@"loading..." maskType:SVProgressHUDMaskTypeNone];      //不覆盖，只显示<显示之后还可以对页面进行操作>
    //[SVProgressHUD showWithStatus:@"loading..." maskType:SVProgressHUDMaskTypeGradient];  //覆盖所有页面之上<渐变灰白色>
    
    /*
    NSLog(@"===============hud began=====================");
    //================
    //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //[self performSelector:@selector(timoutMethod) withObject:nil afterDelay:10.f];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeDeterminate;
    hud.labelText = @"loading...";
    
    [self performSelector:@selector(timeouts:) withObject:hud afterDelay:0];
     */
}

- (void)timeouts:(MBProgressHUD *)huds{
    huds.progress+=.01f;
    if (huds.progress>=1) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(timeouts:) object:nil];
        [huds hide:YES];
        NSLog(@"===============hud end=====================");
    }
    
    [self performSelector:@selector(timeouts:) withObject:huds afterDelay:.1f];
}
- (void)timoutMethod:(MBProgressHUD *)huds {
    
    //[SVProgressHUD showErrorWithStatus:@"请求超时"];
    //[MBProgressHUD hideHUDForView:self.view animated:YES];
    
    NSLog(@"===============hud end=====================");
}
#pragma mark - Private Methods

- (void)privateMothods {
    
    NSLog(@"................在这里写Private Methods，正常情况不建议VC写");
}

#pragma mark - getters and setters

-(XXXView *)xxxView {
    
    if (_xxxView == nil) {
        _xxxView = [[XXXView alloc] init];
        
        _xxxView.backgroundColor = [UIColor greenColor];
    }
   
    return _xxxView;
}

- (YYYView *)yyyView {
    if (_yyyView == nil) {
        _yyyView = [[YYYView alloc] init];
        
        _yyyView.backgroundColor = [UIColor blackColor];
    }
    
    return _yyyView;
}

-(UITextView *)textViewShowResult {
    
    _textViewShowResult.layer.borderWidth = .5;
    _textViewShowResult.layer.borderColor = [UIColor greenColor].CGColor;
    return _textViewShowResult;
}







/**
 *  笔记
 *  在iOS开发领域中，怎样才算是MVC划分的正确姿势？
 
 M应该做的事：
     1.给ViewController提供数据
     2.给ViewController存储数据提供接口
     3.提供经过抽象的业务基本组件，供Controller调度
 
 C应该做的事：
     1.管理View Container的生命周期
     2.负责生成所有的View实例，并放入View Container
     3.监听来自View与业务有关的事件，通过与Model的合作，来完成对应事件的业务。
 
 V应该做的事：
     1.响应与业务无关的事件，并因此引发动画效果，点击反馈（如果合适的话，尽量还是放在View去做）等。
     2.界面元素表达
 
 =================拆分的心法=============
 1.保留最重要的任务，拆分其它不重要的任务
 2.拆分后的模块要尽可能提高可复用性，尽量做到DRY
 3.要尽可能提高拆分模块后的抽象度
 =================架构设计心法=============
 1.尽可能减少继承层级，涉及苹果原生对象的尽量不要继承
 2.做好代码规范，规定好代码在文件中的布局，尤其是ViewController
 3.能不放在Controller做的事情就尽量不要放在Controller里面去做
 4.架构师是为业务工程师服务的，而不是去使唤业务工程师的
 */

@end
