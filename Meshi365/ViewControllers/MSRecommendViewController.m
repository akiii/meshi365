//
//  MSRecommendViewController.m
//  Meshi365
//
//  Created by Mlle.Irene on 2012/10/29.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSRecommendViewController.h"
#import "MSRecommendTableView.h"
#import "MSNetworkConnector.h"
#import "MSAWSConnector.h"

@interface MSRecommendViewController ()
@property(nonatomic,strong) NSArray *selfRecommendJsonArray;
@property(nonatomic,strong) NSArray *otherRecommendJsonArray;

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
	
	
	int naviHeight = 44;
	UINavigationBar *naviBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, naviHeight)];
    naviBar.tintColor = [UIColor colorWithRed:1.0 green:0.80 blue:0.1 alpha:0.7];
    UINavigationItem *title = [[UINavigationItem alloc] initWithTitle:@"Recommend"];
    [naviBar pushNavigationItem:title animated:YES];
    [self.view addSubview:naviBar];
	
	
	
	
	
	//[MSNetworkConnector requestToUrl:URL_OF_POST_FOOD_PICTURE method:RequestMethodGet params:nil block:^(NSData *response)
	[MSNetworkConnector requestToUrl:URL_OF_FOOD_LINE( @"7C53178F-C613-4C26-ACD3-61BB069F3766") method:RequestMethodGet params:nil block:^(NSData *response)
	 
	 {
		 _selfRecommendJsonArray = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:nil];
	 }];
	
	
	[MSNetworkConnector requestToUrl:URL_OF_FOOD_LINE( @"EC9EE18E-E44F-4419-9105-9650711EED9F") method:RequestMethodGet params:nil block:^(NSData *response)
	 
	 //[MSNetworkConnector requestToUrl:URL_OF_POST_FOOD_PICTURE method:RequestMethodGet params:nil block:^(NSData *response)
	 {
		 _otherRecommendJsonArray = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:nil];
	 }];
	
	
	int height = [UIScreen mainScreen].bounds.size.height - 10;
	int width = [UIScreen mainScreen].bounds.size.width/2;
	int tableViewNum = 2;
	MSRecommendTableView *recommendTableView[tableViewNum];
	UILabel *label[tableViewNum];
	for( int i = 0 ; i < tableViewNum; i++)
	{
		label[i] = [[UILabel alloc]init];
		switch(i)
		{
			case 0:label[i].text = @"self data";	break;
			case 1:label[i].text = @"others data";	break;
		}
		label[i].backgroundColor = [UIColor colorWithRed:0.9 green:0.87 blue:0.92 alpha:1.0];
		label[i].frame = CGRectMake(i*width, naviHeight, width, 30);
		
		
		recommendTableView[i] = [[MSRecommendTableView alloc]init];
		if(i==0)recommendTableView[i].jsonArray = _selfRecommendJsonArray;
		else recommendTableView[i].jsonArray = _otherRecommendJsonArray;
		
		recommendTableView[i].bounces = YES;
		recommendTableView[i].frame = CGRectMake(i*width, naviHeight+30, width, height-naviHeight);
		
		[recommendTableView[i] loadImage ];
		
		
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
