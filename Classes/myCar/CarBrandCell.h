//
//  CarBrandCell.h
//  DiDi360
//
//  Created by goopai on 14-4-17.
//  Copyright (c) 2014年 goopai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarBrandCell : UITableViewCell

@property (strong, nonatomic) UIImageView *carLogoView;
@property (strong, nonatomic) UILabel *carBrandLabel;
@property (assign, nonatomic) BOOL haveShowNext;

- (void)initWithCarLogo:(NSString *)carLogo CarBrand:(NSString *)carBrand From:(NSString *)fromString;

@end
