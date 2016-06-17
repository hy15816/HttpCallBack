//
//  APIManager.h
//  SlidesDemo
//
//  Created by AEF-RD-1 on 15/12/24.
//  Copyright © 2015年 yim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "HttpURLHeader.h"

typedef void (^reqSucCallBlock)(NSURLSessionDataTask *task, id responseObject);
typedef void (^reqErrCallBlock)(NSURLSessionDataTask *task, NSError *error);

@class APIManager;
//==============ReformerProtocol==============
@protocol ReformerProtocol <NSObject>
@optional
- (NSDictionary *)reformDataWithManager:(APIManager *)manager;

@end

//===========================

@protocol APIManagerDelegate <NSObject>

- (void)apiManagerDidSuccess:(APIManager *)manager;
- (void)apiManagerDidFailure:(NSError *)error;

@end

@interface APIManager : NSObject

@property (strong,nonatomic) NSDictionary *rawData;
@property (assign,nonatomic) id<APIManagerDelegate> delegate;

+ (APIManager *)managerWithDelegate:(id<APIManagerDelegate>)delegate;

- (NSDictionary *)fetchDataWithReformer:(id<ReformerProtocol>)reformer;

//req method
- (void)postWithUrl:(NSString *)url patamer:(NSDictionary *)param ;
- (void)getWithUrl:(NSString *)url patamer:(NSDictionary *)param ;
- (void)dowmloadWithUrl:(NSString *)url ;
- (void)uploadWithUrl:(NSString *)url filePath:(NSString *)_filePath ;

+ (void)GETWithURL:(NSString *)url patamer:(NSDictionary *)param;
+ (void)getUserInfoWithName:(NSString *)name documentCode:(NSString *)documentCode result:(void (^)(id response))result;
+ (void)APIPOSTJSONWithUrl:(NSString *)urlStr parameters:(id)parameters show:(BOOL)showSVP success:(reqSucCallBlock)success fail:(reqErrCallBlock)fail;


@end
