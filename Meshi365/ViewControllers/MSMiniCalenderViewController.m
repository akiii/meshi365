//
//  MSMiniCalenderViewController.m
//  Meshi365
//
//  Created by Mlle.Irene on 2012/10/29.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSMiniCalenderViewController.h"
#import "MSMiniCalenderTableView.h"
#import "MSUser.h"
#import "MSNetworkConnector.h"

@interface MSMiniCalenderViewController ()
@property(nonatomic,strong) NSArray *jsonArray;

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
	
	int naviHeight = 44;
	UINavigationBar *naviBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, naviHeight)];
    naviBar.tintColor = [UIColor colorWithRed:1.0 green:0.80 blue:0.1 alpha:0.7];
    UINavigationItem *title = [[UINavigationItem alloc] initWithTitle:@"MiniCalender"];
    [naviBar pushNavigationItem:title animated:YES];
    [self.view addSubview:naviBar];

	
	int tableViewNum = 10;

	scrollView = [[MSMiniCalenderScrollView alloc] initWithFrame:self.view.bounds];
	scrollView.frame = CGRectMake(0, naviHeight, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - naviHeight);
	[scrollView setLayout:tableViewNum];

	
	
	int height = [UIScreen mainScreen].bounds.size.height - 10;
	int width = [UIScreen mainScreen].bounds.size.width/3;
	MSMiniCalenderTableView *miniCalenderTableView[tableViewNum];
	UILabel *dayLabel[tableViewNum];
	UILabel *monthLabel= [[UILabel alloc]init];
	for( int i = 0 ; i < tableViewNum; i++)
	{
		miniCalenderTableView[i] = [[MSMiniCalenderTableView alloc]init];
		miniCalenderTableView[i].bounces = YES;
		miniCalenderTableView[i].frame = CGRectMake(i*width, naviHeight+14, width, height);
		//miniCalenderTableView[i].day = i;
		
		dayLabel[i] = [[UILabel alloc]init];
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
		dayLabel[i].backgroundColor = [UIColor colorWithRed:0.9 green:0.87 blue:0.92 alpha:1.0];
		dayLabel[i].frame = CGRectMake(i*width+2, naviHeight-14, width, 30);
		
		
		
		[scrollView addSubview:miniCalenderTableView[i]];
		[scrollView addSubview:dayLabel[i]];
	
	}
	

	
	monthLabel.frame = CGRectMake(0, naviHeight, [UIScreen mainScreen].bounds.size.width, 30);
	monthLabel.textAlignment = NSTextAlignmentCenter;
	//	monthLabel.text = [NSString stringWithFormat:@"%2d",dateComps.month];
	monthLabel.text = [NSString stringWithFormat:@"JUN/MAY"];

	
	[self.view addSubview:scrollView];
	[self.view addSubview:monthLabel];


}

-(void)viewDidAppear:(BOOL)animated
{
	NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
	[outputFormatter setDateFormat:@"yyyy-MM-dd"];
	NSString *sinceDateString = @"2012-11-01";
	NSString *toDateString = @"2012-11-8";
	
	NSString *params = [NSString string];
	params = [params stringByAppendingFormat:@"%@=%@&", @"my_uiid", [MSUser currentUser].uiid];
	params = [params stringByAppendingFormat:@"%@=%@&", @"since_date", sinceDateString];
	
	params = [params stringByAppendingFormat:@"%@=%@&", @"to_date", toDateString];
	[MSNetworkConnector requestToUrl:URL_OF_CALENDER([MSUser currentUser].uiid) method:RequestMethodPost params:params block:^(NSData *response) {
		_jsonArray = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:nil];
		
		NSLog(@"json : %@", _jsonArray);
	}];

	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
