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


@interface MSFoodLineViewController ()
@property(nonatomic,strong)	UITableView *tableView;

@end

@implementation MSFoodLineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		
		
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
	self.navigationItem.title = @"Food Line";
    
    UIBarButtonItem *btn =
	[[UIBarButtonItem alloc]
	 initWithTitle:@"Friend"  // 画像を指定
	 style:UIBarButtonItemStylePlain  // スタイルを指定（※下記表参照）
	 target:self  // デリゲートのターゲットを指定
	 action:@selector(moveFriend)  // ボタンが押されたときに呼ばれるメソッドを指定
	 ];
    self.navigationItem.rightBarButtonItem = btn;
	
	_tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	_tableView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	_imageCache = [[NSCache alloc] init];
	_imageRequestCache = [[NSCache alloc] init];
	_profileImageCache = [[NSCache alloc] init];
	_profileImageRequestCache = [[NSCache alloc] init];
	//        _imageCache.countLimit = 20;
	//        _imageCache.totalCostLimit = 640 * 480 * 10;
	

	NSLog(@"your uiid:%@",[[MSUser currentUser] uiid]);
	[MSNetworkConnector requestToUrl:URL_OF_FOOD_LINE( [[MSUser currentUser] uiid]) method:RequestMethodGet params:nil block:^(NSData *response)
	 {
		 jsonArray = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:nil];
		 
		 NSLog(@"JsonArray %@",jsonArray);
	 }];
	
	
	
//	for( int i = 0; i < jsonArray.count;i++)
//	{
//		MSFoodPicture *foodPicture = [[MSFoodPicture alloc]init: jsonArray[i] ];
//		
//		dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
//		dispatch_async(q_global, ^{
//			NSLog(@"...... load start:%d", i);
//			
//			NSURL *foodImageAccessKeyUrl = [MSAWSConnector getS3UrlFromString:foodPicture.url];
//			NSData* data = [NSData dataWithContentsOfURL:foodImageAccessKeyUrl];
//			UIImage* image = [[UIImage alloc] initWithData:data];
//			
//			[_imageCache setObject:image forKey:foodPicture.url];
//			[_tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
//		});
//		
//		
//		if(![_profileImageCache objectForKey:foodPicture.user.profileImageUrl])
//		{
//			dispatch_queue_t q_globalProfile = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//			dispatch_async(q_globalProfile, ^{
//				NSURL *profileImageAccessKeyUrl = [MSAWSConnector getS3UrlFromString:foodPicture.user.profileImageUrl];
//				NSData* data = [NSData dataWithContentsOfURL:profileImageAccessKeyUrl];
//				UIImage* image = [[UIImage alloc] initWithData:data];
//				
//				NSLog(@"ProfileImg loaded:%d",i);
//				[_profileImageCache setObject:image forKey:foodPicture.user.profileImageUrl];
//				[_tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
//				
//			});
//			
//		}
//	}



	[_tableView reloadData];
	
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return jsonArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";	
    MSFoodLineCell *cell =[_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell =[[MSFoodLineCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];		
	}
	
	NSLog(@"!!Cell updated:[%d]",indexPath.row);

	MSFoodPicture *foodPicture = [[MSFoodPicture alloc]init: jsonArray[indexPath.row] ];
	cell.indexPathRow = indexPath.row;
	
	//[NSCopyMemoryPages(foodPicture, cell.foodPicture,sizeof(MSFoodPicture))];
	
	//load food image
	if([_imageCache objectForKey:foodPicture.url] )
	{
		cell.foodImage = [_imageCache objectForKey:foodPicture.url];
	}
	else
	{
		cell.foodImage = [UIImage imageNamed:@"star.png"];
	}
	
	
	//load profile
	if([_profileImageCache objectForKey:foodPicture.user.profileImageUrl])
	{
		cell.profileImage = [_profileImageCache objectForKey:foodPicture.user.profileImageUrl];
	}
	else{
		cell.profileImage = [UIImage imageNamed:@"star.png"];
	}
	
	cell.foodPicture = foodPicture;
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
