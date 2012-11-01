//
//  MSUIIDController.m
//  Meshi365
//
//  Created by Akifumi on 2012/10/29.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSUIIDController.h"

static MSUIIDController *controller = nil;

@implementation MSUIIDController

+ (MSUIIDController *)sharedController{
    if (!controller) {
        controller = [[MSUIIDController alloc] init];
    }
    return controller;
}

- (BOOL)exist{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([[defaults objectForKey:kUIID] isEqualToString:@""]) {
        return NO;
    }else {
        return YES;
    }
}

- (NSString *)uiid{
    NSString *uiid;
    if ([self exist]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        uiid = [defaults objectForKey:kUIID];
    }else {
        uiid = @"";
    }
    return uiid;
}

- (NSString *)create{
    CFUUIDRef uiidObj = CFUUIDCreate(nil);
    NSString *uiidString = (__bridge NSString*)CFUUIDCreateString(nil, uiidObj);
    CFRelease(uiidObj);
    return uiidString;
}

- (void)dealloc{
    controller = nil;
}

@end
