//
//  MSMiniCalenderCell.h
//  Meshi365
//
//  Created by Mlle.Irene on 2012/11/06.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSFoodPicture.h"
@interface MSMiniCalenderCell : UITableViewCell


@property(nonatomic,strong)UIActivityIndicatorView *foodImgIdctr;
@property(nonatomic, strong) UIImage* foodImage;
@property(nonatomic,strong)MSFoodPicture* foodPicture;


@end
