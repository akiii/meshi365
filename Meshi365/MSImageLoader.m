//
//  MSImageLoader.m
//  Meshi365
//
//  Created by Mlle.Irene on 2012/11/03.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSImageLoader.h"
#import "MSAWSConnector.h"
#import "MSImageCache.h"



@implementation MSImageLoader

static MSImageLoader* sharedHistory = nil;

+ (MSImageLoader*)sharedManager {
    @synchronized(self) {
        if (sharedHistory == nil) {
            sharedHistory = [[self alloc] init];
        }
    }
    return sharedHistory;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (sharedHistory == nil) {
            sharedHistory = [super allocWithZone:zone];
            return sharedHistory;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone*)zone {
    return self;  // シングルトン状態を保持するため何もせず self を返す
}



-(void)ImageLoad:(NSString*)url tableView:(UITableView*)tableView
{
	MSImageCache* cache = [MSImageCache sharedManager];
		
	if([cache.imageRequest objectForKey:url])return;
	if([cache.image objectForKey:url])return;
	[cache.imageRequest setObject:@"lock" forKey:url];
	
	
	
	NSLog(@"Image load start:%@", url);
	dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
	dispatch_async(q_global, ^{
		
		NSURL *foodImageAccessKeyUrl = [MSAWSConnector getS3UrlFromString:url];
		NSData* data = [NSData dataWithContentsOfURL:foodImageAccessKeyUrl];
		UIImage* image = [[UIImage alloc] initWithData:data];
		
		if(image != nil)
		{
			NSLog(@"Image load done:%@", url);
			[cache.image setObject:image forKey:url];
			[tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];			
		}
	});
}

@end
