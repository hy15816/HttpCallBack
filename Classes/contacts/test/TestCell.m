//
//  TestCell.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 15/12/31.
//  Copyright © 2015年 yim. All rights reserved.
//

#import "TestCell.h"
#import "NSString+TextHeight.h"

@interface TestCell ()

@property (strong, nonatomic) IBOutlet UIImageView *user_image;
@property (strong, nonatomic) IBOutlet UILabel *user_nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *user_detailLabel;

@end

@implementation TestCell


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *cellID = @"testCell";
    TestCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TestCell" owner:self options:nil] lastObject];
    }
    return cell;
    
}

- (void)awakeFromNib {
    // Initialization code
    
//    NNLog(@" ");
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - setters

-(void)setTestModel:(TestModel *)testModel {
    _testModel = testModel;
    self.user_nameLabel.text = testModel.title;
    self.user_detailLabel.contentMode = UIViewContentModeTopLeft;
    self.user_detailLabel.text = testModel.detail;
    
    self.user_image.layer.cornerRadius = self.user_image.frame.size.width *.5f;
    self.user_image.layer.masksToBounds = YES;
    self.user_image.image = [UIImage imageNamed:testModel.imageName];
    
    CGFloat detailLabelHeight = [testModel.detail heightWithText:testModel.detail font:self.user_detailLabel.font width:self.user_detailLabel.frame.size.width];
    CGFloat baseHeight = self.user_image.frame.size.height+self.user_image.frame.origin.y;
    CGFloat detailMargin = 5 + 10;
    testModel.cellHeight = baseHeight + detailLabelHeight + detailMargin;
    NNLog(@"baseHeight:%f,detailMargin:%f,cellHeight:%f",baseHeight,detailMargin,testModel.cellHeight);
    
}
@end
