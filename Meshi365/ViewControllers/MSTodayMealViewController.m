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
    
    
    //Making views in Today Meal
    UIImageView *breakfastImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_image.png"]];
    UIImageView *lunchImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_image.png"]];
    UIImageView *supperImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_image.png"]];
    
    //Image View をタップで反応できるようにする設定
    breakfastImageView.userInteractionEnabled = YES;
    lunchImageView.userInteractionEnabled = YES;
    supperImageView.userInteractionEnabled = YES;
    
    //タップされた時に実行される関数を指定
    [breakfastImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                              initWithTarget:self
                                              action:@selector(breakfastCameraAction)]];
    [lunchImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(lunchCameraAction)]];
    [supperImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(supperCameraAction)]];
        
    //画像の大きさを設定
    breakfastImageView.frame = CGRectMake(20,30,280,70);
    lunchImageView.frame = CGRectMake(20,120,280,70);
    supperImageView.frame = CGRectMake(20,210,280,70);
    
    //画像の表示
    [self.view addSubview:breakfastImageView];
    [self.view addSubview:lunchImageView];
    [self.view addSubview:supperImageView];
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
