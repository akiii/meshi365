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
	
	
	int tableViewNum = 3;
	MSMiniCalenderTableView *miniCalenderTableView[tableViewNum];
	
	for( int i = 0 ; i < tableViewNum; i++)
	{
		miniCalenderTableView[i] = [[MSMiniCalenderTableView alloc]init];
		
		int height = [UIScreen mainScreen].bounds.size.height - 10;
		int width = [UIScreen mainScreen].bounds.size.width/3;
		miniCalenderTableView[i].frame = CGRectMake(i*width, 10, width, height);
		
		[self.view addSubview: miniCalenderTableView[i]];
	}

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
