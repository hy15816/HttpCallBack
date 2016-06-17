//
//  CarBrandCell.m
//  DiDi360
//
//  Created by goopai on 14-4-17.
//  Copyright (c) 2014年 goopai. All rights reserved.
//

#import "CarBrandCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation CarBrandCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}

- (void)initWithCarLogo:(NSString *)carLogo CarBrand:(NSString *)carBrand From:(NSString *)fromString
{
//    CGSize size = [carBrand sizeWithFont:[UIFont systemFontOfSize:16] forWidth:(DEVICE_WIDTH - 80 - 70) lineBreakMode:NSLineBreakByWordWrapping];
    if ([fromString isEqualToString:@"detail"]) {
        self.carBrandLabel.numberOfLines = 2;
    }
    
    //[self.carLogoView  setImageWithURL:[NSURL URLWithString:carLogo] placeholderImage:[UIImage imageNamed:@""]];
    [self.carLogoView sd_setImageWithURL:[NSURL URLWithString:carLogo] placeholderImage:[UIImage imageNamed:@"userinfo_vc_top"]];
    self.carBrandLabel.text = carBrand;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
