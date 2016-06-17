//
//  Connection.h
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/1/9.
//  Copyright © 2016年 yim. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Connection;
@protocol ConnectionDelegate <NSObject>

- (void) connectionAttemptFailed:(Connection*)connection;
- (void) connectionTerminated:(Connection*)connection;
- (void) receivedNetworkPacket:(NSDictionary*)message viaConnection:(Connection*)connection;


@end

@interface Connection : NSObject

@property(nonatomic, assign) id<ConnectionDelegate> delegate;
@property(nonatomic, strong) NSString * host;
@property(nonatomic, assign) NSInteger port;
@property(nonatomic, strong) NSString * peerhost;
@property(nonatomic, assign) NSInteger peerport;

- (id) initWithHostAddress:(NSString *) thePeerHost andPort:(NSInteger) thePort;

// Initialize using a native socket handle, assuming connection is open
- (id) initWithNativeSocketHandle:(CFSocketNativeHandle)nativeSocketHandle;

// Connect using whatever connection info that was passed during initialization
- (BOOL) connect;

// Close connection
- (void) close;

// Send network message
- (void) sendNetworkPacket:(NSDictionary *)packet;

@end
