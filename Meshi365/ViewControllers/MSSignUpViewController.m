//
//  MSSignUpViewController.m
//  Meshi365
//
//  Created by tatsuya on 11/1/12.
//  Copyright (c) 2012 Akifumi. All rights reserved.
//

#import "MSSignUpViewController.h"
#import "AppDelegate.h"
#import "MSRootTabBarController.h"
#import "MSNetworkConnector.h"

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
    
    msCamera =[[MSCameraViewController alloc] init];
    
    as = [[UIActionSheet alloc] init];
    as.delegate = self;
    as.title = @"";
    [as addButtonWithTitle:@"Take Photo"];
    [as addButtonWithTitle:@"Choose From Library"];
    [as addButtonWithTitle:@"Cancel"];
    as.cancelButtonIndex = 2;
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(40,50,100,30)];
    lbl.text = @"User Name:";
    lbl.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lbl];
    
    tf = [[UITextField alloc] initWithFrame:CGRectMake(40, 90, 200, 30)];
    tf.borderStyle = UITextBorderStyleRoundedRect;
    tf.delegate = self;
    tf.placeholder = @"MUST";
    tf.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:tf];
    
    profileImageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 160, 120, 120)];
    profileImageView.image = [UIImage imageNamed:@"star.png"];
    profileImageView.userInteractionEnabled = YES;
    [profileImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(profileImageSelect)]];
    [self.view addSubview:profileImageView];
    
    //保存ボタン設定
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(120, 310, 80, 30);
    [btn setTitle:@"Save" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(init_profile:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if([msCamera.state isEqualToString:@"active"]) {
        msCamera.state = nil;
        profileImageView.image = msCamera.camera_image;
    }
}

-(void)init_profile:(id)sender{
    
    if (![tf.text isEqualToString:@""]) {
        MSUser *currentUser = [MSUser currentUser];
        
        currentUser.name = tf.text;
        currentUser.uiid = [[MSUIIDController sharedController] create];
        NSLog(@"%@",currentUser.uiid);
        currentUser.profileImageUrl = [MSAWSConnector uploadProfileImageToAWS:profileImageView.image];
        
        [MSNetworkConnector requestToUrl:URL_OF_SIGN_UP method:RequestMethodPost params:currentUser.params block:^(NSData *response) {
            NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:nil];
            if ([[jsonDic objectForKey:@"save"] boolValue]) {
                NSNumber *userId = [NSNumber numberWithInt:[[jsonDic objectForKey:kUserId] intValue]];
                NSString *uiid = [jsonDic objectForKey:kUIID];
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                [ud setObject:userId forKey:kUserId];
                [ud setObject:uiid forKey:kUIID];
                [ud synchronize];
            }
        }];
        
        AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        MSRootTabBarController *rootTabBarController = [[MSRootTabBarController alloc]init];
        delegate.window.rootViewController = rootTabBarController;
    }
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    [super touchesBegan:touches withEvent:event];
    if(!CGRectContainsPoint(tf.frame, location))
        [tf resignFirstResponder];
}


-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    [tf resignFirstResponder];
    return YES;
}

-(void)actionSheet:(UIActionSheet*)actionSheet
clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex!=2){
        if(buttonIndex)
            msCamera.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        else
            msCamera.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        msCamera.allowsEditing = YES;
        [self presentModalViewController:msCamera animated:YES];
    }
}

-(void)profileImageSelect{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        msCamera.state = @"active";
        [as showInView:self.view];
    }
}

@end
