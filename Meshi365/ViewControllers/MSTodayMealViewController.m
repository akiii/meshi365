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
    
    msCamera = [[MSCameraViewController alloc] init];
    
    no_image_size = CGSizeMake(280, 70);
    
    //Making views in Today Meal
    breakfastImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_image.png"]];
    lunchImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_image.png"]];
    supperImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_image.png"]];
    
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
    breakfastImageView.frame = CGRectMake(20,30,no_image_size.width ,no_image_size.height);
    lunchImageView.frame = CGRectMake(20,120,no_image_size.width ,no_image_size.height);
    supperImageView.frame = CGRectMake(20,210,no_image_size.width ,no_image_size.height);
    
    breakfastImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    //画像の表示
    [self.view addSubview:breakfastImageView];
    [self.view addSubview:lunchImageView];
    [self.view addSubview:supperImageView];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if([msCamera.state isEqualToString:@"breakfast"]){
        CGRect image_rect = CGRectMake(0,
                                       (msCamera.camera_image.size.height-msCamera.camera_image.size.width/4)/2,
                                       msCamera.camera_image.size.width,
                                       msCamera.camera_image.size.width/4);
        breakfastImageView.image = [UIImage imageWithCGImage:CGImageCreateWithImageInRect( [msCamera.camera_image CGImage], image_rect)];
    }
    
    if([msCamera.state isEqualToString:@"lunch"]){
        CGRect image_rect = CGRectMake(0,
                                       (msCamera.camera_image.size.height-msCamera.camera_image.size.width/4)/2,
                                       msCamera.camera_image.size.width,
                                       msCamera.camera_image.size.width/4);
        lunchImageView.image = [UIImage imageWithCGImage:CGImageCreateWithImageInRect( [msCamera.camera_image CGImage], image_rect)];
    }
    
    if([msCamera.state isEqualToString:@"supper"]){
        CGRect image_rect = CGRectMake(0,
                                       (msCamera.camera_image.size.height-msCamera.camera_image.size.width/4)/2,
                                       msCamera.camera_image.size.width,
                                       msCamera.camera_image.size.width/4);
        supperImageView.image = [UIImage imageWithCGImage:CGImageCreateWithImageInRect( [msCamera.camera_image CGImage], image_rect)];
    }
}

-(void)breakfastCameraAction{
    NSLog(@"Breakfast");
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        msCamera.state = @"breakfast";
        msCamera.sourceType = UIImagePickerControllerSourceTypeCamera;
        msCamera.allowsEditing = YES;
        [self presentModalViewController:msCamera animated:YES];
    }    
}

-(void)lunchCameraAction{
    NSLog(@"Lunch");
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        msCamera.state = @"lunch";
        msCamera.sourceType = UIImagePickerControllerSourceTypeCamera;
        msCamera.allowsEditing = YES;
        [self presentModalViewController:msCamera animated:YES];
    }
}
-(void)supperCameraAction{
    NSLog(@"Supper");
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        msCamera.state = @"supper";
        msCamera.sourceType = UIImagePickerControllerSourceTypeCamera;
        msCamera.allowsEditing = YES;
        [self presentModalViewController:msCamera animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
