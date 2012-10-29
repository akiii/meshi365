//
//  MSValueImageViewController.m
//  Meshi365
//
//  Created by tatsuya on 10/30/12.
//  Copyright (c) 2012 Akifumi. All rights reserved.
//

#import "MSValueImageViewController.h"

@interface MSValueImageViewController ()

@end

@implementation MSValueImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIImageView *taken_imageView = [[UIImageView alloc] initWithImage:self.taken_image];
    taken_imageView.frame = CGRectMake(0, 0, 100, 100);
    [self.view addSubview:taken_imageView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
