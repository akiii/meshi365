#define MEAL_IMAGE_WIDTH 280
#define MEAL_IMAGE_HEIGHT 80

#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "MSTodayMealViewController.h"
#import "MSNetworkConnector.h"
#import "MSUser.h"


@interface MSTodayMealViewController ()
@end

@implementation MSTodayMealViewController

- (void)hideTabBar:(UITabBarController *) tabbarcontroller{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    for(UIView *view in tabbarcontroller.view.subviews){
        if([view isKindOfClass:[UITabBar class]])
            [view setFrame:CGRectMake(view.frame.origin.x, 480, view.frame.size.width, view.frame.size.height)];
        else [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 480)];
    }
    [UIView commitAnimations];
}

- (void)showTabBar:(UITabBarController *) tabbarcontroller{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    for(UIView *view in tabbarcontroller.view.subviews){
        if([view isKindOfClass:[UITabBar class]])
            [view setFrame:CGRectMake(view.frame.origin.x, 431, view.frame.size.width, view.frame.size.height)];
        else [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 431)];
    }
    [UIView commitAnimations];
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self.view.backgroundColor = DEFAULT_BGCOLOR;
        msCamera = [[MSCameraViewController alloc] init];
        msCamera.state = 0;
        flag_async = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    as = [[UIActionSheet alloc] init];
    as.delegate = self;
    as.title = @"";
    [as addButtonWithTitle:@"Take Photo"];
    [as addButtonWithTitle:@"Choose From Library"];
    [as addButtonWithTitle:@"Cancel"];
    as.cancelButtonIndex = 2;
    
    naviBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 44)];
    naviBar.tintColor = [UIColor colorWithRed:1.0 green:0.80 blue:0.1 alpha:0.7];
    UINavigationItem *title = [[UINavigationItem alloc] initWithTitle:@"Today Menu"];
    [naviBar pushNavigationItem:title animated:YES];
    [self.view addSubview:naviBar];
    
    //Making views in Today Meal
    mealImageView[0] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_image_breakfast.png"]];
    mealImageView[1] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_image_lunch.png"]];
    mealImageView[2] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_image_supper.png"]];
    //タップされた時に実行される関数を指定
    [mealImageView[0] addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                            initWithTarget:self
                                            action:@selector(breakfastCameraAction)]];
    [mealImageView[1] addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                            initWithTarget:self
                                            action:@selector(lunchCameraAction)]];
    [mealImageView[2] addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                            initWithTarget:self
                                            action:@selector(supperCameraAction)]];
    
    for(int i=0;i<3;i++){
        mealImageView[i].userInteractionEnabled = YES;
        mealImageView[i].frame = CGRectMake(20,50+85*i,MEAL_IMAGE_WIDTH ,MEAL_IMAGE_HEIGHT);
        [self.view addSubview:mealImageView[i]];
        
        indicator[i] = [[UIActivityIndicatorView alloc]  initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        indicator[i].color = [UIColor colorWithRed:0.4 green:0.0 blue:0.1 alpha:1.0];
        [indicator[i] setCenter:CGPointMake(mealImageView[i].center.x, mealImageView[i].center.y-10)];
        [self.view addSubview: indicator[i]];
    }
    
    
    UILabel *othersLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 300, 80, 30)];
    othersLabel.backgroundColor = [UIColor clearColor];
    othersLabel.text = @"Others";
    [self.view addSubview:othersLabel];
    
}


//Value Image View に行くかどうか分岐する
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    naviBar.topItem.title = @"Today Menu";
    if(msCamera.state>0){
        msValueImageView = [[MSValueImageView alloc] initWithFrame:CGRectMake(0, 44, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen]applicationFrame].size.height - 44)];
        msValueImageView.cameraImage = msCamera.camera_image;
        
        naviBar.topItem.title = @"Food Image Config";
        [scv removeFromSuperview];
        [self hideTabBar:self.tabBarController];
        [self.view addSubview:msValueImageView];
    }
}

//非同期で画像を読み込む
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSMutableArray *otherImageViews = [NSMutableArray array];
    NSMutableArray *otherImageLoadingIndicators = [NSMutableArray array];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *sinceDateString = [outputFormatter stringFromDate:[NSDate date]];//@"2012-11-02";
    NSString *toDateString = [outputFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:60*60*24]];
    
    NSString *params = [NSString string];
    params = [params stringByAppendingFormat:@"%@=%@&", @"my_uiid", [MSUser currentUser].uiid];
    params = [params stringByAppendingFormat:@"%@=%@&", @"since_date", sinceDateString];
    params = [params stringByAppendingFormat:@"%@=%@&", @"to_date", toDateString];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [MSNetworkConnector requestToUrl:URL_OF_CALENDER([MSUser currentUser].uiid) method:RequestMethodPost params:params block:^(NSData *response){
        self.jsonArray = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:nil];
    }];
    MSFoodPicture *foodPicture;
    for (int i=0; i<[self.jsonArray count]; i++) {
        foodPicture = [[MSFoodPicture alloc] initWithJson:self.jsonArray[i]];
        if(foodPicture.mealType==3){
            flag_async++;
            
            UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loadingMealImage.png"]];
            [otherImageViews addObject:iv];
            
            UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc]  initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            aiv.color = [UIColor colorWithRed:0.4 green:0.0 blue:0.1 alpha:1.0];
            [aiv startAnimating];
            [otherImageLoadingIndicators addObject:aiv];
            
            dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_queue_t q_main = dispatch_get_main_queue();
            dispatch_async(q_global, ^{
                NSURL *foodImageAccessKeyUrl = [MSAWSConnector getS3UrlFromString:foodPicture.url];
                NSData* data = [NSData dataWithContentsOfURL:foodImageAccessKeyUrl];
                UIImage* image = [[UIImage alloc] initWithData:data];
                dispatch_async(q_main, ^{
                    if(image==nil);// 画像がnilの時
                    iv.image = image;
                    [aiv stopAnimating];
                    flag_async--;
                    if(flag_async==0) [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                });
            });
        }else{
            for(int j=0;j<3;j++){
                if (mealImageView[j].userInteractionEnabled==YES&&foodPicture.mealType==j) {
                    flag_async++;
                    [indicator[j] startAnimating];
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
                    mealImageView[j].userInteractionEnabled=NO;
                    mealImageView[j].image = [UIImage imageNamed:@"loadingMealImage.png"];
                    
                    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                    dispatch_queue_t q_main = dispatch_get_main_queue();
                    dispatch_async(q_global, ^{
                        NSURL *foodImageAccessKeyUrl = [MSAWSConnector getS3UrlFromString:foodPicture.url];
                        NSLog(@"%@",foodPicture.url);
                        NSData* data = [NSData dataWithContentsOfURL:foodImageAccessKeyUrl];
                        UIImage* image = [[UIImage alloc] initWithData:data];
                        dispatch_async(q_main, ^{
                            if(image==nil);// 画像がnilの時
                            [self setMealImage:j :image];
                            [indicator[j] stopAnimating];
                            flag_async--;
                            if(flag_async==0) [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                        });
                    });
                }
            }
        }
    }
    NSArray *reverseOtherImageViews =[[otherImageViews reverseObjectEnumerator] allObjects];
    NSArray *reverseOtherImageLoadingIndicators =[[otherImageLoadingIndicators reverseObjectEnumerator] allObjects];
    if(msCamera.state==0&&![self.view.subviews containsObject:scv])
        [self alignOtherImages:reverseOtherImageViews:reverseOtherImageLoadingIndicators];
    if(flag_async==0) [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(void) alignOtherImages:(NSArray *)imageViewArray:(NSArray *)indicatorArray{
    
    scv = [[UIScrollView alloc] initWithFrame:CGRectMake(25, 330, [[UIScreen mainScreen] bounds].size.width-25, 70)];
    scv.contentSize = CGSizeMake(65*([imageViewArray count]+1), 60);
    
    int i;
    for (i=0; i<[imageViewArray count]; i++) {
        ((UIImageView *)[imageViewArray objectAtIndex:i]).frame = CGRectMake(i*65,0,60,60);
        ((UIActivityIndicatorView *)[indicatorArray objectAtIndex:i]).frame = CGRectMake(i*65,0,60,60);
        [scv addSubview:[imageViewArray objectAtIndex:i]];
        [scv addSubview:[indicatorArray objectAtIndex:i]];
    }
    
    otherImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_image_others.png"]];
    otherImageView.userInteractionEnabled = YES;
    [otherImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(otherCameraAction)]];
    otherImageView.frame = CGRectMake(i*65,0,60,60);
    [scv addSubview:otherImageView];
    [self.view addSubview:scv];
    
    //ValueImageより前に来ないように
    [self.view sendSubviewToBack:scv];
}

-(void)breakfastCameraAction{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        msCamera.state = 1;
        [as showFromTabBar:self.tabBarController.tabBar];
    }
}
-(void)lunchCameraAction{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        msCamera.state = 2;
        [as showFromTabBar:self.tabBarController.tabBar];
    }
}
-(void)supperCameraAction{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        msCamera.state = 3;
        [as showFromTabBar:self.tabBarController.tabBar];
    }
}
-(void)otherCameraAction{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        msCamera.state = 4;
        [as showFromTabBar:self.tabBarController.tabBar];
    }
}

-(void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex!=2){
        if(buttonIndex)
            msCamera.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        else
            msCamera.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        msCamera.allowsEditing = YES;
        [self presentViewController:msCamera animated:YES completion:^{}];
    }else{
        msCamera.state = 0;
    }
}

-(void) save_image:(id)sender{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSString *fileName = [MSAWSConnector uploadFoodPictureToAWS:msValueImageView.squareFoodPictureImage];
    msValueImageView.squareFoodPictureImage.foodPicture.uiid = [MSUser currentUser].uiid;
    msValueImageView.squareFoodPictureImage.foodPicture.mealType = msCamera.state-1;
    msValueImageView.squareFoodPictureImage.foodPicture.fileName = fileName;
    [msValueImageView dataPreservation];
    [MSNetworkConnector requestToUrl:URL_OF_POST_FOOD_PICTURE method:RequestMethodPost params:msValueImageView.squareFoodPictureImage.foodPicture.params block:^(NSData *response) {}];
    
    [self socialWithImage:msValueImageView.squareFoodPictureImage.foodPicture.comment :msValueImageView.squareFoodPictureImage];
    
    [self setMealImage:msCamera.state-1 :msValueImageView.squareFoodPictureImage];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    msCamera.state = 0;
    [self viewDidAppear:YES];
    [self cancel_image:sender];
}

-(void) cancel_image:(id)sender{
    msCamera.state = 0;
    naviBar.topItem.title = @"Today Menu";
    [self showTabBar:self.tabBarController];
    [msValueImageView removeFromSuperview];
}

-(void) socialWithImage:(NSString *)tweet :(UIImage *)image{
    NSMutableArray *accountTypes = [NSMutableArray array];
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    
    if(msValueImageView.flag_twitter&&[SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
        [accountTypes addObject:[accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter]];
    
    //    if(msValueImageView.flag_facebook&&[SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    //        [accountTypes addObject:[accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook]];
    
    for(int i=0;i<[accountTypes count];i++){
        [accountStore requestAccessToAccountsWithType:[accountTypes objectAtIndex:i]
                                              options:nil
                                           completion:^(BOOL granted, NSError *error) {
                                               if (granted) {
                                                   NSArray *accountArray = [accountStore accountsWithAccountType:[accountTypes objectAtIndex:i]];
                                                   if (accountArray.count > 0) {
                                                       NSURL *url = [NSURL URLWithString:@"https://upload.twitter.com/1/statuses/update_with_media.json"];
                                                       NSString *tweets = [NSString stringWithFormat:@"%@ #meal_diary",tweet];
                                                       NSDictionary *params = [NSDictionary dictionaryWithObject:tweets forKey:@"status"];
                                                       
                                                       SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                                                               requestMethod:SLRequestMethodPOST
                                                                                                         URL:url
                                                                                                  parameters:params];
                                                       [request setAccount:[accountArray objectAtIndex:0]];
                                                       
                                                       NSData *imageData = UIImagePNGRepresentation(image);
                                                       [request addMultipartData:imageData withName:@"media[]" type:@"multipart/form-data" filename:nil];
                                                       
                                                       [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {}];
                                                   }
                                               }
                                           }];
    }
}

-(void) setMealImage:(int)type :(UIImage*)image{
    CGRect image_rect = CGRectMake(0, (image.size.height-MEAL_IMAGE_HEIGHT)/2,
                                   image.size.width,
                                   image.size.height*MEAL_IMAGE_HEIGHT/MEAL_IMAGE_WIDTH);
    UIImage *image0,*frame;
    if(type<3){
        image0 = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([image CGImage], image_rect)];
        switch (type) {
            case 0:
                frame = [UIImage imageNamed:@"breakfastMealFrame.png"];
                break;
            case 1:
                frame = [UIImage imageNamed:@"lunchMealFrame.png"];
                break;
            case 2:
                frame = [UIImage imageNamed:@"supperMealFrame.png"];
                break;
        }
        
        UIGraphicsBeginImageContext(CGSizeMake(MEAL_IMAGE_WIDTH, MEAL_IMAGE_HEIGHT));
        [image0 drawInRect:CGRectMake(0, 0, MEAL_IMAGE_WIDTH, MEAL_IMAGE_HEIGHT)];
        [frame drawInRect:CGRectMake(0, 0, MEAL_IMAGE_WIDTH, MEAL_IMAGE_HEIGHT)];
        
        mealImageView[type].image = UIGraphicsGetImageFromCurrentImageContext();
        mealImageView[type].userInteractionEnabled = NO;
        UIGraphicsEndImageContext();
    }
}

@end
