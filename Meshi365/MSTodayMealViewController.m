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
    
    UIImageView *breakfast = [[UIImageView alloc] init];
    UIImageView *lunch = [[UIImageView alloc] init];
    UIImageView *supper = [[UIImageView alloc] init];
    
    breakfast.userInteractionEnabled = YES;
    lunch.userInteractionEnabled = YES;
    supper.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap_breakfast = [[UITapGestureRecognizer alloc]
                                                initWithTarget:self
                                                action:@selector(breakfastCameraAction)];
    UITapGestureRecognizer *tap_lunch = [[UITapGestureRecognizer alloc]
                                                initWithTarget:self
                                                action:@selector(lunchCameraAction)];
    UITapGestureRecognizer *tap_supper = [[UITapGestureRecognizer alloc]
                                                initWithTarget:self
                                                action:@selector(supperCameraAction)];
    
    [breakfast addGestureRecognizer:tap_breakfast];
    [lunch addGestureRecognizer:tap_lunch];
    [supper addGestureRecognizer:tap_supper];
    
    breakfast.image = [UIImage imageNamed:@"no_image.png"];
    lunch.image = [UIImage imageNamed:@"no_image.png"];
    supper.image = [UIImage imageNamed:@"no_image.png"];
    
    breakfast.frame = CGRectMake(20,30,280,93);
    lunch.frame = CGRectMake(20,150,280,93);
    supper.frame = CGRectMake(20,270,280,93);
    
    [self.view addSubview:breakfast];
    [self.view addSubview:lunch];
    [self.view addSubview:supper];
}

-(void)breakfastCameraAction{
    NSLog(@"Breakfast");
}

-(void)lunchCameraAction{
    NSLog(@"Lunch");
}
-(void)supperCameraAction{
    NSLog(@"Supper");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
