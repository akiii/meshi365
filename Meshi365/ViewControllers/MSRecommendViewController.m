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
		label[i].frame = CGRectMake(i*width+2, 30, width, 30);
	
		
		
		recommendTableView[i] = [[MSRecommendTableView alloc]init];
		recommendTableView[i].bounces = YES;
		recommendTableView[i].frame = CGRectMake(i*width, 60, width, height);
		
		
		[self.view addSubview:recommendTableView[i]];
		[self.view addSubview:label[i]];
		
	}
	
	
	
	
	[MSNetworkConnector requestToUrl:@"http://aqueous-brushlands-6933.herokuapp.com/food_pictures" method:RequestMethodGet params:nil block:^(NSData *response)
	 {
		 jsonArray = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:nil];
	 }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    static NSString *CellIdentifier = @"Cell";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier imageUrl:[MSAWSConnector foodPictureImageUrlFromJsonArray:jsonArray imageNum:indexPath.row] jsonData:jsonArray[indexPath.row] ];
	}
	
	return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	//todo セルのサイズに合わせてか可変を
	return 450;
	
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath != nil) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}



@end
