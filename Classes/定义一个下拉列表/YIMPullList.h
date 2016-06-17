//
//  YIMPullList.h
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/1/20.
//  Copyright © 2016年 yim. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PullListSelectItemBlock)(NSIndexPath *path,NSString *item);

@interface YIMPullList : UIView

+ (instancetype)pullListWithArray:(NSArray *)dataArray selectItemBlock:(PullListSelectItemBlock)block;
@property (strong, nonatomic) NSMutableArray *dataSourceArray;

/**
 *  展开
 */
- (void)spreadList;

@end
