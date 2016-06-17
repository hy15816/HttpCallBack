//
//  A.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 15/12/29.
//  Copyright © 2015年 yim. All rights reserved.
//

#import "TestModel.h"
#import "NSString+TextHeight.h"

@implementation TestModel
//@synthesize cellHeight;

+ (instancetype)model {
    
    TestModel *testModel = [[TestModel alloc] init];
    NSInteger baseHeight = 50;//图标margin + 图标高度
    int radmonNumber = arc4random_uniform(3);
    testModel.title = [NSString stringWithFormat:@"%d",arc4random()%1000000];
    testModel.imageName = @"userinfo_vc_top";
    if (radmonNumber == 1) {
        testModel.detail = @"Current pollution levels in Beijing are actually lower than last week's, but the red alert has been placed because of levels expected over the coming days.The order will last from 07:00 local time on Tuesday (23:00 GMT on Monday) until 12:00 on Thursday, when a cold front is expected to arrive and clear the smog.";
        //baseHeight = 0;
    }else if(radmonNumber == 2) {
        testModel.detail = @"/Applications/Xcode5.0/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang++ -arch armv7 -isysroot /Applications/Xcode5.0/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS7.0.sdk -L/Users/JunJie/Library/Developer/Xcode/DerivedData/TianJinEcoCity-aisnqbxpzmfiuveydfblxinyzebm/Build/Products/Debug-iphoneos -L/Users/JunJie/Downloads/02.城市App/TableDemo/VideoPlaySDK -L/Users/JunJie/Downloads/02.城市App/TableDemo/ZBarSDK -F/Users/JunJie/Library/Developer/Xcode/DerivedData/TianJinEcoCity-aisnqbxpzmfiuveydfblxinyzebm/Build/Products/Debug-iphoneos -F/Users/JunJie/Library/SDKs/ArcGIS -F/Users/JunJie/Library/SDKs/ArcGIS/Samples -F/Users/JunJie/Library/SDKs/ArcGIS/Samples/MapViewDemo -F/Users/JunJie/Library/SDKs/ArcGIS/Samples/MapViewDemo/Classes -F/Users/JunJie/Library/SDKs/ArcGIS/Samples/MapViewDemo/Resources-iPad -F/Applications/Xcode5.0/Xcode.app/Contents/Developer/Library/Framewo";
    }else{
        testModel.detail = @"aaaaaaaaaaa";
    }
    
    //设置高度
    //1、获取屏幕的宽度
    //CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    //2、设置detailLabel的宽度
    
    CGFloat descLabelW = [[UIScreen mainScreen] bounds].size.width - 25;// 25为左margin:15 + 右margin:10
    //NNLog(@"descLabelW:%f",descLabelW);
    //字体要和xib中设定的字体一样大小
    CGFloat detailLabelHeight = [testModel.detail heightWithText:testModel.detail font:[UIFont systemFontOfSize:14.0] width:descLabelW];
    CGFloat detailMargin = 15;  //距图标高度+距离底部高度
    testModel.cellHeight = baseHeight + detailLabelHeight + detailMargin;
    
    return testModel;
}

+ (instancetype)modelWithTitle:(NSString *)title detail:(NSString *)detailStr imageName:(NSString *)imgName {
    
    TestModel *testModel = [[TestModel alloc] init];
    testModel.title = title;
    testModel.detail = detailStr;
    testModel.imageName = imgName;
    
//    NSInteger baseHeight = 50;//图标margin + 图标高度
    
    //设置高度 放在cell中计算了
    //1、获取屏幕的宽度
    //CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    //2、设置detailLabel的宽度
    
//    CGFloat descLabelW = [[UIScreen mainScreen] bounds].size.width - 25;// 25为左margin:15 + 右margin:10
//    NNLog(@"descLabelW:%f",descLabelW);
    //字体要和xib中设定的字体一样大小
//    CGFloat detailLabelHeight = [testModel.detail heightWithText:testModel.detail font:[UIFont systemFontOfSize:14.0] width:descLabelW];
//    CGFloat detailMargin = 15;  //距图标高度+距离底部高度
//    testModel.cellHeight = baseHeight + detailLabelHeight + detailMargin;
    
    return testModel;

}

@end
