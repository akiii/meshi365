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

@property (nonatomic, strong) MSTodayMealViewController *todayMEalViewController;
@property (nonatomic, strong) MSFoodLineViewController *foodLineViewController;
@property (nonatomic, strong) MSMiniCalenderViewController *miniCalenderViewController;
@property (nonatomic, strong) MSRecommendViewController *recommendViewController;
@property (nonatomic, strong) MSConfigViewController *configViewController;

@end
