//
//  APIManager.m
//  SlidesDemo
//
//  Created by AEF-RD-1 on 15/12/24.
//  Copyright © 2015年 yim. All rights reserved.
//

#import "APIManager.h"

@interface APIManager ()

@property (strong,nonatomic) NSOperationQueue *operationQueue;
@property (strong,nonatomic) NSMutableArray *opQueueArray;
@end

@implementation APIManager
@synthesize rawData;

#pragma mark - ========== public method ============

static APIManager *_manager = nil;

+ (APIManager *)managerWithDelegate:(id<APIManagerDelegate>)delegate; {
    
    @synchronized(self) {
        if (_manager == nil) {
            _manager = [[APIManager alloc] init];
            if (delegate) {
                _manager.delegate = delegate;
            }
        }
    }
    return _manager;
}


- (NSDictionary *)fetchDataWithReformer:(id<ReformerProtocol>)reformer {
    if (reformer == nil) {
        NNLog(@",[reformer == nil]");
        return self.rawData;
    } else {
        NNLog(@",[reformer != nil]");
        return [reformer reformDataWithManager:self];
    }
}

- (void)postWithUrl:(NSString *)url patamer:(NSDictionary *)param {
    
    [self POSTWithURL:url parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable response) {
        
        self.rawData = (NSDictionary *)response;
        NNLog(@"........self.rawData:%@",self.rawData);
        //suc
        if ([self.delegate respondsToSelector:@selector(apiManagerDidSuccess:)]) {
            [self.delegate apiManagerDidSuccess:self];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull err) {
        //fail
        if ([self.delegate respondsToSelector:@selector(apiManagerDidFailure:)]) {
            [self.delegate apiManagerDidFailure:err];
        }
    }];
}

- (void)getWithUrl:(NSString *)url patamer:(NSDictionary *)param {
    
}

- (void)dowmloadWithUrl:(NSString *)url  {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://example.com/download.zip"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NNLog(@"File downloaded to: %@", filePath);
        
    }];
    [downloadTask resume];
}


- (void)uploadWithUrl:(NSString *)url filePath:(NSString *)_filePath {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://example.com/upload"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURL *filePath = [NSURL fileURLWithPath:@"file://path/to/image.png"];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:filePath progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NNLog(@"Error: %@", error);
        } else {
            NNLog(@"Success: %@ %@", response, responseObject);
        }
    }];
    [uploadTask resume];
}

+ (void)getUserInfoWithName:(NSString *)name documentCode:(NSString *)documentCode result:(void (^)(id response))result {
    
    [[APIManager managerWithDelegate:nil] getUserInfoWithName:name documentCode:documentCode result:result];
    //[[APIManager managerWithDelegate:nil] getUserInfoWithName2:name documentCode:documentCode result:result];
    //[[APIManager managerWithDelegate:nil] getUserInfoWithName3:name documentCode:documentCode result:result];
    //[[APIManager managerWithDelegate:nil] getUserInfoWithName4:name documentCode:documentCode result:result];
    //[[APIManager managerWithDelegate:nil] getUserInfoWithName5:name documentCode:documentCode result:result];
}

- (void)getUserInfoWithName:(NSString *)name documentCode:(NSString *)documentCode result:(void (^)(id response))result {
    //线程池
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        //
        NSDictionary *sdic = @{@"user_name":name,@"documentCode":documentCode};
        [self POSTWithURL:@"http://112.74.128.144:8189/AnerfaBackstage/updateUserInfo/secUserInfo.do" parameters:sdic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable response) {
            //
            if (result) {
                result(response);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull err) {
            //
        }];
    }];
    
    
    if (self.opQueueArray.count) {
        NSBlockOperation *lastPperation = (NSBlockOperation *)[self.opQueueArray lastObject];
        [operation addDependency:lastPperation];
    }
    [self.opQueueArray addObject:operation];
    [self.operationQueue addOperation:operation];
    
    //NSLog(@"self.operationQueue.count:%lu ",(unsigned long)self.operationQueue.operationCount);
    //NSLog(@"self.operationQueue.name :%@ ",self.operationQueue.name);
    
}


- (void)getUserInfoWithName2:(NSString *)name documentCode:(NSString *)documentCode result:(void (^)(id response))result {
    
    //并发队列
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    dispatch_async(globalQueue, ^{
        //
        NSDictionary *sdic = @{@"user_name":name,@"documentCode":documentCode};
        [self POSTWithURL:@"http://112.74.128.144:8189/AnerfaBackstage/updateUserInfo/secUserInfo.do" parameters:sdic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable response) {
            //
            if (result) {
                result(response);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull err) {
            //
        }];
    });
    
}

- (void)getUserInfoWithName3:(NSString *)name documentCode:(NSString *)documentCode result:(void (^)(id response))result {
    
    //GCD,使用此方法创建的任务首先会查看队列中有没有别的任务要执行，如果有，则会等待已有任务执行完毕再执行；同时在此方法后添加的任务必须等待此方法中任务执行后才能执行。）
    dispatch_queue_t queue = dispatch_queue_create("JOHNSHAW", DISPATCH_QUEUE_CONCURRENT);
    
//    dispatch_barrier_async(queue, ^{////添加到队列中,异步执行队列任务
//        
//        
//    });
    dispatch_async(queue, ^{
        //
        NSDictionary *sdic = @{@"user_name":name,@"documentCode":documentCode};
        [self POSTWithURL:@"http://112.74.128.144:8189/AnerfaBackstage/updateUserInfo/secUserInfo.do" parameters:sdic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable response) {
            //
            if (result) {
                result(response);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull err) {
            //
        }];
    });
    
}

- (void)getUserInfoWithName4:(NSString *)name documentCode:(NSString *)documentCode result:(void (^)(id response))result {
    
    //(GCD 分组任务管理)
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        //
        NSDictionary *sdic = @{@"user_name":name,@"documentCode":documentCode};
        [self POSTWithURL:@"http://112.74.128.144:8189/AnerfaBackstage/updateUserInfo/secUserInfo.do" parameters:sdic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable response) {
            //
            if (result) {
                result(response);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull err) {
            //
        }];
    });
    
}

- (void)getUserInfoWithName5:(NSString *)name documentCode:(NSString *)documentCode result:(void (^)(id response))result {
    
    
    //
    NSDictionary *sdic = @{@"user_name":name,@"documentCode":documentCode};
    [self POSTWithURL:@"http://112.74.128.144:8189/AnerfaBackstage/updateUserInfo/secUserInfo.do" parameters:sdic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable response) {
        //
        if (result) {
            result(response);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull err) {
        //
    }];
    
    
}

+ (void)APIPOSTJSONWithUrl:(NSString *)urlStr parameters:(id)parameters show:(BOOL)showSVP success:(reqSucCallBlock)success fail:(reqErrCallBlock)fail {
    [[APIManager managerWithDelegate:nil] POSTWithURL:urlStr parameters:parameters success:success failure:fail];
    
}

#pragma mark - ========== private method ============
#pragma mark - post
- (void)POSTWithURL:(NSString *)urlString
         parameters:(id )parameters
            success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable response))success
            failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull err))failure {
    NNLog(@" send parameters :%@",parameters);
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFJSONRequestSerializer serializer];//json
    [session POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //
        //NSLog(@"totalUnitCount:%lld,,,,,,,,completedUnitCount:%lld",uploadProgress.totalUnitCount,uploadProgress.completedUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NNLog(@" success receive responseObject :%@",responseObject);
        //suc
        if (success) {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NNLog(@" failure receive responseObject :[%@] [error.loc:%@],[error.code:%ld]",task.taskDescription,error.localizedDescription,(long)error.code);
        //faile
        if (failure) {
            failure(task,error);
        }
        
    }];
    
    
}

#pragma mark - get
- (void)GETWithURL:(NSString *)urlString
        parameters:(id )parameters
           success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable response))success
           failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull err))failure {
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session GET:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        //
        NNLog(@"GETWithURL totalUnitCount:%lld,,,,,,,,completedUnitCount:%lld",downloadProgress.totalUnitCount,downloadProgress.completedUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NNLog(@"GETWithURL success receive responseObject :%@",responseObject);
        //suc
        if (success) {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NNLog(@"GETWithURL failure receive responseObject :%@ error:%@",task.response,error);
        //faile
        if (failure) {
            failure(task,error);
        }
    }];
    
}

+(void)GETWithURL:(NSString *)url patamer:(NSDictionary *)param {
    
}
#pragma mark - 设置缓存
- (void)saveToLocal:(NSData *)data {
    
    //请求成功后，保存
    NSString *cachePath = @"你的缓存路径";//  /Library/Caches/MyCache
    [data writeToFile:cachePath atomically:YES];
    
    //使用：网络请求之前
    NSString * cachePathLocal = @"你的缓存路径";
    if ([[NSFileManager defaultManager] fileExistsAtPath:cachePathLocal]) {
        //从本地读缓存文件
        //NSData *data = [NSData dataWithContentsOfFile:cachePath];
    }
    
    
}

#pragma mark - getters and setters

- (NSOperationQueue *)operationQueue {
    if (_operationQueue == nil) {
        _operationQueue = [[NSOperationQueue alloc] init];
        _operationQueue.maxConcurrentOperationCount = 5;
        
    }
    
    return _operationQueue;
}


- (NSMutableArray *)opQueueArray {
    if (_opQueueArray == nil) {
        _opQueueArray = [[NSMutableArray alloc] init];
    }
    return _opQueueArray;
}

@end
