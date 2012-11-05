//
//  MSImageLoader.h
//  Meshi365
//
//  Created by Mlle.Irene on 2012/11/03.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSFoodPicture.h"

@interface MSImageLoader : NSObject

+ (MSImageLoader*)sharedManager;
-(void)ImageLoad:(NSString*)url view:(UIView*)view;

@end
