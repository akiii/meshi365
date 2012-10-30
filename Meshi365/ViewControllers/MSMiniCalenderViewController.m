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
	
	
	UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
	scrollView.backgroundColor = [UIColor cyanColor];
	scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*5/3.0f, 0);
	scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.showsVerticalScrollIndicator = NO;
	scrollView.bounces = NO;
	scrollView.pagingEnabled = YES;
	
	
	
	
	
	int tableViewNum = 7;
	MSMiniCalenderTableView *miniCalenderTableView[tableViewNum];
	
	for( int i = 0 ; i < tableViewNum; i++)
	{
		miniCalenderTableView[i] = [[MSMiniCalenderTableView alloc]init];
		miniCalenderTableView[i].bounces = NO;
		
		
		
		
		if(i == 0)miniCalenderTableView[i].tableName = @"Today";
		else
		{
			NSDate* date= [NSDate dateWithTimeIntervalSinceNow: 24*60*60 * i];
			NSCalendar *calendar = [NSCalendar currentCalendar];
			NSDateComponents *dateComps = [calendar components:NSDayCalendarUnit fromDate:date];
			
			miniCalenderTableView[i].tableName = [NSString stringWithFormat:@"%02d",dateComps.day];
		}
		
		
		int height = [UIScreen mainScreen].bounds.size.height - 10;
		int width = [UIScreen mainScreen].bounds.size.width/3;
		miniCalenderTableView[i].frame = CGRectMake(i*width, 10, width, height);
		
		[scrollView addSubview:miniCalenderTableView[i]];
	}
	
	[self.view addSubview:scrollView];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
