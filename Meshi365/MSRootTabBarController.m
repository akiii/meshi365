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
        
        MSFoodLineViewController *view = [[MSFoodLineViewController alloc]init];
        
		self.todayMEalViewController	= [[MSTodayMealViewController alloc]init];
		self.foodLineNavigationViewController		= [[MSFoodLineNavigationViewController alloc]initWithRootViewController:view];
		self.miniCalenderViewController	= [[MSMiniCalenderViewController alloc]init];
		self.recommendViewController	= [[MSRecommendViewController alloc]init];
		self.configViewController		= [[MSConfigViewController alloc]init];
		
		self.todayMEalViewController.title = @"Today";
		self.foodLineNavigationViewController.title = @"FoodLine";
		self.miniCalenderViewController.title = @"MiniCal";
		self.recommendViewController.title = @"Recommend";
		self.configViewController.title = @"Account";

		NSArray *views = [NSArray arrayWithObjects:self.todayMEalViewController, self.foodLineNavigationViewController, self.miniCalenderViewController, self. recommendViewController, self.configViewController, nil];
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
