//
//  MSTodayMealViewController.m
//  Meshi365
//
//  Created by Mlle.Irene on 2012/10/29.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSTodayMealViewController.h"

@interface MSTodayMealViewController ()

@end

@implementation MSTodayMealViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    UIImageView *breakfast,*lunch,*supper;
    breakfast.image = [UIImage imageNamed:@"no_image.png"];
    lunch.image = [UIImage imageNamed:@"no_image.png"];
    supper.image = [UIImage imageNamed:@"no_image.png"];
    
    breakfast.frame = CGRectMake(30,30,300,100);
    lunch.frame = CGRectMake(30,150,300,100);
    supper.frame = CGRectMake(30,270,300,100);
    
    [self.view addSubview:breakfast];
    [self.view addSubview:lunch];
    [self.view addSubview:supper];
    
    UILabel *lbl = [[UILabel alloc] init];
    lbl.text = @"test";
    [self.view addSubview:lbl];
    
    NSLog(@"test");

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
