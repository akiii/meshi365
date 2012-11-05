//
//  MSFoodLineViewController.m
//  Meshi365
//
//  Created by Mlle.Irene on 2012/10/28.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSFoodLineViewController.h"

#import "MSFoodLineCell.h"
#import "MSNetworkConnector.h"
#import "MSAWSConnector.h"
#import "MSImageLoader.h"
#import "MSImageCache.h"

@interface MSFoodLineViewController ()
@property(nonatomic,strong)	UITableView *tableView;
@property(assign)NSString* uiid;


@end

@implementation MSFoodLineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
	 	
    }
    return self;
}

- (id)initWithUiid:(NSString *)uiid
{
    self = [super init ];
    if (self) {
		_uiid = uiid;
	}
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.navigationItem.title = @"Food Line";
    
    UIBarButtonItem *btn =
	[[UIBarButtonItem alloc] initWithTitle:@"Friend" style:UIBarButtonItemStylePlain target:self action:@selector(moveFriend)];
    self.navigationItem.rightBarButtonItem = btn;
	
	_tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	_tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
	_tableView.dataSource = self;
    _tableView.delegate = self;
	_tableView.backgroundColor =  [UIColor colorWithRed:1.0 green:0.80 blue:0.1 alpha:1.0];;
    [self.view addSubview:_tableView];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	
	
	NSLog(@"Your UIID:%@",[[MSUser currentUser] uiid]);
	NSLog(@"View UIID:%@",_uiid);
	
	[MSNetworkConnector requestToUrl:URL_OF_FOOD_LINE(_uiid) method:RequestMethodGet params:nil block:^(NSData *response)
	 
	 {
		 _jsonArray = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:nil];
	 }];
	
	
	
	NSMutableArray* jsonMutableArray =  [NSMutableArray arrayWithArray:_jsonArray];
	NSLog(@"!!!mu json:%@",jsonMutableArray);

	if( ![[[MSUser currentUser] uiid] isEqualToString:_uiid] )
	{
		for(int i = 0; i < jsonMutableArray.count; i++)
		{
			MSFoodPicture* foodPict = [[MSFoodPicture alloc]initWithJson:jsonMutableArray[i]];
			if( ![_uiid isEqualToString:foodPict.user.uiid] )
			{
				[jsonMutableArray removeObjectAtIndex:i];
				i--;
			}
		}
	}
	_jsonArray = [NSArray arrayWithArray:jsonMutableArray];
	NSLog(@"mu json:%@",jsonMutableArray);

	
	NSLog(@"JsonArray %@",_jsonArray);
	
	
	[self loadImages];
	
	[_tableView reloadData];
	
	
}

-(void)loadImages{
	//HACK:デバグ用表示のため、敢えてFoodImageとProfileImageのループを分けている。
	NSLog(@"Start Load Food Image");
	for( int i = 0; i < _jsonArray.count;i++)
	{
		MSFoodPicture* foodPicture = [[MSFoodPicture alloc] initWithJson:_jsonArray[i]];
		
		[MSImageLoader ImageLoad:foodPicture.url tableView:_tableView];
	}
	
	
	NSLog(@"Start Load profile Image");
	for( int i = 0; i < _jsonArray.count;i++)
	{
		MSFoodPicture* foodPicture = [[MSFoodPicture alloc] initWithJson:_jsonArray[i]];
		[MSImageLoader ImageLoad:foodPicture.user.profileImageUrl tableView:_tableView];
	}
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _jsonArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    MSFoodLineCell *cell =[_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell =[[MSFoodLineCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
	}
	
	MSFoodPicture *foodPicture = [[MSFoodPicture alloc]initWithJson: _jsonArray[indexPath.row] ];
	cell.indexPathRow = indexPath.row;
	cell.foodPicture = foodPicture;
	
	
	MSImageCache* cache = [MSImageCache sharedManager];
	
	
	//set food image
	if([cache.image objectForKey:foodPicture.url] )
		cell.foodImage = [cache.image objectForKey:foodPicture.url];
	else
		cell.foodImage = [UIImage imageNamed:@"star.png"];
	
	
	//set profile image
	if([cache.image objectForKey:foodPicture.user.profileImageUrl])
		cell.profileImage = [cache.image objectForKey:foodPicture.user.profileImageUrl];
	else
		cell.profileImage = [UIImage imageNamed:@"star.png"];
	
	
	
	[cell layoutSubviews];
	return cell;
}



- (CGFloat)tableView:(UITableView *)tv heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	MSFoodLineCell *cell = (MSFoodLineCell*)[self tableView:_tableView cellForRowAtIndexPath:indexPath];
    return cell.height;
}


- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath != nil) {
        [_tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}

-(void)moveFriend{
    MSFriendListViewController *friendListVC = [[MSFriendListViewController alloc]init];
    [self.navigationController pushViewController:friendListVC animated:YES];
}

@end
