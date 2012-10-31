//
//  MSFriendListViewController.m
//  Meshi365
//
//  Created by tatsuya on 11/1/12.
//  Copyright (c) 2012 Akifumi. All rights reserved.
//

#import "MSFriendListViewController.h"

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
    
    UIBarButtonItem *btn =
    [[UIBarButtonItem alloc]
     initWithTitle:@"Edit"
     style:UIBarButtonItemStylePlain
     target:self
     action:@selector(deleteFriend)
     ];
    self.navigationItem.rightBarButtonItem = btn;
    
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]applicationFrame].size.width, [[UIScreen mainScreen]applicationFrame].size.height - self.tabBarController.tabBar.frame.size.height-self.navigationController.navigationBar.frame.size.height) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
}
-(void)deleteFriend{

}

#pragma mark Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{return 1;}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{return 30;}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];	}
	
    cell.textLabel.text = [NSString stringWithFormat:@"Friend%d",indexPath.row];
    
	return cell;
}
/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{return 25;}
*/
@end
