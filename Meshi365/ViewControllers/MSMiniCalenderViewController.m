//
//  MSMiniCalenderViewController.m
//  Meshi365
//
//  Created by Mlle.Irene on 2012/10/29.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSMiniCalenderViewController.h"
#import "MSMiniCalenderTableView.h"


@interface MSMiniCalenderViewController ()

@end

@implementation MSMiniCalenderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	MSMiniCalenderTableView *miniCalenderTableView;
	miniCalenderTableView = [[MSMiniCalenderTableView alloc]init];
	
	
	[self.view addSubview: miniCalenderTableView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
