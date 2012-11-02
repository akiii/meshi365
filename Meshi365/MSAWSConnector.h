//
//  MSAWSConnector.h
//  Meshi365
//
//  Created by Akifumi on 2012/10/30.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSFoodPictureImage.h"

@interface MSAWSConnector : NSObject
+ (NSString *)uploadProfileImageToAWS:(UIImage *)image;
+ (NSString *)uploadFoodPictureToAWS:(MSFoodPictureImage *)image;
+ (NSURL *)getS3UrlFromString:(NSString*)url;
@end
