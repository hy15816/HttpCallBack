//
//  TestTableViewController.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 15/12/31.
//  Copyright © 2015年 yim. All rights reserved.
//

#import "TestChatTableViewController.h"
#import "TestCell.h"
#import "TabBarViewController.h"

@interface TestChatTableViewController ()

@property (strong,nonatomic) NSMutableArray *dataSource;
@end

@implementation TestChatTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NNLog(@"");
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"🐱" style:UIBarButtonItemStylePlain target:self action:@selector(gotabbar)];
    
}

- (void)gotabbar {
    
    TabBarViewController *tabbar = [[TabBarViewController alloc] init];
    [self.navigationController pushViewController:tabbar animated:YES];
    
}

- (void)deviceOrientationDidChange:(NSNotification *)notify {
    /*
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    BOOL willReloadData = NO;
    switch (orientation) {
        case UIDeviceOrientationPortrait:            // Device oriented vertically, home button on the bottom
            NNLog(@"home button on the bottom");
            break;
        case UIDeviceOrientationPortraitUpsideDown:  // Device oriented vertically, home button on the top
            NNLog(@"home button on the top");
            break;
        case UIDeviceOrientationLandscapeLeft:      // Device oriented horizontally, home button on the right
            [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
            willReloadData = YES;
            NNLog(@"home button on the right");
            break;
        case UIDeviceOrientationLandscapeRight:      // Device oriented horizontally, home button on the left
            [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft animated:YES];
            willReloadData = YES;
            NNLog(@"home button on the left");
            break;
        default:
            break;
    }
     */
    //if (willReloadData) {
        
        [_dataSource removeAllObjects];
        _dataSource = nil;
        [self.tableView reloadData];
    //}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TestCell *cell = [TestCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.testModel = self.dataSource[indexPath.row];
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TestModel *model = self.dataSource[indexPath.row];
    NSLog(@"heightForRowAtIndexPath.rwo:%ld--H:%f",(long)indexPath.row,model.cellHeight);
    return model.cellHeight;
    
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

//-(NSMutableArray *)dataSource {
//    
//    if (_dataSource == nil) {
//        _dataSource = [[NSMutableArray alloc] init];
//        for (int i=0; i<100; i++) {
//            TestModel *model = [TestModel model];
//            [_dataSource addObject:model];
//        }
//    }
//    return _dataSource;
//}

-(NSMutableArray *)dataSource {
    
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
        for (int i=0; i<30; i++) {
            
            int radmonNumber = arc4random_uniform(3);
            NSString *detail = @"aaaaaaaaaaa";
            NSString *imageName = @"userinfo_vc_top";
            if (radmonNumber == 1) {
                detail = @"Current pollution levels in Beijing are actually lower than last week's, but the red alert has been placed because of levels expected over the coming days.The order will last from 07:00 local time on Tuesday (23:00 GMT on Monday) until 12:00 on Thursday, when a cold front is expected to arrive and clear the smog.";
                //baseHeight = 0;
            }else if(radmonNumber == 2) {
                detail = @"/Applications/Xcode5.0/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang++ -arch armv7 -isysroot /Applications/Xcode5.0/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS7.0.sdk -L/Users/JunJie/Library/Developer/Xcode/DerivedData/TianJinEcoCity-aisnqbxpzmfiuveydfblxinyzebm/Build/Products/Debug-iphoneos -L/Users/JunJie/Downloads/02.城市App/TableDemo/VideoPlaySDK -L/Users/JunJie/Downloads/02.城市App/TableDemo/ZBarSDK -F/Users/JunJie/Library/Developer/";
            }
            TestModel *testModel = [TestModel modelWithTitle:[NSString stringWithFormat:@"%d",arc4random()%1000000] detail:detail imageName:imageName];
            
            [_dataSource addObject:testModel];
        }
    }
    return _dataSource;
}




@end
