//
//  MSFriendSearchViewController.m
//  Meshi365
//
//  Created by tatsuya on 11/5/12.
//  Copyright (c) 2012 Akifumi. All rights reserved.
//

#import "MSFriendSearchViewController.h"
#import "MSUser.h"
#import "MSNetworkConnector.h"

@interface MSFriendSearchViewController ()

@end

@implementation MSFriendSearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]applicationFrame].size.width, [[UIScreen mainScreen]applicationFrame].size.height - self.tabBarController.tabBar.frame.size.height-self.navigationController.navigationBar.frame.size.height) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];

}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    userArray = [NSMutableArray array];
    MSUser *currentUser = [MSUser currentUser];
    
    NSString *params = [NSString string];
    params = [params stringByAppendingFormat:@"%@=%@", @"word", self.userSearchQuery];
    NSLog(@"%@",self.userSearchQuery);
    [MSNetworkConnector fetchDataFromUrl:URL_OF_SEARCH_USERS(currentUser.uiid) method:RequestMethodPost
                                  params:params block:^(NSData *response) {
                                      NSArray *jsonDic = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:nil];
                                      NSLog(@"%@",jsonDic);
                                      for(int i=0;i<[jsonDic count];i++)
                                          [userArray addObject:[jsonDic objectAtIndex:i]];
                                      
                                  }];

    [myTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{return 1;}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{return [userArray count];}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	
    cell.textLabel.text = [[userArray objectAtIndex:indexPath.row] objectForKey:@"name"] ;
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MSUser *currentUser = [MSUser currentUser];
    
    NSString *params = [NSString string];
    params = [params stringByAppendingFormat:@"%@=%@&", @"from_user_uiid", currentUser.uiid];
    params = [params stringByAppendingFormat:@"%@=%@", @"to_user_uiid", [[userArray objectAtIndex:indexPath.row] objectForKey:@"uiid"]];
    NSLog(@"%@",params);
    
    [MSNetworkConnector fetchDataFromUrl:URL_OF_SEND_FRIEND_REQUEST method:RequestMethodPost params:params block:^(NSData *response) {
        NSArray *jsonDic = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:nil];
        NSLog(@"%@",jsonDic);
    }];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
