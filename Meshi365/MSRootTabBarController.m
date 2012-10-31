//
//  MSRootTabBarController.m
//  Meshi365
//
//  Created by Mlle.Irene on 2012/10/29.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSRootTabBarController.h"

@interface MSRootTabBarController ()
@end

@implementation MSRootTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
 		
        self.view.backgroundColor = [UIColor blackColor];
        
		self.todayMEalViewController	= [[MSTodayMealViewController alloc]init];
		self.foodLineViewController		= [[MSFoodLineViewController alloc]init];
		self.miniCalenderViewController	= [[MSMiniCalenderViewController alloc]init];
		self.recommendViewController	= [[MSRecommendViewController alloc]init];
		self.configViewController		= [[MSConfigViewController alloc]init];
		
		
		self.todayMEalViewController.title = @"Today";
		self.foodLineViewController.title = @"FoodLine";
		self.miniCalenderViewController.title = @"MiniCal";
		self.recommendViewController.title = @"Recommend";
		self.configViewController.title = @"Config";

		
		NSArray *views = [NSArray arrayWithObjects:self.todayMEalViewController, self.foodLineViewController, self.miniCalenderViewController, self. recommendViewController, self.configViewController, nil];
		[self setViewControllers:views animated:NO];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
