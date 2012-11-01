//
//  MSFoodLineCell.h
//  Meshi365
//
//  Created by Mlle.Irene on 2012/10/28.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSFoodPicture.h"


@interface MSFoodLineCell : UITableViewCell


- (void)updateJsonData:(NSString*)imageUrl foodPicture:(MSFoodPicture*)foodPict image:(UIImage*)image;


@property(nonatomic,strong) NSString* imageCacheKey;
@property(nonatomic, strong) NSString* imageUrl;


@end
