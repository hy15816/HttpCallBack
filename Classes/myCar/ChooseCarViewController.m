//
//  ChooseCarViewController.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/1/22.
//  Copyright © 2016年 yim. All rights reserved.
//

#import "ChooseCarViewController.h"
#import "ChineseString.h"
#import "GlobalTool.h"
#import "NSDictionary+Helper.h"
#import "CarBrandCell.h"

typedef enum {
    MyCar                = 1,    //我的车型
    WantCar              = 2,    //意向车型
    ChangeCar            = 3,    //修改车型
} CarType;

@interface ChooseCarViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    NSMutableArray *hotBrandArray;
    NSMutableArray *brandArray;
    NSMutableArray *modelArray;
    NSMutableArray *detailArray;
    NSMutableDictionary *brandClicked;
    NSMutableDictionary *modelClicked;
    int changeHeight1;
    int changeHeight2;
    BOOL haveLoad;
    
    CarBrandCell *selectBrandCell;
    CarBrandCell *selectModelCell;
    
    NSString *carModelName;
    NSString *carModelID;
    
    NSDictionary *_selectedBrand;
    NSDictionary *_selectedModel;
    
}

@property (nonatomic, retain) UITableView *carBrandTableView;
@property (nonatomic, retain) UITableView *carModelTableView;
@property (nonatomic, retain) UITableView *carDetailTableView;
@property (nonatomic, retain) NSMutableArray *sortedArrForArrays;
@property (nonatomic, retain) NSMutableArray *sectionHeadsKeys;
@property (nonatomic, assign) BOOL showNext;
@property (nonatomic, assign) CarType carType;


@end

@implementation ChooseCarViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"车型选择";
    brandClicked = [NSMutableDictionary dictionaryWithCapacity:1];
    modelClicked = [NSMutableDictionary dictionaryWithCapacity:1];
    
    //获取车型数据
    hotBrandArray = [[NSMutableArray alloc]init];
    brandArray = [[NSMutableArray alloc]init];
    modelArray = [[NSMutableArray alloc]init];
    detailArray = [[NSMutableArray alloc]init];
    
    self.sortedArrForArrays = [[NSMutableArray alloc] init];
    self.sectionHeadsKeys = [[NSMutableArray alloc] init];
    
    //获取本地json数据
    NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"car" ofType:@"json"]];
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    [brandArray addObjectsFromArray:jsonObject];
    [self sortArray:brandArray];
    
    //车型列表
    self.carBrandTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    self.carBrandTableView.delegate = self;
    self.carBrandTableView.dataSource = self;
    self.carBrandTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.carBrandTableView];
    [self hideFootView:self.carBrandTableView];

    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    }

- (void)hideFootView:(UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    tableView.tableFooterView = view;
}

#pragma mark ------按照首字母分组排序---------
- (void)sortArray:(NSMutableArray *)arr
{
    //按首字母拼音排列
    self.sortedArrForArrays = [self getChineseStringArr:arr];
    NSMutableArray *contentsArray = [[NSMutableArray alloc] init];
    
    [contentsArray addObject:hotBrandArray];
    [contentsArray addObjectsFromArray:self.sortedArrForArrays];
    self.sortedArrForArrays = contentsArray;
    
    NSMutableArray *keyArray = [[NSMutableArray alloc] init];
    [keyArray addObject:@"热门"];
    [keyArray addObjectsFromArray:self.sectionHeadsKeys];
    self.sectionHeadsKeys = keyArray;
}

- (NSMutableArray *)getChineseStringArr:(NSMutableArray *)arrToSort
{
    NSMutableArray *chineseStringsArray = [NSMutableArray array];
    for(int i = 0; i < [arrToSort count]; i++)
    {
        ChineseString *chineseString=[[ChineseString alloc]init];
        chineseString.string = [NSString stringWithString:[[arrToSort objectAtIndex:i] objectForKey:@"brandname"]];
        chineseString.stringID = [NSString stringWithFormat:@"%@",[[arrToSort objectAtIndex:i] objectForKey:@"brandid"]];
        chineseString.logo = [NSString stringWithString:[[arrToSort objectAtIndex:i] objectForKey:@"logo"]];
        chineseString.nextArray = [NSArray arrayWithArray:[[arrToSort objectAtIndex:i] objectForKey:@"model"]];
        
        if(chineseString.string==nil)
        {
            chineseString.string=@"";
        }
        
        if(![chineseString.string isEqualToString:@""])
        {
            //join the pinYin
            chineseString.pinYin = [[arrToSort objectAtIndex:i] objectForKey:@"tagname"];
        }
        else
        {
            chineseString.pinYin = @"";
        }
//        NSLog(@"chineseString:%@",chineseString.logo);
        [chineseStringsArray addObject:chineseString];
    }
    
    //sort the ChineseStringArr by pinYin
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYin" ascending:YES]];
    [chineseStringsArray sortUsingDescriptors:sortDescriptors];
    
    NSMutableArray *arrayForArrays = [NSMutableArray array];
    BOOL checkValueAtIndex= NO;  //flag to check
    NSMutableArray *TempArrForGrouping = nil;
    
    for(int index = 0; index < [chineseStringsArray count]; index++)
    {
        ChineseString *chineseStr = (ChineseString *)[chineseStringsArray objectAtIndex:index];
        NSMutableString *strchar= [NSMutableString stringWithString:chineseStr.pinYin];
        NSString *sr= [strchar substringToIndex:1];
        
        if(![self.sectionHeadsKeys containsObject:[sr uppercaseString]])
        {
            [self.sectionHeadsKeys addObject:[sr uppercaseString]];
            TempArrForGrouping = [[NSMutableArray alloc] init];
            checkValueAtIndex = NO;
        }
        if([self.sectionHeadsKeys containsObject:[sr uppercaseString]])
        {
            [TempArrForGrouping addObject:[chineseStringsArray objectAtIndex:index]];
            if(checkValueAtIndex == NO)
            {
                [arrayForArrays addObject:TempArrForGrouping];
                checkValueAtIndex = YES;
            }
        }
    }
    return arrayForArrays;
}


#pragma mark ------三级菜单列表--------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.carBrandTableView) {
        return [self.sortedArrForArrays count];
    }
    else return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.carBrandTableView) {
        if (section == 0)
        {
            return [hotBrandArray count];
        }
        else
        {
            return  [[self.sortedArrForArrays objectAtIndex:section] count];
        }
    }
    else if (tableView == self.carModelTableView)
    {
//        NSLog(@"carModel有row=%d",modelArray.count);
        return modelArray.count;
    }
    else return detailArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.carBrandTableView) {
        return 20;
    }
    else return 0;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == self.carBrandTableView) {
        return self.sectionHeadsKeys;
    }
    else return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300.0, 20.0)];
    customView.backgroundColor = [UIColor colorWithRed:238/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = [UIColor grayColor];
    headerLabel.highlightedTextColor = [UIColor whiteColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:14];
    headerLabel.frame = CGRectMake(15.0, 0.0, 300.0, 20.0);
    [customView addSubview:headerLabel];
    
    if (section == 0)
    {
        headerLabel.text = @"热门车款";
    }
    else
    {
        headerLabel.text = [self.sectionHeadsKeys objectAtIndex:section];
    }
    
    return customView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.carBrandTableView) {
        if ([[brandClicked objectForKey:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] isEqualToString:[NSString stringWithFormat:@"%d",changeHeight1]])
        {
            return [[brandClicked objectForKey:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] floatValue] + 54;
        }
        else
        {
            return 54;
        }
    }
    else if(tableView == self.carModelTableView)
    {
        if ([[modelClicked objectForKey:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] isEqualToString:[NSString stringWithFormat:@"%d",changeHeight2]])
        {
            return [[modelClicked objectForKey:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] floatValue] + 44;
        }
        else
        {
            return 44;
        }
    }
    else return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.carBrandTableView) {
        if(indexPath.section == 0)
        {
            static NSString *cellIdentifier = @"carBrandCell";
            CarBrandCell *carBrandCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if(!carBrandCell){
                carBrandCell = [[CarBrandCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                carBrandCell.frame = CGRectMake(0, 0, DEVICE_WIDTH, 54);
            }
            if (carBrandCell.haveShowNext == YES) {
                carBrandCell.frame = CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT - 54 - 44);
            }
            else
            {
                carBrandCell.frame = CGRectMake(0, 0, DEVICE_WIDTH, 54);
            }
            carBrandCell.backgroundColor = [UIColor whiteColor];
            carBrandCell.selectionStyle = UITableViewCellSelectionStyleGray;
            return carBrandCell;
        }
        else
        {
            NSArray *arr = [self.sortedArrForArrays objectAtIndex:indexPath.section];
            ChineseString *str = (ChineseString *) [arr objectAtIndex:indexPath.row];
            
            static NSString *cellIdentifier = @"carBrandCell";
            CarBrandCell *carBrandCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if(!carBrandCell){
                carBrandCell = [[CarBrandCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                carBrandCell.carLogoView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 2, 50, 50)];
                [carBrandCell addSubview:carBrandCell.carLogoView];
                carBrandCell.carBrandLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 2, DEVICE_WIDTH - 80, 50)];
                carBrandCell.carBrandLabel.backgroundColor = [UIColor clearColor];
                carBrandCell.carBrandLabel.textAlignment = NSTextAlignmentLeft;
                carBrandCell.carBrandLabel.textColor = [UIColor blackColor];
                carBrandCell.carBrandLabel.font = [UIFont systemFontOfSize:18];
                [carBrandCell addSubview:carBrandCell.carBrandLabel];
            }
            
            if (selectBrandCell.haveShowNext) {
                if (self.carModelTableView) {
                    [self.carModelTableView removeFromSuperview];
                    self.carModelTableView = nil;
                }
                self.carModelTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 54, DEVICE_WIDTH, changeHeight1) style:UITableViewStylePlain];
                self.carModelTableView.delegate = self;
                self.carModelTableView.dataSource = self;
                self.carModelTableView.backgroundColor = [UIColor whiteColor];
                [self hideFootView:self.carModelTableView];
                
                self.carModelTableView.layer.borderWidth = 1;
                self.carModelTableView.layer.borderColor = [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1].CGColor;
                
                //                self.carModelTableView.frame = CGRectMake(0, 54, DEVICE_WIDTH, changeHeight1);
                [carBrandCell addSubview:self.carModelTableView];
            }
            
            carBrandCell.selectionStyle = UITableViewCellSelectionStyleGray;
            carBrandCell.backgroundColor = [UIColor whiteColor];
            [carBrandCell initWithCarLogo:str.logo CarBrand:str.string From:@"brand"];
            selectBrandCell.haveShowNext = NO;
            return carBrandCell;
        }
    }
    else if (tableView == self.carModelTableView)
    {
        static NSString *cellIdentifier = @"carModelCell";
        CarBrandCell *carModelCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!carModelCell){
            carModelCell = [[CarBrandCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
            carModelCell.carBrandLabel = [[UILabel alloc] initWithFrame:CGRectMake(30+35, 2, DEVICE_WIDTH - 80, 40)];
            carModelCell.carBrandLabel.backgroundColor = [UIColor clearColor];
            carModelCell.carBrandLabel.textAlignment = NSTextAlignmentLeft;
            carModelCell.carBrandLabel.textColor = [UIColor darkGrayColor];
            carModelCell.carBrandLabel.font = [UIFont systemFontOfSize:17];
            [carModelCell addSubview:carModelCell.carBrandLabel];
        }
        if (selectModelCell.haveShowNext) {
            if (self.carDetailTableView) {
                [self.carDetailTableView removeFromSuperview];
                self.carDetailTableView = nil;
            }
            self.carDetailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, DEVICE_WIDTH, changeHeight2) style:UITableViewStylePlain];
            self.carDetailTableView.delegate = self;
            self.carDetailTableView.dataSource = self;
            self.carDetailTableView.backgroundColor = [UIColor whiteColor];
            [self hideFootView:self.carDetailTableView];
            
            self.carDetailTableView.layer.borderWidth = 1;
            self.carDetailTableView.layer.borderColor = [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1].CGColor;
            
            //            self.carDetailTableView.frame = CGRectMake(0, 44, DEVICE_WIDTH, changeHeight2);
            [carModelCell addSubview:self.carDetailTableView];
        }
        
        carModelCell.selectionStyle = UITableViewCellSelectionStyleGray;
        [carModelCell initWithCarLogo:nil CarBrand:[[modelArray objectAtIndex:indexPath.row] stringForKey:@"modelname"] From:@"model"];
        selectModelCell.haveShowNext = NO;
        carModelCell.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
        return carModelCell;
    }
    else {
        static NSString *cellIdentifier = @"carDetailCell";
        CarBrandCell *carDetailCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!carDetailCell){
            carDetailCell = [[CarBrandCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
            carDetailCell.carBrandLabel = [[UILabel alloc] initWithFrame:CGRectMake(30+50, 2, DEVICE_WIDTH - 100, 40)]; //缩进
            carDetailCell.carBrandLabel.backgroundColor = [UIColor clearColor];
            carDetailCell.carBrandLabel.textAlignment = NSTextAlignmentLeft;
            carDetailCell.carBrandLabel.textColor = [UIColor darkGrayColor];
            carDetailCell.carBrandLabel.font = [UIFont systemFontOfSize:16];
            [carDetailCell addSubview:carDetailCell.carBrandLabel];
        }
        
        carDetailCell.selectionStyle = UITableViewCellSelectionStyleGray;
        [carDetailCell initWithCarLogo:nil CarBrand:[[detailArray objectAtIndex:indexPath.row] stringForKey:@"detailname"] From:@"detail"];
        carDetailCell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        return carDetailCell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CarBrandCell *cell = (CarBrandCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (cell != selectBrandCell) {
        selectBrandCell = cell;
        selectModelCell = cell;
        changeHeight1 = 54;
        changeHeight2 = 44;
    }
    
    if (tableView == self.carBrandTableView) {
        [brandClicked removeAllObjects];
        NSArray *arr = [self.sortedArrForArrays objectAtIndex:indexPath.section];
        ChineseString *str = (ChineseString *)[arr objectAtIndex:indexPath.row];
        if (cell.frame.size.height == 54){
            self.carBrandTableView.scrollEnabled = NO;
            self.carBrandTableView.frame = CGRectMake(0, 0, DEVICE_WIDTH + 60, DEVICE_HEIGHT);
            if (modelArray.count>0) {
                [modelArray removeAllObjects];
            }
            [modelArray addObjectsFromArray:str.nextArray];
            [modelArray insertObject:@{@"modelname": @"不限"} atIndex:0];
            
            //保存车品牌
            if (self.carType == WantCar) {
                [[GlobalTool sharedTool].exchangeDic setObject:str.string forKey:@"wantbrandname"];
                [[GlobalTool sharedTool].exchangeDic setObject:str.stringID forKey:@"wantbrandid"];
            }
            else if (self.carType == ChangeCar)
            {
                [[GlobalTool sharedTool].userInfoDic setObject:str.string forKey:@"brandname"];
                [[GlobalTool sharedTool].userInfoDic setObject:str.stringID forKey:@"brandid"];
            }
            else
            {
                [[GlobalTool sharedTool].exchangeDic setObject:str.string forKey:@"brandname"];
                [[GlobalTool sharedTool].exchangeDic setObject:str.stringID forKey:@"brandid"];
            }
            _selectedBrand  = @{@"brandname":str.string,@"brandid":str.stringID};
//            NSLog(@"id:%@,name:%@",str.stringID,str.string);
            changeHeight1 = DEVICE_HEIGHT - 84 - 54;
            [brandClicked setObject:[NSString stringWithFormat:@"%d",changeHeight1] forKey:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
            
            selectBrandCell.haveShowNext = YES;
            [UIView animateWithDuration:0 animations:^{
                [self.carBrandTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationFade];
            } completion:^(BOOL finished) {
                [self.carModelTableView reloadData];
            }];
            
            [self.carBrandTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
        else
        {
            self.carBrandTableView.scrollEnabled = YES;
            self.carBrandTableView.frame = CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT );
            [brandClicked removeObjectForKey:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
            selectBrandCell.haveShowNext = NO;
            [self.carBrandTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:(indexPath.row) inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
    else if (tableView == self.carModelTableView)
    {
        if (detailArray.count>0) {
            [detailArray removeAllObjects];
        }
        
        if (indexPath.row == 0) {
            if (self.carType == WantCar) {
                [[GlobalTool sharedTool].exchangeDic setObject:@"" forKey:@"wantmodelname"];
                [[GlobalTool sharedTool].exchangeDic setObject:@"" forKey:@"wantmodelid"];
                [[GlobalTool sharedTool].exchangeDic setObject:@"" forKey:@"wantdetailname"];
                [[GlobalTool sharedTool].exchangeDic setObject:@"" forKey:@"wantdetailid"];
                [self.navigationController popViewControllerAnimated:YES];
            }
            else if (self.carType == ChangeCar)
            {
                [[GlobalTool sharedTool].userInfoDic setObject:@"" forKey:@"modelname"];
                [[GlobalTool sharedTool].userInfoDic setObject:@"" forKey:@"modelid"];
                [[GlobalTool sharedTool].userInfoDic setObject:@"" forKey:@"detailname"];
                [[GlobalTool sharedTool].userInfoDic setObject:@"" forKey:@"detailid"];
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                [[GlobalTool sharedTool].exchangeDic setObject:@"" forKey:@"modelname"];
                [[GlobalTool sharedTool].exchangeDic setObject:@"" forKey:@"modelid"];
                [[GlobalTool sharedTool].exchangeDic setObject:@"" forKey:@"detailname"];
                [[GlobalTool sharedTool].exchangeDic setObject:@"" forKey:@"detailid"];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        else
        {
            [detailArray addObjectsFromArray:[[modelArray objectAtIndex:indexPath.row] arrayForKey:@"car"]];
            [detailArray insertObject:@{@"detailname": @"不限"} atIndex:0];
            
            //保存车型
            if (self.carType == WantCar) {
                [[GlobalTool sharedTool].exchangeDic setObject:[[modelArray objectAtIndex:indexPath.row] stringForKey:@"modelname"] forKey:@"wantmodelname"];
                [[GlobalTool sharedTool].exchangeDic setObject:[[modelArray objectAtIndex:indexPath.row] stringForKey:@"modelid"] forKey:@"wantmodelid"];
                [[GlobalTool sharedTool].exchangeDic setObject:[[modelArray objectAtIndex:indexPath.row] stringForKey:@"image"] forKey:@"wantmodelimage"];
            }
            else if (self.carType == ChangeCar)
            {
                [[GlobalTool sharedTool].userInfoDic setObject:[[modelArray objectAtIndex:indexPath.row] stringForKey:@"modelname"] forKey:@"modelname"];
                [[GlobalTool sharedTool].userInfoDic setObject:[[modelArray objectAtIndex:indexPath.row] stringForKey:@"modelid"] forKey:@"modelid"];
            }
            else
            {
                [[GlobalTool sharedTool].exchangeDic setObject:[[modelArray objectAtIndex:indexPath.row] stringForKey:@"modelname"] forKey:@"modelname"];
                [[GlobalTool sharedTool].exchangeDic setObject:[[modelArray objectAtIndex:indexPath.row] stringForKey:@"modelid"] forKey:@"modelid"];
            }
            _selectedModel = modelArray[indexPath.row];
//            NSLog(@"modelname:%@--- modelid:%@",[[modelArray objectAtIndex:indexPath.row] stringForKey:@"modelname"],[[modelArray objectAtIndex:indexPath.row] stringForKey:@"modelid"]);
            if (cell.frame.size.height == 44){
                self.carModelTableView.scrollEnabled = NO;
                changeHeight2 = DEVICE_HEIGHT - 84 - 54 - 44;
                [modelClicked setObject:[NSString stringWithFormat:@"%d",changeHeight2] forKey:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
                
                selectModelCell.haveShowNext = YES;
                [UIView animateWithDuration:0 animations:^{
                    [self.carModelTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationFade];
                } completion:^(BOOL finished) {
                    [self.carDetailTableView reloadData];
                }];
                
                [self.carModelTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }
            else{
                self.carModelTableView.scrollEnabled = YES;
                [modelClicked removeObjectForKey:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
                selectModelCell.haveShowNext = NO;
                [self.carModelTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:(indexPath.row) inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationFade];
            }
        }
    }
    else
    {
        if (indexPath.row == 0) {
            if (self.carType == WantCar) {
                [[GlobalTool sharedTool].exchangeDic setObject:@"" forKey:@"wantdetailname"];
                [[GlobalTool sharedTool].exchangeDic setObject:@"" forKey:@"wantdetailid"];
                [self.navigationController popViewControllerAnimated:YES];
            }
            else if (self.carType == ChangeCar)
            {
                [[GlobalTool sharedTool].userInfoDic setObject:@"" forKey:@"detailname"];
                [[GlobalTool sharedTool].userInfoDic setObject:@"" forKey:@"detailid"];
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                [[GlobalTool sharedTool].exchangeDic setObject:@"" forKey:@"detailname"];
                [[GlobalTool sharedTool].exchangeDic setObject:@"" forKey:@"detailid"];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        else
        {
            if (self.carType == WantCar) {
                [[GlobalTool sharedTool].exchangeDic setObject:[[detailArray objectAtIndex:indexPath.row] stringForKey:@"detailname"] forKey:@"wantdetailname"];
                [[GlobalTool sharedTool].exchangeDic setObject:[[detailArray objectAtIndex:indexPath.row] stringForKey:@"detailid"] forKey:@"wantdetailid"];
            }
            else if (self.carType == ChangeCar)
            {
                [[GlobalTool sharedTool].userInfoDic setObject:[[detailArray objectAtIndex:indexPath.row] stringForKey:@"detailname"] forKey:@"detailname"];
                [[GlobalTool sharedTool].userInfoDic setObject:[[detailArray objectAtIndex:indexPath.row] stringForKey:@"detailid"] forKey:@"detailid"];
            }
            else
            {
                [[GlobalTool sharedTool].exchangeDic setObject:[[detailArray objectAtIndex:indexPath.row] stringForKey:@"detailname"] forKey:@"detailname"];
                [[GlobalTool sharedTool].exchangeDic setObject:[[detailArray objectAtIndex:indexPath.row] stringForKey:@"detailid"] forKey:@"detailid"];
            }
            
//             NSLog(@"detailname:%@ -- detailid:%@",[[detailArray objectAtIndex:indexPath.row] stringForKey:@"detailname"],[[detailArray objectAtIndex:indexPath.row] stringForKey:@"detailid"]);
            if (self.chooseCallBack) {
                self.chooseCallBack(_selectedBrand,_selectedModel,detailArray[indexPath.row]);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
    
   
    
    
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
