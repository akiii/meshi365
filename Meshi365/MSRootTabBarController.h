//
//  MSRootTabBarController.h
//  Meshi365
//
//  Created by Mlle.Irene on 2012/10/29.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MSTodayMealViewController.h"
#import "MSFoodLineViewController.h"
#import "MSMiniCalenderViewController.h"
#import "MSRecommendViewController.h"
#import "MSConfigViewController.h"

@interface MSRootTabBarController : UITabBarController

@property MSTodayMealViewController *todayMEalViewController;
@property MSFoodLineViewController *foodLineViewController;
@property MSMiniCalenderViewController *miniCalenderViewController;
@property MSRecommendViewController *recommendViewController;
@property MSConfigViewController *configViewController;

@end
