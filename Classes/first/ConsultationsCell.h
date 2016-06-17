//
//  ConsultationsCell.h
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/3/11.
//  Copyright © 2016年 yim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConsultationsModel : NSObject

@property (strong,nonatomic) NSString *content;
@property (strong,nonatomic) NSString *userName;

@end


@interface ConsultationsCell : UITableViewCell

@property (strong,nonatomic) ConsultationsModel *consultationsModel;

+ (ConsultationsCell *)cellWithTableView:(UITableView *)tableView nibName:(NSString *)nibName;

@end
