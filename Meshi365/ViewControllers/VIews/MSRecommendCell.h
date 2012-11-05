//
//  MSRecommendCell.h
//  Meshi365
//
//  Created by Mlle.Irene on 2012/10/30.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSFoodPictureImage.h"

@interface MSRecommendCell : UITableViewCell
@property(assign)int height;
@property(nonatomic, strong) MSFoodPicture* foodPicture;
@property(nonatomic,strong)UIImage* foodImage;
@property(nonatomic,strong)UIActivityIndicatorView *foodImgIdctr;



- (void)updateJsonData:(NSURL*)imageUrl jsonData:(NSDictionary*)jsonData
;


@end
