//
//  MSFoodLineCell.h
//  Meshi365
//
//  Created by Mlle.Irene on 2012/10/28.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSFoodLineCell : UITableViewCell


- (void)updateJsonData:(NSURL*)imageUrl  jsonData:(NSDictionary*)jsonData imageCache:(NSCache*)imageCache imageCacheKey:(NSString*)imageCacheKey;


@property(nonatomic,strong) NSString* imageCacheKey;


@end
