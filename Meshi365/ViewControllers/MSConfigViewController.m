//
//  MSConfigViewController.m
//  Meshi365
//
//  Created by Mlle.Irene on 2012/10/29.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSConfigViewController.h"
#import "MSFriendSearchViewController.h"
#import "MSFriendRequestViewController.h"
#import "MSUser.h"
#import "MSNetworkConnector.h"
#import "MSAWSConnector.h"



@interface MSConfigViewController ()
@property(nonatomic,strong) UITextField *textField;
@end

@implementation MSConfigViewController

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
	
    self.navigationItem.title = @"Account";
    
    
	self.view.backgroundColor = [UIColor colorWithRed:1.0 green:0.93 blue:0.8 alpha:1.0];
	UIScrollView* scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)];
	//scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 300);
	scrollView.showsHorizontalScrollIndicator = NO;
	scrollView.showsVerticalScrollIndicator = YES;
	[self.view addSubview:scrollView];
    
    MSUser *currentUser = [MSUser currentUser];
    
    NSString *params = [NSString string];
    
    params = [params stringByAppendingFormat:@"%@=%@", @"uiid", currentUser.uiid];
    [MSNetworkConnector fetchDataFromUrl:URL_OF_ME
                                  method:RequestMethodPost
                                  params:params block:^(NSData *response) {
                                      jsonDic = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:nil];
                                      NSLog(@"%@",jsonDic);
                                  }];

    UIImageView *profileImageView = [[UIImageView alloc] initWithImage:nil];
    profileImageView.frame = CGRectMake(20,30,80,80);
    profileImageView.image = [UIImage imageNamed:@"BigNowLoading.png"];
    [scrollView addSubview:profileImageView];
    
    UIActivityIndicatorView  *aiv = [[UIActivityIndicatorView alloc]
                                     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    aiv.color = [UIColor colorWithRed:0.4 green:0.0 blue:0.1 alpha:1.0];
    aiv.center = CGPointMake(profileImageView.frame.size.width/2, profileImageView.frame.size.height/2);
    [aiv startAnimating];
    [profileImageView addSubview:aiv];
    
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main = dispatch_get_main_queue();
    dispatch_async(q_global, ^{
        NSURL *foodImageAccessKeyUrl = [MSAWSConnector getS3UrlFromString:
                                        [NSURL URLWithString:ASSETS_FILE_URL([jsonDic objectForKey:@"profile_image_file_name"])]];
        NSLog(@"%@",foodImageAccessKeyUrl);
        
        NSData* data = [NSData dataWithContentsOfURL:foodImageAccessKeyUrl];
        UIImage* image = [[UIImage alloc] initWithData:data];
        dispatch_async(q_main, ^{
            if(image==nil) NSLog(@"test");// 画像がnilの時
            profileImageView.image = [self framedImage:image :80];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [aiv stopAnimating];
        });
    });
	
	UILabel *lbl0 = [[UILabel alloc]initWithFrame:CGRectMake(120, 35, 200, 30)];
	lbl0.text = @"User Name";
    lbl0.font = [UIFont systemFontOfSize:17];
	lbl0.backgroundColor = [UIColor clearColor];
	[scrollView addSubview:lbl0];
    
	UILabel *lbl1 = [[UILabel alloc]initWithFrame:CGRectMake(120, 65, 200, 30)];
	lbl1.text = [jsonDic objectForKey:@"name"];
    lbl1.font = [UIFont systemFontOfSize:25];
	lbl1.backgroundColor = [UIColor clearColor];
	[scrollView addSubview:lbl1];
    
    UILabel *lbl2 = [[UILabel alloc]initWithFrame:CGRectMake(20, 120, 200, 30)];
	lbl2.text = @"User Search";
    lbl2.font = [UIFont systemFontOfSize:17];
	lbl2.backgroundColor = [UIColor clearColor];
	[scrollView addSubview:lbl2];
    
    friendSearchTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 150, 200, 30)];
    friendSearchTextField.borderStyle = UITextBorderStyleRoundedRect;
    friendSearchTextField.placeholder = @"User Name";
	[friendSearchTextField addTarget:self action:@selector(userSearchInputDone) forControlEvents:UIControlEventEditingDidEndOnExit];
    [scrollView addSubview:friendSearchTextField];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    confirmBtn.frame = CGRectMake(20, 185, 180, 50);
	[confirmBtn setTitle:@"Request Confirmation" forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirmButtonSelected) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:confirmBtn];
	
    /*
     
     _textField = [[UITextField alloc] initWithFrame:CGRectMake(x, y, 200, 30)];
     _textField.placeholder = @"input your nickname";
     _textField.clearButtonMode = UITextFieldViewModeAlways;
     _textField.borderStyle = UITextBorderStyleRoundedRect;
     [_textField addTarget:self action:@selector(nicknameInputDone) forControlEvents:UIControlEventEditingDidEndOnExit];
     [scrollView addSubview:_textField];
     
	UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[submitButton setTitle:@"Submit" forState:UIControlStateNormal];
	submitButton.frame = CGRectMake(x+210, y, 80, 30);
	[submitButton addTarget:self action:@selector(submitNickname:) forControlEvents:UIControlEventTouchDown];
	[scrollView addSubview:submitButton];
	y+=dy;
	
	
	
	UIButton *fbButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[fbButton setTitle:@"FB post" forState:UIControlStateNormal];
	fbButton.frame = CGRectMake(x+210, y, 80, 30);
	[fbButton addTarget:self action:@selector(fbPost:) forControlEvents:UIControlEventTouchDown];
	[scrollView addSubview:fbButton];
	y+=dy;
	
	UIButton *twButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[twButton setTitle:@"TW post" forState:UIControlStateNormal];
	twButton.frame = CGRectMake(x+210, y, 80, 30);
	[twButton addTarget:self action:@selector(twPost:) forControlEvents:UIControlEventTouchDown];
	[scrollView addSubview:twButton];
	y+=dy;
	
	
	UIButton *twButton2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[twButton2 setTitle:@"TW post2" forState:UIControlStateNormal];
	twButton2.frame = CGRectMake(x+210, y, 80, 30);
	postMsg = @"SLRequest post test.";
	[twButton2 addTarget:self action:@selector(twPost2:) forControlEvents:UIControlEventTouchDown];
	[scrollView addSubview:twButton2];
	y+=dy;
     */

}

-(UIImage *)framedImage:(UIImage *)image:(int)size{
    
    UIImage *frame = [UIImage imageNamed:@"otherMealFrame.png"];
    
    UIGraphicsBeginImageContext(CGSizeMake(size, size));
    [image drawInRect:CGRectMake(0, 0, size, size)];
    [frame drawInRect:CGRectMake(0, 0, size, size)];
    
    return UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

-(void)userSearchInputDone{
    [friendSearchTextField resignFirstResponder];
    
    MSFriendSearchViewController *friendSearchViewController = [[MSFriendSearchViewController alloc] init];
    friendSearchViewController.userSearchQuery = friendSearchTextField.text;
    NSLog(@"%@",friendSearchTextField.text);
    [self.navigationController pushViewController:friendSearchViewController animated:YES];
}

-(void)confirmButtonSelected{
    MSFriendRequestViewController *friendRequestViewController = [[MSFriendRequestViewController alloc] init];
    [self.navigationController pushViewController:friendRequestViewController animated:YES];
}

/*
-(void)submitNickname:(UITextField*)textfield{
	NSLog(@"submit!!!!!!!");
}


-(void)fbPost:(UITextField*)textfield{
	SLComposeViewController *facebookPostVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
	[facebookPostVC setInitialText:@"facebook投稿テスト"];
	[facebookPostVC addImage:[UIImage imageNamed:@"star.png"]];
	[self presentViewController:facebookPostVC animated:YES completion:nil];
}

- (void)twPost:(UITextField*)textfield{
	//- (IBAction)twPost:(UIButton *)sender {
	SLComposeViewController *twitterPostVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
	[twitterPostVC setInitialText:@"twitter投稿テスト"];
	[twitterPostVC addImage:[UIImage imageNamed:@"star.png"]];
	[self presentViewController:twitterPostVC animated:YES completion:nil];
}

- (void)twPost2:(UITextField*)textfield
{
	
	if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        ACAccountStore *accountStore = [[ACAccountStore alloc] init];
        ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        [accountStore
         requestAccessToAccountsWithType:accountType
         options:nil
         completion:^(BOOL granted, NSError *error) {
             if (granted) {
                 NSArray *accountArray = [accountStore accountsWithAccountType:accountType];
                 if (accountArray.count > 0) {
                     NSURL *url = [NSURL URLWithString:@"http://api.twitter.com/1/statuses/update.json"];
                     NSDictionary *params = [NSDictionary dictionaryWithObject:postMsg forKey:@"status"];
                     
                     SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                             requestMethod:SLRequestMethodPOST
                                                                       URL:url
                                                                parameters:params];
                     [request setAccount:[accountArray objectAtIndex:0]];
                     [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                         NSLog(@"responseData=%@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
                     }];
                 }
             }
         }];
    }
	
	
	
	
	
	
	
	
	
	
	//
	//
	//
	//	NSLog(@"post tweet\n");
	//
	//
	//	// Build a twitter request
	//
	//	SLRequest *postRequest = [[SLRequest alloc] init];
	//
	//	//SLRequest *postRequest = [[SLRequest alloc] initWithURL:
	//							  [NSURL URLWithString:@"http://api.twitter.com/1/statuses/update.json"] parameters:[NSDictionary dictionaryWithObject:msg forKey:@"status"] requestMethod:SLRequestMethodPOST];
	//
	//	// Post the request
	//	[postRequest setAccount:self.account];
	//
	//	// Block handler to manage the response
	//	[postRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error)
	//	 {
	//		 NSLog(@"Twitter response, HTTP response: %i", [urlResponse statusCode]);
	//	 }];
}



- (void)getFollower:(UITextField*)textfield
{
	
	
	if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        ACAccountStore *accountStore = [[ACAccountStore alloc] init];
        ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        [accountStore
         requestAccessToAccountsWithType:accountType
         options:nil
         completion:^(BOOL granted, NSError *error) {
             if (granted) {
                 NSArray *accountArray = [accountStore accountsWithAccountType:accountType];
                 if (accountArray.count > 0) {
    
					 
					 //				 NSURL *followerIdsURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/1.1/followers/ids.json?user_id=%d", userId]];
					 //	 SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:followerIdsURL parameters:nil];
					
					 
					 
					 //request.account = self.twitterAccount;
					 //[request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
					 
						 
//						 [request setAccount:[accountArray objectAtIndex:0]];
//						 [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
//							 NSLog(@"responseData=%@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
//					 
//					 
					 
//					 NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1/followers/ids.json"];
//					 //     NSDictionary *params = [NSDictionary dictionaryWithObject:postMsg forKey:@"status"];
//                     
//                     SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
//                                                             requestMethod:SLRequestMethodGET
//                                                                       URL:url
//                                                                parameters:params];
//                     [request setAccount:[accountArray objectAtIndex:0]];
//                     [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
//                         NSLog(@"responseData=%@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
                
				 
				 
					 //}];
                 }
             }
         }];
    }
	
	
}




-(BOOL)textFieldShouldReturn:(UITextField*)textField{
	[_textField resignFirstResponder];
	return YES;
}
-(void)nicknameInputDone{
}
 */


@end
