//
//  MSTodayMealViewController.h
//  Meshi365
//
//  Created by Mlle.Irene on 2012/10/29.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSCameraViewController.h"
#import "MSValueImageViewController.h"

@interface MSTodayMealViewController : UIViewController{
    UIImageView *breakfastImageView;
    UIImageView *lunchImageView;
    UIImageView *supperImageView;
    
    MSCameraViewController *msCamera;
    CGSize no_image_size;
}

@end
