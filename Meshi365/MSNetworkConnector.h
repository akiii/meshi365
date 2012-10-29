//
//  MSNetworkConnector.h
//  Meshi365
//
//  Created by Akifumi on 2012/10/29.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    RequestMethodGet,
    RequestMethodPost
} MSNetworkConnectorRequestMethod;

@interface MSNetworkConnector : NSObject
+ (void)fetchDataFromUrl:(NSString *)url method:(MSNetworkConnectorRequestMethod)method params:(NSString *)params block:(void(^)(NSData *response))block;
+ (void)requestToUrl:(NSString *)url method:(MSNetworkConnectorRequestMethod)method params:(NSString *)params block:(void(^)(NSData *response))block;
@end
