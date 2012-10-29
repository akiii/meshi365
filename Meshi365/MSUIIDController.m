//
//  MSUIIDController.m
//  Meshi365
//
//  Created by Akifumi on 2012/10/29.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSUIIDController.h"

@implementation MSUIIDController

- (BOOL)exist{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:kUIID]) {
        return YES;
    }else {
        return NO;
    }
}

- (NSString *)uiid{
    if ([self exist]) {
        return [self uuid];
    }else {
        return [self create];
    }
}

- (NSString *)create{
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    NSString *uuidString = (__bridge NSString*)CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    return uuidString;
}

- (NSString *)uuid{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUIID];
}

@end
