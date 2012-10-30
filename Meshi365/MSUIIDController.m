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
    if ([[defaults objectForKey:kUIID] isEqual:@""]) {
        return NO;
    }else {
        return YES;
    }
}

- (NSString *)uiid{
    if ([self exist]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *uiid = [defaults objectForKey:kUIID];
        return uiid;
    }else {
        return [self create];
    }
}

- (NSString *)create{
    CFUUIDRef uiidObj = CFUUIDCreate(nil);
    NSString *uiidString = (__bridge NSString*)CFUUIDCreateString(nil, uiidObj);
    CFRelease(uiidObj);
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:uiidString forKey:kUIID];
    [ud synchronize];
    
    return uiidString;
}

- (void)dealloc{
    controller = nil;
}

@end
