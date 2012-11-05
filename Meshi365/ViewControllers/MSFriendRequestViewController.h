//
//  MSFriendRequestViewController.h
//  Meshi365
//
//  Created by tatsuya on 11/5/12.
//  Copyright (c) 2012 Akifumi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSFriendRequestViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{

    UITableView *myTableView;
    NSMutableArray *userArray;
}

@end
