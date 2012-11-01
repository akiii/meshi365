//
//  MSUser.m
//  Meshi365
//
//  Created by Akifumi on 2012/10/30.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSUser.h"

static MSUser *currentUser = nil;

@implementation MSUser

+ (MSUser *)currentUser{
    if (!currentUser) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        currentUser = [[MSUser alloc] init];
        currentUser.uid = [[ud objectForKey:kUserId] intValue];
        currentUser.uiid = [ud objectForKey:kUIID];
    }
    return currentUser;
}

- (BOOL)signuped{
    if ([currentUser.uiid isEqualToString:@""]) {
        return NO;
    }else {
        return YES;
    }
}

- (NSString *)params{
    NSLog(@"id : %@", self.uiid);
    NSString *params = [NSString string];
    params = [params stringByAppendingFormat:@"%@=%@&", @"name",                self.name];
    params = [params stringByAppendingFormat:@"%@=%@&", @"uiid",                self.uiid];
    params = [params stringByAppendingFormat:@"%@=%@&", @"profile_image_url",   self.profileImageUrl];
    return params;
}

- (void)dealloc{
    self.name = nil;
    self.uiid = nil;
    self.profileImageUrl = nil;
}

@end
