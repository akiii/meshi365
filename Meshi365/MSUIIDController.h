//
//  MSUIIDController.h
//  Meshi365
//
//  Created by Akifumi on 2012/10/29.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kUIID   @"UIID"

@interface MSUIIDController : NSObject
- (BOOL)exist;
- (NSString *)uiid;
- (NSString *)create;
@end
