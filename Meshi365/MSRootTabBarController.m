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
        
        MSFoodLineViewController *view0 = [[MSFoodLineViewController alloc]initWithUiid:[[MSUser currentUser] uiid]];
        MSConfigViewController *view1 = [[MSConfigViewController alloc]init];
        
		self.todayMEalViewController	= [[MSTodayMealViewController alloc]init];
		self.foodLineNavigationViewController		= [[MSFoodLineNavigationViewController alloc]initWithRootViewController:view0];
		self.miniCalenderViewController	= [[MSMiniCalenderViewController alloc]init];
		self.recommendViewController	= [[MSRecommendViewController alloc]init];
		self.accountNavigationController		= [[MSAccountNavigationController alloc]initWithRootViewController:view1];
		
		/*
        self.todayMEalViewController.title = @"Today";
		self.foodLineNavigationViewController.title = @"FoodLine";
		self.miniCalenderViewController.title = @"MiniCal";
		self.recommendViewController.title = @"Recommend";
		self.configViewController.title = @"Account";
        */
        self.todayMEalViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Today"
                                                                                image:[UIImage imageNamed:@"tabicon_today.png"]
                                                                                  tag:0];
        self.foodLineNavigationViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"FoodLine"
                                                                                         image:[UIImage imageNamed:@"tabicon_foodline.png"]
                                                                                           tag:1];
        self.miniCalenderViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"MiniCal"
                                                                                   image:[UIImage imageNamed:@"tabicon_minical.png"]
                                                                                     tag:2];
        self.recommendViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Recommend"
                                                                                image:[UIImage imageNamed:@"tabicon_recommend.png"]
                                                                                  tag:3];
        self.accountNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Account"
                                                                             image:[UIImage imageNamed:@"tabicon_account.png"]
                                                                               tag:4];

		NSArray *views = [NSArray arrayWithObjects:self.todayMEalViewController, self.foodLineNavigationViewController, self.miniCalenderViewController, self. recommendViewController, self.accountNavigationController, nil];
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
