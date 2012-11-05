//
//  MSFriendListViewController.m
//  Meshi365
//
//  Created by tatsuya on 11/1/12.
//  Copyright (c) 2012 Akifumi. All rights reserved.
//

#import "MSFriendListViewController.h"
#import "MSFoodLineViewController.h"

@interface MSFriendListViewController ()

@end

@implementation MSFriendListViewController

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
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    MSUser *currentUser = [MSUser currentUser];
    
    friendArray = [NSMutableArray array];
    [MSNetworkConnector fetchDataFromUrl:URL_OF_GET_FRIENDS(currentUser.uiid) method:RequestMethodGet params:nil block:^(NSData *response) {
        NSArray *jsonDic = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:nil];
        NSLog(@"%@",jsonDic);
        for(int i=0;i<[jsonDic count];i++)
            [friendArray addObject:[jsonDic objectAtIndex:i]];
    }];
    
    
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]applicationFrame].size.width, [[UIScreen mainScreen]applicationFrame].size.height - self.tabBarController.tabBar.frame.size.height-self.navigationController.navigationBar.frame.size.height) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    
}
-(void)deleteFriend{
	
}

#pragma mark Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{return 1;}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{return [friendArray count];}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	
    cell.textLabel.text = [[friendArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
	// MSFoodLineViewController *friendFoodLineViewController = [[MSFoodLineViewController alloc] initWithJson:[friendArray objectAtIndex:indexPath.row]];
	MSFoodPicture *foodPicture = [[MSFoodPicture alloc] initWithJson: friendArray[indexPath.row]];
	MSFoodLineViewController *friendFoodLineViewController = [[MSFoodLineViewController alloc] initWithUiid:foodPicture.uiid];
															  
	[self.navigationController pushViewController:friendFoodLineViewController animated:YES];
	
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [friendArray removeObjectAtIndex:indexPath.row];
        [myTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [myTableView setEditing:editing animated:animated];
}

@end
