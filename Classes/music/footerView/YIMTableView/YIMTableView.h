//
//  YIMTableView.h
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/1/22.
//  Copyright © 2016年 yim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YIMTableView;
@protocol YIMTableViewDelegate <NSObject>

- (void)yimTableView:(YIMTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface YIMTableView : UIView

+ (instancetype)tableViewWithFrame:(CGRect)frame dataArray:(NSMutableArray *)dataArray;

/**
 *  数据源
 */
@property (strong,nonatomic) NSMutableArray *dataSourceArray;

@property (assign,nonatomic) id<YIMTableViewDelegate> delegate;


@end
