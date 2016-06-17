//
//  BLETableViewController.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/3/5.
//  Copyright © 2016年 yim. All rights reserved.
//
/**
 *  // 初始化方法-参数-delegate-可以放到多线程里面去创建做更多的事情-queue
 - (id)initWithDelegate:(id<CBCentralManagerDelegate>)delegate queue:(dispatch_queue_t)queue;
 //初始化方法-参数-options指定这个manager
 - (id)initWithDelegate:(id<CBCentralManagerDelegate>)delegate queue:(dispatch_queue_t)queue options:(NSDictionary *)options
 //检索外围设备通过传入一个UUID数组
 - (void)retrievePeripherals:(NSArray *)peripheralUUIDs
 //检索外围设备通过传入一个identifiers数组
 - (NSArray *)retrievePeripheralsWithIdentifiers:(NSArray*)identifiers
 // 检索已连接的外围设备
 - (void)retrieveConnectedPeripherals
 //通过服务的UUID数组返回已经连接的服务数组
 - (NSArray *)retrieveConnectedPeripheralsWithServices:(NSArray*)serviceUUIDs
 // serviceUUIDs是一个CBUUID数组，如果serviceUUIDs是nil为空的话所有的被发现的peripheral将要被返回
 - (void)scanForPeripheralsWithServices:(NSArray *)serviceUUIDs options:(NSDictionary *)options
 // 停止扫描
 - (void)stopScan
 //通过options指定的选项去连接peripheral
 - (void)connectPeripheral:(CBPeripheral *)peripheral options:(NSDictionary *)options
 //取消一个活跃的或者等待连接的peripheral的连接
 - (void)cancelPeripheralConnection:(CBPeripheral *)peripheral
 *
 *
 */

#import "BLETableViewController.h"
#import "BLETableCell.h"
#import "BLETableSec0Cell.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "GlobalTool.h"
#import "AppDelegate.h"

static int scanCount = 0;

@interface BLETableViewController ()<CBCentralManagerDelegate,CBPeripheralDelegate>

{
    NSMutableArray *_ListArray;
    NSString *_currentTimeString;
    NSString *_cString;
    NSString *_sString;
    NSString *_cpString;    //车牌
    NSString *_cpidString;  //车牌id
    
    int _isReceiveFirstBackCount;
    int _isReceiveSecondBackCount;
}

@property (strong,nonatomic) CBCentralManager *centralManager;
@property (strong,nonatomic) CBPeripheral *peripheral;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation BLETableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    _sString=@"<6e400001 b5a3f393 e0a9e50e 24dcca9e>";
    _cString=@"<6e400002 b5a3f393 e0a9e50e 24dcca9e>";
    
    _currentTimeString = [[NSString alloc] init];
    _ListArray = [[NSMutableArray alloc] init];
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
   
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ScanAction) name:kNotifityNameScanAction object:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"扫描" style:UIBarButtonItemStylePlain target:self action:@selector(ScanAction)];
    
}



- (void)ScanAction {
    
    NSLog(@"................scan action");
    [_ListArray removeAllObjects];
    
//    _currentTimeString = [GlobalTool stringWithFormat:@"yyyy-M-d HH:mm:ss"];
//    CBUUID *cbuuid = [CBUUID UUIDWithString:@"6E400001-B5A3-F393-E0A9-E50E24DCCA9E"];
//    [self.centralManager scanForPeripheralsWithServices:@[cbuuid] options:nil];
    
    [self startScanningWithManager:self.centralManager];
    [SVProgressHUD showWithStatus:@""];
}
// 按UUID进行扫描
-(void)startScanningWithManager:(CBCentralManager *)manager{
    NSArray *uuidArray = [NSArray arrayWithObjects:[CBUUID UUIDWithString:@"6E400001-B5A3-F393-E0A9-E50E24DCCA9E"], nil];
    // CBCentralManagerScanOptionAllowDuplicatesKey | CBConnectPeripheralOptionNotifyOnConnectionKey | CBConnectPeripheralOptionNotifyOnDisconnectionKey | CBConnectPeripheralOptionNotifyOnNotificationKey
    NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:CBCentralManagerScanOptionAllowDuplicatesKey];
    [manager scanForPeripheralsWithServices:uuidArray options:options];
}

#pragma mark - CBCentralManagerDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
    NSLog(@"state:%ld",(long)central.state);
    
}
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    
}
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    
    NSLog(@"连接成功！！！！！！！！！");
    [central stopScan];
    [peripheral readRSSI];
    
    self.peripheral.delegate = self;
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                      target:self
                                                    selector:@selector(readRSSI)
                                                    userInfo:nil
                                                     repeats:1.0];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    }
    
    peripheral.delegate = self;
    [peripheral discoverServices:nil];
}

- (void)readRSSI
{
    NSLog(@"");
    if (self.peripheral) {
        [self.peripheral readRSSI];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didReadRSSI:(NSNumber *)RSSI error:(NSError *)error {
    
    NSLog(@"[peripheral:didReadRSSI:%@ error:%@]",RSSI,error);
    
}
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    
}
//central提供信息，dict包含了应用程序关闭时系统保存的central的信息，用dic去恢复central
//app状态的保存或者恢复，这是第一个被调用的方法当APP进入后台去完成一些蓝牙有关的工作设置，使用这个方法同步app状态通过蓝牙系统
- (void)centralManager:(CBCentralManager *)central willRestoreState:(NSDictionary<NSString *,id> *)dict {
    
}
- (void)centralManager:(CBCentralManager *)central didRetrieveConnectedPeripherals:(NSArray *)peripherals {
    
    NSLog(@"[centralManager:didRetrieveConnectedPeripherals:] --peripherals == %@ ",peripherals);
}
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI {
    
    [SVProgressHUD dismiss];
    NSLog(@"peripheral:%@--%@--RSSI:%@",peripheral,advertisementData,RSSI);
    scanCount ++ ;
    NSLog(@"scanCount:%d",scanCount);

    
    
    if (![_ListArray containsObject:peripheral]) {
        [_ListArray addObject:peripheral];
    }
    
    [self.tableView reloadData];
    
    NSString * kCBAdvDataLocalNameString =[NSString stringWithFormat:@"%@",[advertisementData  objectForKey:@"kCBAdvDataLocalName"]];
//    NSLog(@"bleObj.m, centralManager,didDiscoverPeripheral]: kCBAdvDataLocalNameString:%@ ",kCBAdvDataLocalNameString);
    if(kCBAdvDataLocalNameString.length < 9) {
        NSLog(@"bleObj.m, didDiscoverPeripheral: kCBAdvDataLocalNameString < 9, %@ ",kCBAdvDataLocalNameString);
        
    }else{
        
        NSDictionary *dict= @{@"License_plate_id":@"00014948", @"License_plate_number":@"粤1234EE"};
        NSString* nsLocalCarNum=[NSString stringWithFormat:@"TAS%@", @"1234EE"];//取出车牌
        NSString* nsAdvCarNum=[NSString stringWithFormat:@"%@", [kCBAdvDataLocalNameString substringToIndex:9]]; //扫描的车牌TASXXXXXX
        NSLog(@"nsLocalCarNum:%@,,,nsAdvCarNum:%@",nsLocalCarNum,nsAdvCarNum);
        if([self rc:nsLocalCarNum scanCp:nsAdvCarNum]){
            
            _cpString = [dict valueForKey:@"License_plate_number"];//获取车牌
            _cpidString = [dict valueForKey:@"License_plate_id"];//车牌id
            NSLog(@"将要连接的车牌：%@，id：%@",_cpString,_cpidString);
            self.peripheral = peripheral;
            peripheral.delegate = self;
            [_centralManager  connectPeripheral:peripheral options:nil];
        }
        
    }

    
}


#pragma mark - CBPeripheralDelegate
#pragma mark - 服务回调
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    if (!error) {
        NSLog(@"服务回调 peripheral.services.count=%lu", (unsigned long)peripheral.services.count);
        for (CBService *s in peripheral.services){
            NSString *sveString = [NSString stringWithFormat:@"%s",[self CBUUIDToString:s.UUID]];
            if ([sveString isEqual:_sString]) {
                NSLog(@"bleObj.m, didDiscoverServices, 开始发现服务：%@",s.UUID);
                [peripheral discoverCharacteristics:nil forService:s];
                
            }
            
        }
    }else {
        NSLog(@" 服务发现不成功 ");
    }
}

-(const char *) CBUUIDToString:(CBUUID *) UUID {
    return [[UUID.data description] cStringUsingEncoding:NSStringEncodingConversionAllowLossy];
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    NSLog(@"bleObj.m, 特征回调 service:%s err.code:%ld",[self CBUUIDToString:service.UUID],(long)error.code);
    if (!error) {
        //NSLog(@"bleObj.m, 特征回调 service:%s",[self CBUUIDToString:service.UUID]);
        BOOL isSet = YES;
        for(int i=0;i<service.characteristics.count;i++) {
            
            CBCharacteristic *c=[service.characteristics objectAtIndex:i];
            NSString *ss=[NSString stringWithFormat:@"%s",[self CBUUIDToString:c.UUID]];
            if ([ss isEqualToString:_cString]) {
                NSLog(@"发现特征：%@",ss);
                
                _isReceiveFirstBackCount = 0;
                [self send_first:peripheral characteristic:c];
                
            }
            if (isSet) {
                isSet = NO;
                [peripheral setNotifyValue:YES forCharacteristic:c];
            }
            
        }
    }else{
        NSLog(@"特征发现不成功");
        
    }
    
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    
    UInt8 xval[20];
    NSInteger getlenth=[characteristic.value length];
    [characteristic.value getBytes:&xval length:getlenth];
    
    NSMutableString *string=[NSMutableString string];
    for(int i=0; i<getlenth; i++) [string appendFormat:@"%02x",xval[i]];//<800e1241 38373446 41000000 00518000 30>
    
    //NSLog(@"bleObj.m, string: %@",string);
    NSLog(@"bleObj.m, data  : %@", characteristic.value);
//    NSString *s = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
//    NSLog(@"bleObj.m, string: %@", s);
    
    if (string.length < 4 ) {
        NSLog(@"bleObj.m,非法消息");
        return;
    }
    //车闸4f4b正确回调   错误 4552524f52  4e554c4c空车牌
    if ([[string substringToIndex:4] isEqualToString:@"4f4b"] ) { //OK
        //发送第二条指令
        _isReceiveFirstBackCount ++;
        if (_isReceiveFirstBackCount == 3) {
            [self sends_two:peripheral characteristic:characteristic];
            _isReceiveSecondBackCount = 0;
        }
        
    } else if([string isEqual:@"4e554c4c"]  )
    {   // NULL
        NSLog(@"bleObj.m,ble 返回 NULL");
        
    }else if ([string isEqual:@"4552524f52"]){// ERROR
        
        NSLog(@"bleObj.m,bel 返回 ERROR");
    } else if ([string isEqual:@"54494d454f4b"] ){
        _isReceiveFirstBackCount ++;
        if (_isReceiveFirstBackCount == 3 ) {
            _isReceiveFirstBackCount = 0;
            NSLog(@"bleObj.m, uptate value err: 54494d454f4b　ｔｉｍｅｏｋ ");
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showSuccessWithStatus:@"开闸成功"];
            });
        }
        
        
    }else if ([string isEqualToString:@"45525220434d44"]){
        //ERR CMD
        NSLog(@"bleObj.m, uptate value err: ERR　ＣＭＤ");
    } else {
        NSLog(@"bleObj.m, didUpdateValueForCharacteristic else");
        
        _isReceiveFirstBackCount = 0;
        [self send_first:peripheral characteristic:characteristic];
    }

    
}


-(void)send_first:(CBPeripheral *)peripheral characteristic:(CBCharacteristic *) characteristic{
    
    //如果断线，先重连
    
    //NSString *carNumIdString = [m_currentCarDic valueForKey:@"License_plate_id"];//获取id;
    
    NSData *d =[self byte2:_cpString carNumId2:_cpidString];
    //NSData *d=[self getData:cpString carId:cpidString];
    NSLog(@"bleObj.m,first sends: bytes=%@ ",d);
    [peripheral writeValue:d forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
}

-(void)sends_two:(CBPeripheral *)peripheral characteristic:(CBCharacteristic *) characteristic{
    
    Byte sends[17];
    for (int i=0; i<17; i++) {
        sends[i] = 0;
    }
    sends[0] = 0x92;
    sends[1] = 0x0e;
    for (int k=2; k<16; k++) {
        sends[k] = 0xff;
    }
    
    for (int j= 0;  j<16; j++) {
        sends[16] =  sends[16]^sends[j];
    }
    NSData *data = [NSData dataWithBytes:&sends length:sizeof(sends)];

    NSLog(@"sends two data:%@",data);
    peripheral.delegate = self;
    [peripheral writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
}


//2015-11-18，修改，若车牌末字是汉字（需处理）
-(NSData *)byte2:(NSString *)carNum carNumId2:(NSString *)numId{
    //
    //NSLog(@"carNum:%@---carNumId:%@",carNum,numId);
    
    
    NSMutableArray *allArray = [[NSMutableArray alloc]init];
    NSMutableArray *carArray = [[NSMutableArray alloc]init];
    
    [allArray addObject:@"128"];
    [allArray addObject:@"14"];
    NSString *lastStr = [[NSString alloc] init];
    for (int i =0; i<carNum.length; i++) {
        NSString *str =[carNum substringWithRange:NSMakeRange(i, 1)];
        //判断是否汉字，汉字特殊处理 如：粤S12345警，粤Z65B2港，等车牌
        if ([self isHanzi:[str characterAtIndex:0]] && i == carNum.length-1) {//是汉字 && 车牌最后一个字
            //
            lastStr = str;
            break;
        }
        [carArray addObject:str];
    }
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"shengfen" ofType:@"plist"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSString *str1 = [dic objectForKey:carArray[0]];//车牌首字，
    //arr[0] = str1;
    [allArray addObject:str1];//前3位(包括了车牌的前1位) 128 14 20
    
    // 小写转大写
    for ( int i=1; i<carArray.count; i++) {
        Byte by[1];
        unichar cc = [carArray[i] characterAtIndex:0];
        by[0] = cc;
        NSString *str =[NSString stringWithFormat:@"%d",by[0]];
        if (str.intValue >=97) {
            NSString *str2 =carArray[i];
            carArray[i] = str2.uppercaseString;
        }
    }
    //判断
    if (lastStr.length) {//第二种情况，最后一字是汉字，
        for (int i = 1; i<carArray.count; i++) {
            Byte by[1];
            unichar cc = [carArray[i] characterAtIndex:0];
            by[0] = cc;
            NSString *str =[NSString stringWithFormat:@"%d",by[0]];
            [allArray addObject:str];
        }
        //加上最后一个汉字，先转成代号，
        NSString *lastStrNumber = [dic objectForKey:lastStr];
        [allArray addObject:lastStrNumber];
    }else{
        //除去第一位后的所有车牌（最后没有汉字）
        for (int i = 1; i<carArray.count; i++) {
            Byte by[1];
            unichar cc = [carArray[i] characterAtIndex:0];
            by[0] = cc;
            NSString *str =[NSString stringWithFormat:@"%d",by[0]];
            [allArray addObject:str];
        }
    }
    
    //NSMutableArray *array = [[NSMutableArray alloc]init];
    //处理车牌ID 6位，不够补0
    NSString *phone1;
    if (numId.length <12) {
        NSString *string = @"";
        for (int i=0; i<12-numId.length; i++) {
            string  = [NSString stringWithFormat:@"%@%@",string,@"0"];
        }
        phone1 =[NSString stringWithFormat:@"%@%@",string,numId];
    }else{
        phone1 = [numId substringWithRange:NSMakeRange(numId.length - 12, 12)];
    }
    
    //
    for (int i =0; i<6; i++) {
        NSString *str = [phone1 substringWithRange:NSMakeRange(i*2, 2)];
        //        [array addObject:str];
        NSString *str1 = [NSString stringWithFormat:@"%lu",strtoul([str UTF8String], 0, 16)];
        [allArray addObject:str1];
    }
    
    [allArray addObject:carNum];
    NSLog(@"allArray:%@",allArray);
    
    Byte byte[17];
    for (int i = 0; i<16; i++) {
        NSString *str = [NSString stringWithFormat:@"%@",allArray[i]];
        byte[i] = str.intValue;
    }
    //授权号(默认01)，
    byte[15] = 01;//20151105修改,只有一种开闸方式，自动
    
    //NSLog(@"--Auto:------------------%d",[autoOpen intValue]);
    byte[16] =0;
    for(int i= 0;  i<16; i++) byte[16] =  byte[16]^byte[i];
    
    NSData *d=[NSData dataWithBytes:&byte length:17];
    return d;
}

-(BOOL)isHanzi:(unichar)c{
    if (c>=0x4E00 && c<=0x9FA5) {
        return YES;
    }
    return NO;
}

#pragma mark -容错判断
-(BOOL)rc:(NSString *)selfCp scanCp:(NSString *)scanCp{
    BOOL flag;
    int count = 0;
    NSMutableArray *arr1 = [[NSMutableArray alloc]init];
    NSMutableArray *arr2 = [[NSMutableArray alloc]init];
    
    for (int i=0; i<9; i++) {
        NSString *str1 = [selfCp substringWithRange:NSMakeRange(i, 1)];
        NSString *str2 = [scanCp substringWithRange:NSMakeRange(i, 1)];
        [arr1 addObject:str1];
        [arr2 addObject:str2];
    }
    for (int i=0; i<9; i++) {
        if ([arr1[i] isEqual:arr2[i]]) {
            count++;
        }
    }
    if(count>=7){
        flag = YES;
        return flag;
    }else{
        flag = NO;
        return flag;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 1;
    }
    return _ListArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        static NSString *cellidf = @"cell11idf";
        BLETableSec0Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellidf];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BLETableSec0Cell" owner:self options:nil] lastObject];
        }
        cell.startTimeLabel.text = [NSString stringWithFormat:@"开始时间：%@",_currentTimeString];
        cell.canCountLabel.text = [NSString stringWithFormat:@"设备个数：%lu",(unsigned long)_ListArray.count];
        return cell;
    }
    if (indexPath.section == 1) {
        
        BLETableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bleCellID" forIndexPath:indexPath];
        cell.peripheral = _ListArray[indexPath.row];
        return cell;
    }
    
    return nil;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
