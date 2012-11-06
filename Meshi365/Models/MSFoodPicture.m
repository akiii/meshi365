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
        self.fileName = @"";
        self.storeName = @"";
        self.menuName = @"";
        self.amenity = 0;
        self.comment = @"";
        self.starNum = 3;
    }
    return self;
}

- (id)initWithJson:(NSDictionary*)json
{
	if (self = [super init]) {
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
		self.fileName		= [json objectForKey:@"file_name"];
        //[[json objectForKey:@"url"] stringByReplacingOccurrencesOfString:@"s3.amazonaws.com/meshi365-images" withString:@"s3efdeg3pyykt7.cloudfront.net"];
		self.storeName	= [NSString stringWithFormat:@"%@", [json objectForKey:@"store_name"]];
		self.menuName	= [NSString stringWithFormat:@"%@", [json objectForKey:@"menu_name"]];
		self.comment	= [NSString stringWithFormat:@"%@", [json objectForKey:@"comment"]];
		self.starNum	= [[json objectForKey:@"star_num"] integerValue];
        self.createdAt  = [json objectForKey:@"created_at"];
        
        NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
        [inputFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZ"];
        
        NSDate *formatterDate = [inputFormatter dateFromString:self.createdAt];
        
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSString *dateString = [outputFormatter stringFromDate:formatterDate];
        self.createdAt = dateString;
        
		self.user = [[MSUser alloc] initWithJson:json];
		
		NSString *strNull = @"(null)";
		if([self.storeName isEqualToString:strNull])self.storeName = nil;
		if([self.menuName isEqualToString:strNull])self.menuName = nil;
		if([self.comment isEqualToString:strNull])self.comment = nil;

		strNull = @"<null>";
		if([self.storeName isEqualToString:strNull])self.storeName = nil;
		if([self.menuName isEqualToString:strNull])self.menuName = nil;
		if([self.comment isEqualToString:strNull])self.comment = nil;
	}
	return self;
}

- (NSString *)params{
    NSString *params = [NSString string];
    params = [params stringByAppendingFormat:@"%@=%@&", @"uiid",         self.uiid];
    params = [params stringByAppendingFormat:@"%@=%@&", @"meal_type",    [NSNumber numberWithInt:self.mealType]];
    params = [params stringByAppendingFormat:@"%@=%@&", @"file_name",    self.fileName];
    if (![self.storeName isEqualToString:@""]) {
        params = [params stringByAppendingFormat:@"%@=%@&", @"store_name",   self.storeName];
    }
    if (![self.menuName isEqualToString:@""]) {
        params = [params stringByAppendingFormat:@"%@=%@&", @"menu_name",   self.menuName];
    }
    params = [params stringByAppendingFormat:@"%@=%@&", @"amenity",  [NSNumber numberWithInt:self.amenity]];
    if (![self.comment isEqualToString:@""]) {
        params = [params stringByAppendingFormat:@"%@=%@&", @"comment",      self.comment];
    }
    params = [params stringByAppendingFormat:@"%@=%@&", @"star_num",        [NSNumber numberWithInt:self.starNum]];
    params = [params stringByAppendingFormat:@"%@=%@&", @"created_at",      self.createdAt];
    return params;
}

- (NSString *)url{
    return ASSETS_FILE_URL(self.fileName);
}

- (void)dealloc{
	self.createdAt = nil;
    self.uiid = nil;
    self.fileName = nil;
    self.storeName = nil;
    self.menuName = nil;
    self.comment = nil;
}

@end
