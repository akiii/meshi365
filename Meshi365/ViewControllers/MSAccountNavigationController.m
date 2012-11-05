//
//  MSAccountNavigationController.m
//  Meshi365
//
//  Created by tatsuya on 11/5/12.
//  Copyright (c) 2012 Akifumi. All rights reserved.
//

#import "MSAccountNavigationController.h"

@interface MSAccountNavigationController ()

@end

@implementation MSAccountNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationBar.tintColor = [UIColor colorWithRed:1.0 green:0.80 blue:0.1 alpha:0.7];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
