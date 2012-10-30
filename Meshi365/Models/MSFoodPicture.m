//
//  MSFoodPicture.m
//  Meshi365
//
//  Created by Akifumi on 2012/10/30.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSFoodPicture.h"

@implementation MSFoodPicture

- (NSString *)params{
    NSString *params = [NSString string];
    params = [params stringByAppendingFormat:@"%@=%@&", @"user_id",      [NSNumber numberWithInt:self.userId]];
    params = [params stringByAppendingFormat:@"%@=%@&", @"url",          self.url];
    params = [params stringByAppendingFormat:@"%@=%@&", @"store_name",   self.storeName];
    params = [params stringByAppendingFormat:@"%@=%@&", @"menu_name",    self.menuName];
    params = [params stringByAppendingFormat:@"%@=%@&", @"star_num",     [NSNumber numberWithInt:self.starNum]];
    return params;
}

- (void)dealloc{
    self.url = nil;
    self.storeName = nil;
    self.menuName = nil;
}

@end
