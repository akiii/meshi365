//
//  MSUser.m
//  Meshi365
//
//  Created by Akifumi on 2012/10/30.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSUser.h"
#import "MSNetworkConnector.h"
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


- (id)initWithJson:(NSDictionary*)json
{
	if (self = [super init]) {
		NSDictionary *user = [json objectForKey:@"user"];
		self.name       = [user objectForKey:@"name"];
		self.uiid       = [user objectForKey:@"uiid"];
		self.fileName   = [user objectForKey:@"profile_image_file_name"];
		
		//NSLog(@"userName:%@",self.name);
		
	}
	return self;
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
    params = [params stringByAppendingFormat:@"%@=%@&", @"name",                    self.name];
    params = [params stringByAppendingFormat:@"%@=%@&", @"uiid",                    self.uiid];
    params = [params stringByAppendingFormat:@"%@=%@&", @"profile_image_file_name", self.fileName];
    return params;
}

- (NSString *)profileImageUrl{
    return ASSETS_FILE_URL(self.fileName);
}

- (void)dealloc{
    self.name = nil;
    self.uiid = nil;
    self.fileName = nil;
}


-(void)sendUserData
{
	[MSNetworkConnector requestToUrl:URL_OF_SIGN_UP method:RequestMethodPost params:self.params block:^(NSData *response) {
		NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:nil];
		if ([[jsonDic objectForKey:@"save"] boolValue]) {
			NSNumber *userId = [NSNumber numberWithInt:[[jsonDic objectForKey:kUserId] intValue]];
			NSString *uiid = [jsonDic objectForKey:kUIID];
			NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
			[ud setObject:userId forKey:kUserId];
			[ud setObject:uiid forKey:kUIID];
			[ud synchronize];
		}
	}];
}

@end
