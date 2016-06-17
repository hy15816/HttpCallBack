//
//  ConsultationsViewController.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/3/11.
//  Copyright © 2016年 yim. All rights reserved.
//

#import "ConsultationsViewController.h"
#import "ConsultationsCell.h"


@interface ConsultationsViewController ()

@property (strong,nonatomic) NSMutableArray *list;
@end

@implementation ConsultationsViewController

#warning 未完成<布局。。。。。。2种方式>
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ConsultationsCell *cell = [ConsultationsCell cellWithTableView:tableView nibName:@"ConsultationsCell"];
    cell.consultationsModel = self.list[indexPath.row];
    
    return cell;
}


- (NSMutableArray *)list {
    if (_list == nil) {
        _list = [[NSMutableArray alloc] init];
        for (int i=0; i<20; i++) {
            ConsultationsModel *model = [[ConsultationsModel alloc] init];
            model.content = [NSString stringWithFormat:@"     cell --- %d",i];
            model.userName = @"user--name";
            [_list addObject:model];
        }
    }
    
    return _list;
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
