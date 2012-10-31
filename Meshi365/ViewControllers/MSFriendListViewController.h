//
//  MSFriendListViewController.h
//  Meshi365
//
//  Created by tatsuya on 11/1/12.
//  Copyright (c) 2012 Akifumi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSFriendListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    UITableView *myTableView;
    NSMutableArray *friendArray;
}

@end
