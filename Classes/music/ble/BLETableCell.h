//
//  BLETableCell.h
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/3/5.
//  Copyright © 2016年 yim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CBPeripheral;
@interface BLETableCell : UITableViewCell

@property (strong,nonatomic) CBPeripheral *peripheral;
@end
