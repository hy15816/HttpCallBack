//
//  BaseTableViewController.h
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/1/26.
//  Copyright © 2016年 yim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewController : UITableViewController

- (void)refreshHeader;
- (void)refreshFooter;
- (void)endHeaderRefresh;
- (void)endFooterRefresh;
- (void)addRightItemWithTitle:(NSString *)title;
- (void)rightBarButtonItemClick:(UIBarButtonItem *)item;
@end
