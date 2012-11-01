//
//  MSFoodPicture.m
//  Meshi365
//
//  Created by Akifumi on 2012/10/30.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSFoodPicture.h"
#import "MSUser.h"

@implementation MSFoodPicture

- (id)init{
    if (self = [super init]) {
        self.uiid = [MSUser currentUser].uiid;
        self.mealType = 1;
        self.url = @"";
        self.storeName = @"";
        self.menuName = @"";
        self.comment = @"";
        self.starNum = 3;
    }
    return self;
}

- (id)init:(NSDictionary*)json
{
	self.uiid		= [[json objectForKey:@"uiid"] stringValue];
	self.mealType	= [[json objectForKey:@"meal_type"] integerValue];
	self.url		= [[json objectForKey:@"url"] stringValue];
	self.storeName	= [[json objectForKey:@"store_name"] stringValue];
	self.menuName	= [[json objectForKey:@"menu_name"] stringValue];
	self.comment	= [[json objectForKey:@"comment"] stringValue];
	self.starNum	= [[json objectForKey:@"comment"] integerValue];
	
}

- (NSString *)params{
    NSString *params = [NSString string];
    params = [params stringByAppendingFormat:@"%@=%@&", @"uiid",         self.uiid];
    params = [params stringByAppendingFormat:@"%@=%@&", @"meal_type",    [NSNumber numberWithInt:self.mealType]];
    params = [params stringByAppendingFormat:@"%@=%@&", @"url",          self.url];
    if (![self.storeName isEqualToString:@""]) {
        params = [params stringByAppendingFormat:@"%@=%@&", @"store_name",   self.storeName];
    }
    if (![self.menuName isEqualToString:@""]) {
        params = [params stringByAppendingFormat:@"%@=%@&", @"menu_name",   self.menuName];
    }
    if (![self.comment isEqualToString:@""]) {
        params = [params stringByAppendingFormat:@"%@=%@&", @"comment",      self.comment];
    }
    params = [params stringByAppendingFormat:@"%@=%@&", @"star_num",     [NSNumber numberWithInt:self.starNum]];
    return params;
}

- (void)dealloc{
    self.uiid = nil;
    self.url = nil;
    self.storeName = nil;
    self.menuName = nil;
    self.comment = nil;
}

@end
