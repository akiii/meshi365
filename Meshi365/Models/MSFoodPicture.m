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
        self.amenity = @"";
        self.comment = @"";
        self.starNum = 3;
    }
    return self;
}

- (id)init:(NSDictionary*)json
{
	if (self = [super init]) {
		NSLog(@"init foodpicture start.");

		/*HACK:
		 jsonの要素の文字列が"<null>"場合、
		 !name, name == nil , 
		 name == NULL, 
		 name isEqualToString @"<null>"
		 の全ててで検出不能となる。そのため、jsonの要素を一度stringWithFormatする。
		 */
		self.createdAt	= [json objectForKey:@"created_at"];
		self.uiid		= [json objectForKey:@"uiid"];
		self.mealType	= [[json objectForKey:@"meal_type"] integerValue];
		self.url		= [json objectForKey:@"url"];
		self.storeName	= [NSString stringWithFormat:@"%@", [json objectForKey:@"store_name"]];
		self.menuName	= [NSString stringWithFormat:@"%@", [json objectForKey:@"menu_name"]];
		self.comment	= [NSString stringWithFormat:@"%@", [json objectForKey:@"comment"]];
		self.starNum	= [[json objectForKey:@"star_num"] integerValue];
		self.user = [[MSUser alloc] initWithJson:json];
		
		NSString *strNull = @"(null)";
		if([self.storeName isEqualToString:strNull])self.storeName = nil;
		if([self.menuName isEqualToString:strNull])self.menuName = nil;
		if([self.comment isEqualToString:strNull])self.comment = nil;

		strNull = @"<null>";
		if([self.storeName isEqualToString:strNull])self.storeName = nil;
		if([self.menuName isEqualToString:strNull])self.menuName = nil;
		if([self.comment isEqualToString:strNull])self.comment = nil;

		NSLog(@"init foodpicture done.");
	}
	return self;
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
    if (![self.amenity isEqualToString:@""]) {
        params = [params stringByAppendingFormat:@"%@=%@&", @"amenity",  self.amenity];
    }
    if (![self.comment isEqualToString:@""]) {
        params = [params stringByAppendingFormat:@"%@=%@&", @"comment",      self.comment];
    }
    params = [params stringByAppendingFormat:@"%@=%@&", @"star_num",     [NSNumber numberWithInt:self.starNum]];
    return params;
}

- (void)dealloc{
	self.createdAt = nil;
    self.uiid = nil;
    self.url = nil;
    self.storeName = nil;
    self.menuName = nil;
    self.amenity = nil;
    self.comment = nil;
}

@end
