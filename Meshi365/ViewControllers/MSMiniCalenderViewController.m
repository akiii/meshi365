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
	
	int tableViewNum = 30;

	UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
	scrollView.backgroundColor = [UIColor cyanColor];
	scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*tableViewNum/3.0f, 0);
	scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.showsVerticalScrollIndicator = NO;
	scrollView.bounces = NO;
	scrollView.pagingEnabled = YES;
	
	
	
	
	
	MSMiniCalenderTableView *miniCalenderTableView[tableViewNum];
	UILabel *dayLabel[tableViewNum];
	UILabel *monthLabel[tableViewNum];
	for( int i = 0 ; i < tableViewNum; i++)
	{
		miniCalenderTableView[i] = [[MSMiniCalenderTableView alloc]init];
		miniCalenderTableView[i].bounces = YES;
		
		dayLabel[i] = [[UILabel alloc]init];
		monthLabel[i] = [[UILabel alloc]init];
		
		
		NSDate* date= [NSDate dateWithTimeIntervalSinceNow: -24*60*60 * i];
		NSCalendar *calendar = [NSCalendar currentCalendar];
		NSDateComponents *dateComps = [calendar components:NSDayCalendarUnit|NSMonthCalendarUnit fromDate:date];
		if(i == 0)
		{
			dayLabel[i].text = @"Today";
		}
		else
		{
			dayLabel[i].text = [NSString stringWithFormat:@"%2d",dateComps.day];
		}
		
		monthLabel[i].text = [NSString stringWithFormat:@"%2d",dateComps.month];

		
		dayLabel[i].backgroundColor = [UIColor colorWithRed:0.9 green:0.87 blue:0.92 alpha:1.0];
		
		
		int height = [UIScreen mainScreen].bounds.size.height - 10;
		int width = [UIScreen mainScreen].bounds.size.width/3;
		miniCalenderTableView[i].frame = CGRectMake(i*width, 60, width, height);
		
		dayLabel[i].frame = CGRectMake(i*width, 30, width, 30);
		monthLabel[i].frame = CGRectMake(i*width, 0, width, 30);
		
		[scrollView addSubview:miniCalenderTableView[i]];
		[scrollView addSubview:dayLabel[i]];
		[scrollView addSubview:monthLabel[i]];

	}
	
	[self.view addSubview:scrollView];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
