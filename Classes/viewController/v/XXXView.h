//
//  XXXView.h
//  HttpCallBack
//
//  Created by AEF-RD-1 on 15/12/26.
//  Copyright © 2015年 yim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginList.h"
#import "LoginListReformer.h"

@interface XXXView : UIView
{
    NSString *_name;
    NSString *_documentCode;
}

@property (strong,nonatomic) NSString *user_name;

- (void)configWithData:(NSDictionary *)data;

@end
