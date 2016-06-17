//
//  MusicViewController.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/1/7.
//  Copyright © 2016年 yim. All rights reserved.
//

#import "MusicViewController.h"
#import "WillLoginView.h"
#import "LoginViewController.h"
#import "UITextField+YIMPullList.h"
#import "YIMPullList.h"
#import "YIMTableView.h"
#import "ChineseString.h"
#import "YIMPopView.h"
#import "TestFooterTableViewController.h"
#import "GlobalTool.h"
#import "APIManager.h"
#import "CommunityInfo.h"
#import "IMYButton.h"
#import "SnowViewController.h"
#import "BLETableViewController.h"

#define kMusicListURL @"http://project.lanou3g.com/teacher/UIAPI/MusicInfoList.plist"


@interface MusicViewController ()<UITextFieldDelegate,YIMTableViewDelegate,YIMPopViewDelegate,APIManagerDelegate>
{
    
    NSMutableArray *_dataArray;
    
    UIWebView *_webView;
    BOOL _isAdd;
    
    NSTimer *_showTimeTimer;
    int _imageIndex;
    
    
    
}

@property (strong,nonatomic) UIBarButtonItem *rightBarItem;

@property (strong, nonatomic) UITextField *testField;
@property (strong, nonatomic) UILabel *showMsgLabel;
@property (strong, nonatomic) YIMPullList *list;

@property (nonatomic, assign) BOOL showNext;

@property (strong,nonatomic) UIButton *b;
@property (strong,nonatomic) UIView *downView;

@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"shows" style:UIBarButtonItemStylePlain target:self action:@selector(leftActions)];
    self.rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"show" style:UIBarButtonItemStylePlain target:self action:@selector(rightActions:)];
    self.navigationItem.rightBarButtonItem = self.rightBarItem;
    _isAdd = YES;
    self.b = [UIButton buttonWithType:UIButtonTypeCustom];
    self.b.frame = CGRectMake(110, 200, 50, 50);
    [self.b setImage:[UIImage imageNamed:@"test_icon_add"] forState:UIControlStateNormal];
//    [self.view addSubview:self.b];
//
//    [self.b addTarget:self action:@selector(bActions:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.b];
    /*
    //添加提示view
    WillLoginView *willLogin = [[WillLoginView alloc] initWithFrame:self.view.frame actions:^{
        //
        LoginViewController *loginVc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:loginVc animated:YES];
    }];
    
    [self.view addSubview:willLogin];
     */
    
    
//    [self.view addSubview:self.testField];
    _dataArray = [[NSMutableArray alloc] init];
    NSArray *array = @[@"123",@"456",@"789",@"456",@"789",@"123",@"456",@"789",@"456",@"789"];
    [_dataArray addObjectsFromArray:array];
    /*
    _list = [YIMPullList pullListWithArray:array selectItemBlock:^(NSIndexPath *path, NSString *item) {
        //
        NSLog(@"....item:%@",item);
        self.testField.text = item;
    }];
    self.testField.y_pullList = _list;
    self.testField.delegate = self;
    */
    
//    self.showMsgLabel.text = @"show show";
//    [self.view addSubview:self.showMsgLabel];
    
    
//    YIMTableView *table = [YIMTableView tableViewWithFrame:CGRectMake(0, 100, 200, 200) dataArray:array];
//    table.delegate = self;
//    [self.view addSubview:table];
    
//    NSString *testName = @"东莞市";
//    self.testField.text = [self findNameWithCity:testName];
    
    /*
    _brandClicked = [NSMutableDictionary dictionaryWithCapacity:1];
    _modelClicked = [NSMutableDictionary dictionaryWithCapacity:1];

    _brandArray = [[NSMutableArray alloc] init];
    _hotBrandArray = [[NSMutableArray alloc] init];
    _modelArray = [[NSMutableArray alloc] init];
    _detailArray = [[NSMutableArray alloc] init];
    self.sortedArrForArrays = [[NSMutableArray alloc] init];
    self.sectionHeadsKeys = [[NSMutableArray alloc] init];
    
    [self readFileData];
    [self.view addSubview:self.carBrandTableView];
    [self hideFootView:self.carBrandTableView];
     
     */
    
    /* 加载html
    CGFloat width = self.view.frame.size.width;
    NSString *headerString =[NSString stringWithFormat:@"<head><style>img{max-width:%dpx !important;}</style></head>",(int)width] ;
    NSString *htmlString = @"<p> <img src=\"https://admin.430569.com/upload/admin12345678/image/201601/e45d7b12-7643-4fff-8e30-9467498202ce.jpg\" alt=\"\">&nbsp; </p> <p> <img src=\"https://admin.430569.com/upload/admin12345678/image/201601/61f4ed3f-f05c-4c58-8ee5-a6f10b26f9c3.png\" alt=\"\"><img src=\"https://admin.430569.com/upload/admin12345678/image/201601/f04226e4-4276-4c20-a8d2-957f1051e9a1.jpg\" alt=\"\"> </p>";
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_webView];
    
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    [_webView loadHTMLString:[NSString stringWithFormat:@"%@%@",headerString,htmlString] baseURL:nil];
    */
    
    
    
    
    [self downloadMusicURLList];
    
    NSDictionary *info = @{@"area_name" : @"松山湖",
                           @"city_name" : @"东莞市",
                           @"community_name" : @"研发测试小区",
                           @"province_name" : @"广东省"
                           };
    CommunityInfo *comm = [CommunityInfo info];
    comm.commDict = info;
    
    NSLog(@"%@%@%@%@",comm.provinceName,comm.cityName,comm.areaName,comm.communityName);
    
    [self createOrderWithCar:@"粤S7896K" phone:@"18565667965" name:@"yim" propretyid:@"notFound" documentCode:@"document" userName:@"18565667965" chargeType:1 parkingType:1 amount:@"1" startTime:@"2016-1-29 16:59:00" endTime:@"2016-1-29 16:59:00" communityNum:@"401980850" subject:@"sun" paymentType:1];
    
    
    
    NSArray *itemsTitle = @[@"删除",@"增加",@"测试蓝牙"];
    NSArray *itemsImage = @[@"Home_delete_icon",@"test_icon_add",@"icon_checkbox_serv_true"];
    [self addDownViewWithItemsTitle:itemsTitle itemsImage:itemsImage];
    

}
#pragma mark - 写入文件

#pragma mark - ----------

- (void)bActions:(UIButton *)bb {
    
    _isAdd = !_isAdd;
    [UIView animateWithDuration:.3 animations:^{
        if (_isAdd) {
            self.b.transform = CGAffineTransformIdentity;
        }else {
            self.b.transform = CGAffineTransformMakeRotation(45*M_PI/180); //顺时针旋转45°
            self.downView.alpha = 1;
            
            [UIView animateWithDuration:.3 animations:^{
                //
                UIView *view = [self.downView viewWithTag:11];
                view.frame = CGRectMake(0, 0, self.view.frame.size.width, view.frame.size.height);
            }];
            
        }
    }];
    
    
}

- (void)addDownViewWithItemsTitle:(NSArray *)itemsTitle itemsImage:(NSArray *)itemsImage
{
    
    if (self.downView == nil) {
        CGFloat downViewY = self.navigationController.navigationBar.frame.size.height + 20.f;
        self.downView = [[UIView alloc] initWithFrame:CGRectMake(0, downViewY, self.view.frame.size.width, self.view.frame.size.height - downViewY)];
        self.downView.alpha = 0;
        
        UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        grayView.backgroundColor = [UIColor grayColor];
        grayView.alpha = .2;
        grayView.tag = 22;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGrayView:)];
        tap.numberOfTapsRequired = 1;
        
        [grayView addGestureRecognizer:tap];
        
        UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake(0, -100, self.view.frame.size.width, 100)];
        itemView.backgroundColor = [UIColor whiteColor];
        itemView.tag = 11;
        
        
        for (int i=0; i<itemsTitle.count; i++) {
            CGFloat marginLeft = 10.f;
            CGFloat marginTop = 10.f;
            CGFloat butuW = (itemView.frame.size.width - marginLeft*(itemsTitle.count + 1)) / itemsTitle.count;
            NSLog(@"butuW:%f",butuW);
            IMYButton *butn = [IMYButton buttonWithType:UIButtonTypeCustom];
            butn.tag = i;
            butn.backgroundColor = [UIColor groupTableViewBackgroundColor];
            butn.frame = CGRectMake(marginLeft *(i+1) + i*butuW, marginTop, butuW, itemView.frame.size.height - marginTop *2);
            [butn setTitle:itemsTitle[i] forState:UIControlStateNormal];
            [butn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [butn setImage:[UIImage imageNamed:itemsImage[i]] forState:UIControlStateNormal];
            [butn addTarget:self action:@selector(butuActions:) forControlEvents:UIControlEventTouchUpInside];
            [itemView addSubview:butn];
        }
        
        
        [self.downView addSubview:grayView];
        [self.downView addSubview:itemView];
        [self.view addSubview:self.downView];
    }
    
    
    
}

- (void)butuActions:(UIButton *)butu {
    
    NSLog(@"[butu.tag] == %ld ",(long)butu.tag);
    _isAdd = !_isAdd;
    [self dismissDownView];
    
    if (butu.tag == 1) {
        SnowViewController *snow = [[SnowViewController alloc] init];
        [self.navigationController pushViewController:snow animated:YES];
    }
    if (butu.tag == 2) {
        BLETableViewController *bleVC = [[UIStoryboard storyboardWithName:@"MusicStoryboard" bundle:nil]  instantiateViewControllerWithIdentifier:@"BLETableViewController"];
        [self.navigationController pushViewController:bleVC animated:YES];
    }
    
    
}
- (void)tapGrayView:(UITapGestureRecognizer *)tap {
    
    _isAdd = !_isAdd;
    [self dismissDownView];
    
}

- (void)dismissDownView {
    
    [self.rightBarItem setTitle:@"show"];
    UIView *view = [self.downView viewWithTag:11];
    [UIView animateWithDuration:.3 animations:^{
        //
        view.frame = CGRectMake(0, - view.frame.size.height, self.view.frame.size.width, view.frame.size.height);
    }completion:^(BOOL finished) {
        self.downView.alpha = 0;
    }];
}
- (void)createOrderWithCar:(NSString *)licensePlateNumber phone:(NSString *)phone name:(NSString *)name propretyid:(NSString *)pid documentCode:(NSString *)dCode userName:(NSString *)userName chargeType:(int)chargeType parkingType:(int)parkingType amount:(NSString *)amount startTime:(NSString *)sTime endTime:(NSString *)eTime communityNum:(NSString *)communityNumber subject:(NSString *)subject paymentType:(NSInteger)payment_type {
    
    NSString *reqURL = @"http://192.168.1.55:8080/arf-web/AnerfaBackstage/parkRate/parkRateOrderRecord.jhtml";//月租车
    NSDictionary *dict= @{@"documentCode":dCode,@"user_name":userName,
                          @"communityNumber":communityNumber,@"subject":subject,
                          @"phone":phone,@"name":name,@"licensePlateNumber":licensePlateNumber,
                          @"propretyId":pid,@"chargeType":[NSNumber numberWithInt:chargeType],
                          @"parkingType":[NSNumber numberWithInt:parkingType],
                          @"amount":amount,@"startTime":sTime,@"endTime":eTime,
                          @"payment_type":[NSNumber numberWithInteger:payment_type]           //支付类型
                          };
    
    NSLog(@"reqURL:%@\n,dict:%@",reqURL,dict);
    
    [APIManager APIPOSTJSONWithUrl:reqURL parameters:dict show:YES success:^(NSURLSessionDataTask *task, id responseObject) {
        //
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        //
    }];
    
}


/**
 *  下载音乐地址的plist
 */
- (void)downloadMusicURLList {
    
    APIManager *manager = [APIManager managerWithDelegate:self];
    [manager getWithUrl:kMusicListURL patamer:nil];
    
}
- (void)leftActions {
    
    TestFooterTableViewController *tests = [[UIStoryboard storyboardWithName:@"MusicStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"TestFooterTableViewController"];
    [self.navigationController pushViewController:tests animated:YES];
    
}

- (void)rightActions:(UIBarButtonItem *)item {
    
    _isAdd = !_isAdd;

    if (_isAdd) {
        [item setTitle:@"show"];
        [self dismissDownView];
    }else {
        
        [item setTitle:@"hide"];
        //显示
        [UIView animateWithDuration:0.0 animations:^{
            //
            self.downView.alpha = 1;
        } completion:^(BOOL finished) {
            //
            [UIView animateWithDuration:.3 animations:^{
                UIView *view = [self.downView viewWithTag:11];
                view.frame = CGRectMake(0, 0, self.view.frame.size.width, view.frame.size.height);
            }];
        }];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

#pragma mark - 
- (void)apiManagerDidSuccess:(APIManager *)manager {
    
    NSLog(@"data:%@",manager.rawData);
}
- (void)apiManagerDidFailure:(NSError *)error {
    
    NSLog(@"error:%@",error);
}

#pragma mark - YIMTableViewDelegate


#pragma mark - YIMPopViewDelegate 
- (void)popView:(YIMPopView *)popView didSelectAtIndexPath:(NSIndexPath *)indexPath {
    
    [GlobalTool animateIncorrectMessage:_webView];
}



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
     return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
     return nil;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300.0, 20.0)];
    customView.backgroundColor = [UIColor colorWithRed:238/255.0 green:233/255.0 blue:233/255.0 alpha:1];

    
    return customView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}

#pragma mark - YIMTableViewDelegate
- (void)yimTableView:(YIMTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"YIMTableView,,didSelectRowAtIndexPath:%@",indexPath);
}

#pragma mark -  UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    [_list spreadList];
    
    return YES;
}



#pragma mark - private


#pragma mark -----按照首字母分组排序---------


- (void)hideFootView:(UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    tableView.tableFooterView = view;
}

#pragma mark - 获取与定位城市相同的名字的车牌号前2位，
- (NSString *)findNameWithCity:(NSString *)cityName {
    
    return [self readFileWithFileName:@"abcd" fileType:@"txt" finds:cityName];;
}

- (NSString *)readFileWithFileName:(NSString *)fileName fileType:(NSString *)type finds:(NSString *)testName {
    
    NSString *shortName = nil;
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:fileName ofType:type];
    NSError *err;
    //kCFStringEncodingGB_2312_80
    //kCFStringEncodingGB_18030_2000
    //NSUTF8StringEncoding
    NSString *content = [[NSString alloc] initWithContentsOfFile:plistPath encoding:NSUTF8StringEncoding error:&err];
    if (err) {
        NSLog(@"read err :%@",err);
        return nil;
    }
    
    NSArray *array = [content componentsSeparatedByString:@"\n"];
    //NSLog(@"array:%@",array);
    
    for (int i=0; i<array.count; i++) {
        //
        NSString *item = array[i];
        //NSLog(@"item:%@",item);
        NSArray *itemArray = [item componentsSeparatedByString:@"&"];
        
        for (int j=0; j<itemArray.count; j++) {
            NSString *city_short = itemArray[j];
            NSArray *abc = [city_short componentsSeparatedByString:@" "];
            if ([testName isEqualToString:[abc objectAtIndex:1]]) {
                //NSLog(@"，，，，，，，：%@",[abc objectAtIndex:0]);
                shortName = [abc objectAtIndex:0];
                break;
            }
            //NSLog(@"abc:%@",[abc objectAtIndex:0]);
        }
        
    }
    
    return shortName;
}

#pragma mark - Setters and getters
- (UILabel *)showMsgLabel {
    
    if (_showMsgLabel == nil) {
        _showMsgLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/3, self.view.frame.size.height/3, 100, 30)];
        _showMsgLabel.textColor = [UIColor redColor];
        _showMsgLabel.textAlignment = NSTextAlignmentCenter;
        _showMsgLabel.backgroundColor = [UIColor clearColor];
        _showMsgLabel.layer.cornerRadius = 3.f;
        _showMsgLabel.layer.borderColor = [UIColor purpleColor].CGColor;
        _showMsgLabel.layer.borderWidth = 1.f;
    }
    return _showMsgLabel;
}

- (UITextField *)testField {
    
    if (_testField == nil) {
        _testField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 200, 100.f, 200, 30)];
        _testField.borderStyle = UITextBorderStyleRoundedRect;
        _testField.textColor = [UIColor redColor];
        _testField.textAlignment = NSTextAlignmentLeft;
        _testField.backgroundColor = [UIColor clearColor];

    }
    
    return _testField;
}


@end
