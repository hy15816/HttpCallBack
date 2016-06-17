//
//  YIMGrideViewListItemView.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/1/8.
//  Copyright © 2016年 yim. All rights reserved.
//

#import "YIMGrideViewListItemView.h"
#import "UIView+Extension.h"
#import "YIMGrideViewModel.h"
#import "UIButton+WebCache.h"

#pragma mark - YIMGrideViewButtonItem

@implementation YIMGrideViewButtonItem
/**
 -----------------
 |  |---------|  |
 |  |         |  |
 |  |  image  |  |
 |  |---------|  |
 |     title     |
 -----------------
 */
//初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self ) {
        
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    //NNLog(@"");
    return self;
}
//调整button的image的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    CGFloat h = self.sd_height * 0.3;       //button的frame.h 的 0.3f
    CGFloat w = h;                          //w = h,正方形
    CGFloat x = (self.sd_width - w) /2.f;  //居中
    CGFloat y = self.sd_height * 0.3;       //button的frame.h 的 0.3f
    //NNLog(@"");
    return CGRectMake(x, y, w, h);
}

//调整button的title的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    //NNLog(@"");
    return CGRectMake(0, self.sd_height * 0.3 *2, self.sd_width, self.sd_height * 0.3);
}



@end

#pragma mark - YIMGrideViewListItemView
@interface YIMGrideViewListItemView ()
{
    YIMGrideViewButtonItem *_grideButtonItem;
    UIButton *_deleteIconView;
}
@end

@implementation YIMGrideViewListItemView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)initialization {
    
    self.backgroundColor = [UIColor whiteColor];
    
    //buttonItem
    YIMGrideViewButtonItem *buttonItem = [[YIMGrideViewButtonItem alloc] initWithFrame:CGRectZero];
//    YIMGrideViewButtonItem *buttonItem = [[YIMGrideViewButtonItem alloc] initWithImageH:15];
    [buttonItem addTarget:self action:@selector(buttonItemClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buttonItem];
    _grideButtonItem = buttonItem;
    
    //右上角的删除button
    UIButton *deleteIcon = [[UIButton alloc] init];
    [deleteIcon setImage:[UIImage imageNamed:@"Home_delete_icon"] forState:UIControlStateNormal];
    [deleteIcon addTarget:self action:@selector(deleteIconViewClicked) forControlEvents:UIControlEventTouchUpInside];
    deleteIcon.hidden = YES;
    [self addSubview:deleteIcon];
    _deleteIconView = deleteIcon;
    
    UILongPressGestureRecognizer *longPressed = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(itemLongPressed:)];
    [self addGestureRecognizer:longPressed];
}

#pragma mark - button actions && longPress

- (void)buttonItemClicked {
    if (self.buttonClickActionBlock) {
        self.buttonClickActionBlock(self);
    }
}

- (void)deleteIconViewClicked {
    
    if (self.iconViewClickActionBlock) {
        self.iconViewClickActionBlock(self);
    }
}

- (void)itemLongPressed:(UILongPressGestureRecognizer *)longPressed
{
    if (self.itemLongPressedActionBlock) {
        self.itemLongPressedActionBlock(longPressed);
    }
}

#pragma mark - setters

- (void)setItemModel:(YIMGrideViewModel *)itemModel {
    _itemModel = itemModel;
    
    //标题
    if (itemModel.title) {
        [_grideButtonItem setTitle:itemModel.title forState:UIControlStateNormal];
    }
    //图片
    if (itemModel.imageResString) {
        if ([itemModel.imageResString hasPrefix:@"http:"]) {//字符串以http:开头
            //设置从网络获取图片
            [_grideButtonItem sd_setImageWithURL:[NSURL URLWithString:itemModel.imageResString] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"placeholder"]];

        }else {
            [_grideButtonItem setImage:[UIImage imageNamed:itemModel.imageResString] forState:UIControlStateNormal];
        }
    }
    
}

- (void)setHidenIcon:(BOOL)hidenIcon {
    _hidenIcon = hidenIcon;
    _deleteIconView.hidden = hidenIcon;
}

- (void)setIconImage:(UIImage *)iconImage {
    _iconImage = iconImage;
    [_deleteIconView setImage:iconImage forState:UIControlStateNormal];
}

#pragma mark - life circles

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat margin = 10;
    _grideButtonItem.frame = self.bounds;
    _deleteIconView.frame = CGRectMake(self.sd_width - _deleteIconView.sd_width - margin, margin, 20, 20);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
