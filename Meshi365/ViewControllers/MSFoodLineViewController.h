//
//  MSFoodLineViewController.h
//  Meshi365
//
//  Created by Mlle.Irene on 2012/10/28.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSFriendListViewController.h"

@interface MSFoodLineViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
	NSArray *jsonArray;
	UITableView *tableView;
	NSCache *_imageCache;
	NSCache *_requestingUrls;


}
@end
