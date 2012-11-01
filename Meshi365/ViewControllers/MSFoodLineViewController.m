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

@end

@implementation MSFoodLineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		_imageCache = [[NSCache alloc] init];
		_requestingUrls = [[NSCache alloc] init];
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
	
	tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	tableView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
	

	
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
	
	
	[tableView reloadData];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return jsonArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    static NSString *CellIdentifier = @"Cell";
	
    MSFoodLineCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell =[[MSFoodLineCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] ;
	}
	
	
	
	MSFoodPicture *foodPicture = [[MSFoodPicture alloc]init: jsonArray[indexPath.row] ];
	NSString *imageUrl = foodPicture.url;
	
	cell.textLabel.text =  [NSString stringWithFormat:@"%d",indexPath.row];
	
	NSLog(@"......make access key %d",indexPath.row);
	NSURL *imageAccessKeyUrl = [MSAWSConnector foodPictureImageUrlFromJsonArray:jsonArray imageNum:indexPath.row];
	
	
	
	if([_imageCache objectForKey:imageUrl] )
	{
		NSLog(@"......isImageCache:%d",indexPath.row);
		
		[cell updateJsonData:imageAccessKeyUrl foodPicture:foodPicture   image:[_imageCache objectForKey:imageUrl]];
		
		[cell layoutSubviews];
	}
	else
	{
		NSLog(@"......no ImageCache:%d",indexPath.row);
		
		cell.imageView.image = [UIImage imageNamed:@"star.png"];
		
		
		
		//load image
		dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
		dispatch_queue_t q_main = dispatch_get_main_queue();
		
		
		
		//cell.imageView.image = nil;
		dispatch_async(q_global, ^{
			NSLog(@"...... load start:%d",indexPath.row);
			
			//[_requestingUrls setObject:@"lock" forKey:imageUrl];
			
			NSData* data = [NSData dataWithContentsOfURL:imageAccessKeyUrl];
			UIImage* image = [[UIImage alloc] initWithData:data];
			
			
			dispatch_async(q_main, ^{
				cell.imageView.image = [UIImage imageNamed:@"star.png"];
				
				[_imageCache setObject:image forKey:imageUrl];
				
				//ok
				[cell updateJsonData:imageAccessKeyUrl foodPicture:foodPicture   image:[_imageCache objectForKey:imageUrl]];
				[cell layoutSubviews];
				
				NSLog(@"...... load done:%d",indexPath.row);
				
			});
			
		});
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

-(void)moveFriend{
    MSFriendListViewController *friendListVC = [[MSFriendListViewController alloc]init];
    [self.navigationController pushViewController:friendListVC animated:YES];
}

@end
