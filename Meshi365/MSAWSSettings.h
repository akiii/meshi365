//
//  MSAWSSettings.h
//  Meshi365
//
//  Created by Akifumi on 2012/11/05.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#define AWS_BASE_URL                @"https://s3.amazonaws.com"

#define AWS_BUCKET_NAME             @"meshi365-images"

#define AWS_CLOUD_FRONT_URL         @"http://d288133o2gygjt.cloudfront.net"

#define ASSETS_SERVER_S3            0
#define ASSETS_SERVER_CLOUD_FRONT   1

#if AWS_ASSETS_SEVER == ASSETS_SERVER_S3

#define ASSETS_FILE_URL(fileName)   [NSString stringWithFormat:@"%@/%@/%@", AWS_BASE_URL, AWS_BUCKET_NAME, fileName]

#elif AWS_ASSETS_SEVER == ASSETS_SERVER_CLOUD_FRONT

#define ASSETS_FILE_URL(fileName)   [NSString stringWithFormat:@"%@/%@", AWS_CLOUD_FRONT_URL, fileName]

#endif