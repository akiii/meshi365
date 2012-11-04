//
//  MSImageLoader.m
//  Meshi365
//
//  Created by Mlle.Irene on 2012/11/03.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSImageLoader.h"
#import "MSAWSConnector.h"

@implementation MSImageLoader


+(void)ImageLoad:(MSFoodPicture*)foodPicture tableView:(UITableView*)tableView imageCache:(NSCache*)imageCache requestCache:(NSCache*)requestCache
{
	
	if(requestCache != nil)
	{
		if([requestCache objectForKey:foodPicture.url])return;
		
		[requestCache setObject:@"lock" forKey:foodPicture.url];
	}
	
	
	//load images
	dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
	dispatch_async(q_global, ^{
		NSLog(@"Image load start:%@", foodPicture.url);
		
		NSURL *foodImageAccessKeyUrl = [MSAWSConnector getS3UrlFromString:foodPicture.url];
		NSData* data = [NSData dataWithContentsOfURL:foodImageAccessKeyUrl];
		UIImage* image = [[UIImage alloc] initWithData:data];
		
		if(image != nil)
		{
			NSLog(@"Image load done:%@", foodPicture.url);
			
			[imageCache setObject:image forKey:foodPicture.url];
			[tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
			
			
		}
	});
}

@end
