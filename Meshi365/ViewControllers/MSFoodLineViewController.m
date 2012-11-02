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
        // Custom initialization
		_imageCache = [[NSCache alloc] init];
		_profileImageCache = [[NSCache alloc] init];
		//        _imageCache.countLimit = 20;
		//        _imageCache.totalCostLimit = 640 * 480 * 10;
		
		
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    /*
	 int naviHeight = 44;
	 UINavigationBar *naviBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, naviHeight)];
	 naviBar.tintColor = [UIColor colorWithRed:1.0 green:0.80 blue:0.1 alpha:0.7];
	 UINavigationItem *title = [[UINavigationItem alloc] initWithTitle:@"Food Line"];
	 [naviBar pushNavigationItem:title animated:YES];
	 [self.view addSubview:naviBar];
	 */
    
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
	
	
	NSLog(@"your uiid:%@",[[MSUser currentUser] uiid]);
	[MSNetworkConnector requestToUrl:URL_OF_FOOD_LINE( [[MSUser currentUser] uiid]) method:RequestMethodGet params:nil block:^(NSData *response)
	 {
		 jsonArray = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:nil];
		 
		 NSLog(@"JsonArray %@",jsonArray);
	 }];
	
	
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
	
	
	MSFoodPicture *foodPicture = [[MSFoodPicture alloc]init: jsonArray[indexPath.row] ];
	cell.indexPathRow = indexPath.row;
	cell.foodPicture = foodPicture;
	[cell layoutSubviews];

	NSLog(@".........cell make[%d]",indexPath.row);
	
	
	
	//if( cell.indexPathRow == indexPath.row)[cell layoutSubviews];
	
	
	//NSLog(@"......make access key %d",indexPath.row);
	NSURL *foodImageAccessKeyUrl = [MSAWSConnector getS3UrlFromString:cell.foodPicture.url];
	NSURL *profileImageAccessKeyUrl = [MSAWSConnector getS3UrlFromString:cell.foodPicture.user.profileImageUrl];
	
	
	//load food image
	if([_imageCache objectForKey:cell.foodPicture.url] )
	{
		cell.foodImage = [_imageCache objectForKey:cell.foodPicture.url];
		//	cell.foodPicture = [[MSFoodPicture alloc]init: jsonArray[cell.indexPathRow]];
		
	}
	else
	{
		//NSLog(@"......no ImageCache:%d",indexPath.row);
		cell.foodImage = [UIImage imageNamed:@"star.png"];
		
		dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
		dispatch_queue_t q_main = dispatch_get_main_queue();
		dispatch_async(q_global, ^{
			NSLog(@"...... load start:%d",indexPath.row);
			NSData* data = [NSData dataWithContentsOfURL:foodImageAccessKeyUrl];
			UIImage* image = [[UIImage alloc] initWithData:data];
			
			
			dispatch_async(q_main, ^{
				//NSLog(@"...... %@",imageUrl);
				//NSLog(@"...... %@",cell.imageUrl);
				if( cell.indexPathRow == indexPath.row)
				{
					[_imageCache setObject:image forKey:cell.foodPicture.url];
					
					cell.foodImage = image;//[_imageCache objectForKey:foodPicture.url];
										   //cell.foodPicture = [[MSFoodPicture alloc]init: jsonArray[cell.indexPathRow]];
					[cell layoutSubviews];
				}
				
				NSLog(@"...... load done:%d",indexPath.row);
			});
		});
	}
	
	
	
	//load profile
	if([_profileImageCache objectForKey:cell.foodPicture.user.profileImageUrl])
	{
		cell.profileImage = [_profileImageCache objectForKey:cell.foodPicture.user.profileImageUrl];
		//cell.foodPicture = [[MSFoodPicture alloc]init: jsonArray[cell.indexPathRow]];
		
	}
	else{
		cell.profileImage = [UIImage imageNamed:@"star.png"];
		
		dispatch_queue_t q_globalProfile = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
		dispatch_queue_t q_mainProfile = dispatch_get_main_queue();
		dispatch_async(q_globalProfile, ^{
			NSData* data = [NSData dataWithContentsOfURL:profileImageAccessKeyUrl];
			UIImage* image = [[UIImage alloc] initWithData:data];
			
			
			dispatch_async(q_mainProfile, ^{
				if( cell.indexPathRow == indexPath.row)
				{
					[_profileImageCache setObject:image forKey:cell.foodPicture.user.profileImageUrl];
					cell.profileImage = image;
					//cell.foodPicture = [[MSFoodPicture alloc]init: jsonArray[indexPath.row]];

					[cell layoutSubviews];
				}
				
			});
			
		});
	}
	
	
	return cell;
}



- (CGFloat)tableView:(UITableView *)tv heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	MSFoodLineCell *cell = [self tableView:_tableView cellForRowAtIndexPath:indexPath];
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
