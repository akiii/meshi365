//
//  MSAWSConnector.h
//  Meshi365
//
//  Created by Akifumi on 2012/10/30.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSAWSConnector : NSObject
+ (NSURL *)postFoodPictureToAWS:(UIImage *)image;
@end
