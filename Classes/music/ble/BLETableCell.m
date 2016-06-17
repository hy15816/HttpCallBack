//
//  BLETableCell.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/3/5.
//  Copyright © 2016年 yim. All rights reserved.
//

#import "BLETableCell.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface BLETableCell ()

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *secondLabel;
@property (strong, nonatomic) IBOutlet UILabel *bottomLabel;

@end

@implementation BLETableCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setPeripheral:(CBPeripheral *)peripheral {
    
    _peripheral = peripheral;
    
    self.nameLabel.text = peripheral.name;
    self.secondLabel.text = peripheral.identifier.UUIDString;
//    self.bottomLabel.text = [NSString stringWithFormat:@"RSSI:%@",peripheral.RSSI];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
