//
//  MSSignUpViewController.m
//  Meshi365
//
//  Created by tatsuya on 11/1/12.
//  Copyright (c) 2012 Akifumi. All rights reserved.
//

#import "MSSignUpViewController.h"

@interface MSSignUpViewController ()

@end

@implementation MSSignUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithRed:1.0 green:0.93 blue:0.8 alpha:1.0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(40,50,100,30)];
    lbl.text = @"User Name:";
    lbl.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lbl];
    
    tf = [[UITextField alloc] initWithFrame:CGRectMake(40, 90, 200, 30)];
    tf.borderStyle = UITextBorderStyleRoundedRect;
    //tf.textColor = [UIColor blueColor];
    tf.placeholder = @"MUST";
    tf.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:tf];
    
    UIImageView *im = [[UIImageView alloc]initWithFrame:CGRectMake(100, 160, 120, 120)];
    im.backgroundColor = [UIColor blueColor];
    [self.view addSubview:im];
    
    //保存ボタン設定
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(120, 310, 80, 30);
    [btn setTitle:@"Save" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(init_profile:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)init_profile:(id)sender{
//    MSUser *currentUser = [MSUser currentUser];
//    currentUser.name = @"name aaa";
//    currentUser.uiid = [[MSUIIDController sharedController] create];
//    currentUser.profileImageUrl = @"http://profile_image_url";
//    
//    [MSNetworkConnector requestToUrl:URL_OF_SIGN_UP method:RequestMethodPost params:currentUser.params block:^(NSData *response) {
//        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:nil];
//        if ([[jsonDic objectForKey:@"save"] boolValue]) {
//            NSNumber *userId = [NSNumber numberWithInt:[[jsonDic objectForKey:kUserId] intValue]];
//            NSString *uiid = [jsonDic objectForKey:kUIID];
//            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//            [ud setObject:userId forKey:kUserId];
//            [ud setObject:uiid forKey:kUIID];
//            [ud synchronize];
//        }
//    }];
    
    [self dismissModalViewControllerAnimated:YES];
    
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    [super touchesBegan:touches withEvent:event];
    if(!CGRectContainsPoint(tf.frame, location))
        [tf resignFirstResponder];
}

@end
