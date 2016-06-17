//
//  XXXView.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 15/12/26.
//  Copyright © 2015年 yim. All rights reserved.
//

#import "XXXView.h"

@interface XXXView ()

@property (strong,nonatomic) UILabel *nameLabel;
@property (strong,nonatomic) UILabel *docmLabel;
@end

@implementation XXXView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        [self addSubview:self.nameLabel];
        [self addSubview:self.docmLabel];
    }
    
    return self;
}

- (void)configWithData:(NSDictionary *)data {
    NSLog(@"XXXView.m configWithData:%@",data);
    
    if (data != nil) {
        //_name = [data[kLoginListDataKeyExtrDatas] objectForKey:@"user_name"];
        _documentCode = [data[kLoginListDataKeyExtrDatas] objectForKey:@"documentCode"];
        self.nameLabel.text = _name;
        self.docmLabel.text = _documentCode;
        
        NSString *msg = data[kLoginListDataKeyMsg];
        UIAlertView *loginAlert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@\n%@",_name,msg] message:_documentCode delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [loginAlert show];
    }
}


#pragma mark - getters

-(UILabel *)nameLabel {
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/2)];
    return _nameLabel;
}

-(UILabel *)docmLabel {
    
    _docmLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height/2, self.frame.size.width, self.frame.size.height/2)];
    return _docmLabel;
}


- (void)setUser_name:(NSString *)user_name {
    
    _name = user_name;
    _nameLabel.text = user_name;
}

@end
