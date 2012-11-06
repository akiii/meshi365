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
#import "MSFoodLineCell.h"

@interface MSMiniCalenderViewController ()
@property(nonatomic,strong) NSArray *jsonArray;
@property(assign)int fixWidth;
@end

@implementation MSMiniCalenderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		_fixWidth = 10;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	

}

-(void)viewDidAppear:(BOOL)animated
{
	
	
	NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
	[outputFormatter setDateFormat:@"yyyy-MM-dd"];
	
	int tableViewNum = 9;
	NSDate *sinceDate =  [NSDate dateWithTimeIntervalSinceNow:-(tableViewNum-1)*24*60*60];
	NSDate *toDate =  [NSDate dateWithTimeIntervalSinceNow:1*24*60*60];

	NSString *sinceDateString = [outputFormatter stringFromDate:sinceDate];
	NSString *toDateString = [outputFormatter stringFromDate:toDate];
	

	
	NSString *params = [NSString string];
	params = [params stringByAppendingFormat:@"%@=%@&", @"my_uiid", [MSUser currentUser].uiid];
	params = [params stringByAppendingFormat:@"%@=%@&", @"since_date",sinceDateString];
			  params = [params stringByAppendingFormat:@"%@=%@&", @"to_date", toDateString];
	[MSNetworkConnector requestToUrl:URL_OF_CALENDER([MSUser currentUser].uiid) method:RequestMethodPost params:params block:^(NSData *response)
	 {
		 _jsonArray = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:nil];
		 
		 NSLog(@"json : %@", _jsonArray);
	 }];
	
	int naviHeight = 44;
	UINavigationBar *naviBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, naviHeight)];
    naviBar.tintColor = [UIColor colorWithRed:1.0 green:0.80 blue:0.1 alpha:0.7];
    UINavigationItem *title = [[UINavigationItem alloc] initWithTitle:@"MiniCalender"];
    [naviBar pushNavigationItem:title animated:YES];
    [self.view addSubview:naviBar];
	
	
	
	scrollView = [[MSMiniCalenderScrollView alloc] initWithFrame:self.view.bounds];
	scrollView.frame = CGRectMake(0, naviHeight, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - naviHeight);
	[scrollView setLayout:tableViewNum];
	
	int x = [UIScreen mainScreen].bounds.size.width/3.0f * ( tableViewNum -4 ) + _fixWidth;
	[scrollView setContentOffset:CGPointMake(x , 0.0f) animated:YES];
	[scrollView fixScrollOffset];

	
	[self loadEachTableImage:tableViewNum];
	[self.view addSubview:scrollView];
		
	NSLog(@".....viewDidLoad done");	
}





-(void)loadEachTableImage:(int)maxViewNum
{
	float width = [UIScreen mainScreen].bounds.size.width/3-_fixWidth;
	UILabel *dayLabel[maxViewNum];
	MSMiniCalenderTableView *miniTable[maxViewNum];

	
	NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
	[outputFormatter setDateFormat:@"yyyy-MM-dd"];

	
	for( int i = 0 ; i < maxViewNum; i++)
	{
		NSLog(@".....making miniCal:[%d]",i);
		
		float x = (maxViewNum - i-1)*width;
		miniTable[i] = [[MSMiniCalenderTableView alloc]init];
		miniTable[i].bounces = YES;
		miniTable[i].separatorColor = [UIColor clearColor];
		//miniTable[i].frame = CGRectMake(x, naviHeight+14, width, height - (naviHeight+58));
		
		NSMutableArray* jsonOneDayArray = [[NSMutableArray alloc]init];
		for(int j = 0; j < _jsonArray.count; j++)
		{
			
			NSDate *oldDay =  [NSDate dateWithTimeIntervalSinceNow:-(i+1)*24*60*60];
			NSString *toDateString = [outputFormatter stringFromDate:oldDay];
			MSFoodPicture *foodPicture = [[MSFoodPicture alloc]initWithJson:_jsonArray[j]];
			NSRange searchResult = [foodPicture.createdAt rangeOfString:toDateString];
			if(searchResult.location != NSNotFound)
			{
				[jsonOneDayArray addObject:_jsonArray[j]];
			}
		}
		
		for(int i = 1; i < jsonOneDayArray.count; i++)
		{
			MSFoodPicture *pre = [[MSFoodPicture alloc] initWithJson:jsonOneDayArray[i-1]];
			MSFoodPicture *current = [[MSFoodPicture alloc] initWithJson:jsonOneDayArray[i]];

			if(pre.mealType > current.mealType)
			{
				NSDictionary *tmp = jsonOneDayArray[i];
				jsonOneDayArray[i] = jsonOneDayArray[i-1];
				jsonOneDayArray[i-1] = tmp;
				
				i-=2;
				if(i < 0)i=0;
			}
		}
		
		
		
		
		
		
		NSLog(@".....set json done:[%d]",_jsonArray.count);
		miniTable[i].jsonArray = jsonOneDayArray;
		[miniTable[i] loadImage];
		miniTable[i].frame =CGRectMake(x, 40,width,  self.view.frame.size.height - 40-43);
		
		
		
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateFormat:@"MMMM"];
		NSString *currentMonth = [formatter stringFromDate:[NSDate date]];
		NSString *preMonth = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:-i*24*60*60]];
		
		
		
		UILabel *monthLabel= [[UILabel alloc]init];
		monthLabel.frame = CGRectMake(x, 0, width, 20);
		monthLabel.textAlignment = NSTextAlignmentLeft;
		
		
		
		dayLabel[i] = [[UILabel alloc]init];
		NSDate* date= [NSDate dateWithTimeIntervalSinceNow: -24*60*60 * i];
		NSCalendar *calendar = [NSCalendar currentCalendar];
		NSDateComponents *dateComps = [calendar components:NSDayCalendarUnit|NSMonthCalendarUnit fromDate:date];
		dayLabel[i].text = [NSString stringWithFormat:@"%2d",dateComps.day];
		dayLabel[i].frame = CGRectMake(x, 20, width, 20);

		
		if(i == 0)
		{
			dayLabel[i].backgroundColor = COLOR_TODAY;
			monthLabel.backgroundColor = COLOR_CURRENT;
			monthLabel.text = currentMonth;
		}
		else if(![currentMonth isEqualToString:preMonth])
		{
			dayLabel[i].backgroundColor = COLOR_PAST;
			monthLabel.backgroundColor = COLOR_PAST;
			monthLabel.text = preMonth;
		}
		else{
			dayLabel[i].backgroundColor = COLOR_CURRENT;
			monthLabel.backgroundColor  = COLOR_CURRENT;
			monthLabel.text = [NSString stringWithFormat:@""];
		}
		
		
		[scrollView addSubview:miniTable[i]];
		[scrollView addSubview:dayLabel[i]];
		[scrollView addSubview:monthLabel];
		
		
	}
	

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
