//
//  MSRecommendViewController.m
//  Meshi365
//
//  Created by Mlle.Irene on 2012/10/29.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSRecommendViewController.h"
#import "MSRecommendTableView.h"
@interface MSRecommendViewController ()

@end

@implementation MSRecommendViewController

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

	int height = [UIScreen mainScreen].bounds.size.height - 10;
	int width = [UIScreen mainScreen].bounds.size.width/3;
	int tableViewNum = 2;
	MSRecommendTableView *recommendTableView[tableViewNum];
	UILabel *label[tableViewNum];
	for( int i = 0 ; i < tableViewNum; i++)
	{
		label[i] = [[UILabel alloc]init];
		switch(i)
		{
			case 0:label[i].text = @"self data";
			case 1:label[i].text = @"others data";
		}
		label[i].backgroundColor = [UIColor colorWithRed:0.9 green:0.87 blue:0.92 alpha:1.0];
		label[i].frame = CGRectMake(i*width+2, 30, width, 30);
	
		
		
		recommendTableView[i] = [[MSRecommendTableView alloc]init];
		recommendTableView[i].bounces = YES;
		recommendTableView[i].frame = CGRectMake(i*width, 60, width, height);
		
		
		[self.view addSubview:recommendTableView[i]];
		[self.view addSubview:label[i]];
		
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
