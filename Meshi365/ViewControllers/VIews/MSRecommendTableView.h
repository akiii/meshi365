//
//  MSRecommendTableView.h
//  Meshi365
//
//  Created by Mlle.Irene on 2012/10/30.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSRecommendTableView : UITableView<UITableViewDataSource, UITableViewDelegate>
-(void)loadImage;

@property(nonatomic,strong)	NSArray *jsonArray;

@end
