//
//  ConsultationsCell.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/3/11.
//  Copyright © 2016年 yim. All rights reserved.
//

#import "ConsultationsCell.h"


@implementation ConsultationsModel

@synthesize content;
@synthesize userName;

@end

//======================================================//

@interface ConsultationsCell ()

@property (strong, nonatomic) IBOutlet UILabel *centerLabel;

@end

@implementation ConsultationsCell

+ (ConsultationsCell *)cellWithTableView:(UITableView *)tableView nibName:(NSString *)nibName {
    
    static NSString *cellIndetifier = @"cellIndetifierNib";
    ConsultationsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]  loadNibNamed:nibName owner:nil options:nil] lastObject];
    }
    
    return cell;
    
}

- (void)setConsultationsModel:(ConsultationsModel *)consultationsModel {
    
    _consultationsModel = consultationsModel;
    
    self.centerLabel.text = consultationsModel.content;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
