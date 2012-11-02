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




@property(nonatomic,strong) NSString* imageCacheKey;
@property(assign) int indexPathRow;
@property(nonatomic, strong) MSFoodPicture* foodPicture;
@property(nonatomic, strong) UIImage* foodImage;
@property(nonatomic, strong) UIImage* profileImage;
@property(assign)int height;


@end
