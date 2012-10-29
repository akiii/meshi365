//
//  MSNetworkConnector.m
//  Meshi365
//
//  Created by Akifumi on 2012/10/29.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSNetworkConnector.h"

@implementation MSNetworkConnector

+ (void)fetchDataFromUrl:(NSString *)url method:(MSNetworkConnectorRequestMethod)method params:(NSString *)params block:(void(^)(NSData *response))block{
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    if (method == RequestMethodPost) {
        [req setHTTPMethod:@"POST"];
    }
    
    if (params) {
        [req setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    block([NSURLConnection sendSynchronousRequest:req returningResponse:nil error:nil]);
}

+ (void)requestToUrl:(NSString *)url method:(MSNetworkConnectorRequestMethod)method params:(NSString *)params block:(void(^)(NSData *response))block{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    if (method == RequestMethodPost) {
        [request setHTTPMethod:@"POST"];
    }
    
    if (params) {
        [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    NSData *jsonData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    block(jsonData);
}

@end