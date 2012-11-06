//
//  MSMiniCalenderTableView.h
//  Meshi365
//
//  Created by Mlle.Irene on 2012/10/29.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSMiniCalenderTableView : UITableView<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong)NSArray* jsonArray;
@property(nonatomic,strong)UIViewController* baseView;
@property(nonatomic,strong) UIView *popUpView;

-(void)loadImage;
@end
