//
//  TestCell.h
//  HttpCallBack
//
//  Created by AEF-RD-1 on 15/12/31.
//  Copyright © 2015年 yim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestModel.h"

@interface TestCell : UITableViewCell

@property (strong,nonatomic) TestModel *testModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (assign,nonatomic) CGFloat testCellHeight;

@end
