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
    if(self) self.view.backgroundColor = [UIColor colorWithRed:1.0 green:0.93 blue:0.8 alpha:1.0];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    msCamera = [[MSCameraViewController alloc] init];
    
    no_image_size = CGSizeMake(280, 80);
    
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
    breakfastImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_image_breakfast.png"]];
    lunchImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_image_lunch.png"]];
    supperImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_image_supper.png"]];
    
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
    breakfastImageView.frame = CGRectMake(20,50,no_image_size.width ,no_image_size.height);
    lunchImageView.frame = CGRectMake(20,135,no_image_size.width ,no_image_size.height);
    supperImageView.frame = CGRectMake(20,220,no_image_size.width ,no_image_size.height);
    
    breakfastImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    //画像の表示
    [self.view addSubview:breakfastImageView];
    [self.view addSubview:lunchImageView];
    [self.view addSubview:supperImageView];
    
    cntOtherImage = 1;
    
    UILabel *othersLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 300, 80, 30)];
    othersLabel.backgroundColor = [UIColor clearColor];
    othersLabel.text = @"Others";
    
    int i;
    UIImageView *im;
    for (i=0; i<cntOtherImage; i++) {
        im = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sampleMenu.png"]];
        im.frame = CGRectMake(25+i*65,330,60,60);
        [self.view addSubview:im];
    }
    
    otherImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_image_others.png"]];
    otherImageView.userInteractionEnabled = YES;
    [otherImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(otherCameraAction)]];
    otherImageView.frame = CGRectMake(25+i*65,330,60,60);
    [self.view addSubview:otherImageView];
    
    
    [self.view addSubview:othersLabel];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *sinceDateString = @"2012-11-02";
    NSString *toDateString = @"2012-11-03";
    
    NSString *params = [NSString string];
    params = [params stringByAppendingFormat:@"%@=%@&", @"my_uiid", [MSUser currentUser].uiid];
    params = [params stringByAppendingFormat:@"%@=%@&", @"since_date", sinceDateString];
    
    params = [params stringByAppendingFormat:@"%@=%@&", @"to_date", toDateString];
    [MSNetworkConnector requestToUrl:URL_OF_CALENDER([MSUser currentUser].uiid) method:RequestMethodPost params:params block:^(NSData *response){

        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:nil];
        for (int i=0; i<[jsonArray count]; i++) {
            MSFoodPicture *foodPicture = [[MSFoodPicture alloc] init:jsonArray[i]];
            if (breakfastImageView.userInteractionEnabled==YES&&foodPicture.mealType==0) {
                breakfastImageView.userInteractionEnabled=NO;
                
                dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                dispatch_queue_t q_main = dispatch_get_main_queue();
        
                dispatch_async(q_global, ^{
                    NSURL *foodImageAccessKeyUrl = [MSAWSConnector getS3UrlFromString:foodPicture.url];
                    NSData* data = [NSData dataWithContentsOfURL:foodImageAccessKeyUrl];
                    UIImage* image = [[UIImage alloc] initWithData:data];
                    dispatch_async(q_main, ^{
                        [self setMealImage:0 :image];
                    });
                });
            }
        }
        NSLog(@"%@",jsonArray);
    }];
    

    
    naviBar.topItem.title = @"Today Menu";
    if([msCamera.state isEqualToString:@"breakfast"]||[msCamera.state isEqualToString:@"lunch"]||[msCamera.state isEqualToString:@"supper"]){
        msValueImageView = [[MSValueImageView alloc] init];
        msValueImageView.cameraImage = msCamera.camera_image;
        
        naviBar.topItem.title = @"Food Image Config";
        [self hideTabBar:self.tabBarController];
        [self.view addSubview:msValueImageView];
    }
}

-(void)breakfastCameraAction{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        msCamera.state = @"breakfast";
        [as showFromTabBar:self.tabBarController.tabBar];
    }
}

-(void)lunchCameraAction{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        msCamera.state = @"lunch";
        [as showFromTabBar:self.tabBarController.tabBar];
    }
}

-(void)supperCameraAction{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        msCamera.state = @"supper";
        [as showFromTabBar:self.tabBarController.tabBar];
    }
}

-(void)otherCameraAction{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        msCamera.state = @"other";
        [as showFromTabBar:self.tabBarController.tabBar];
    }
}

-(void)actionSheet:(UIActionSheet*)actionSheet
clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex!=2){
        if(buttonIndex)
            msCamera.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        else
            msCamera.sourceType = UIImagePickerControllerSourceTypeCamera;

        msCamera.allowsEditing = YES;
        [self presentViewController:msCamera animated:YES completion:^{}];
    }
}

-(void) save_image:(id)sender{
    
    NSString *urlString = [MSAWSConnector uploadFoodPictureToAWS:msValueImageView.squareFoodPictureImage];
    msValueImageView.squareFoodPictureImage.foodPicture.uiid = [MSUser currentUser].uiid;
    msValueImageView.squareFoodPictureImage.foodPicture.mealType = [msCamera.state isEqualToString:@"breakfast"]?0:
    [msCamera.state isEqualToString:@"lunch"]?1:
    [msCamera.state isEqualToString:@"supper"]?2:3;
    msValueImageView.squareFoodPictureImage.foodPicture.url = urlString;
    [msValueImageView dataPreservation];
    
    [MSNetworkConnector requestToUrl:URL_OF_POST_FOOD_PICTURE method:RequestMethodPost params:msValueImageView.squareFoodPictureImage.foodPicture.params block:^(NSData *response) {}];
    
    NSMutableArray *accountTypes = [NSMutableArray array];
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    if(msValueImageView.flag_twitter&&[SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
        [accountTypes addObject:[accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter]];
    //if(msValueImageView.flag_facebook&&[SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
        //[accountTypes addObject:[accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook]];
    for(int i=0;i<[accountTypes count];i++){
        [accountStore requestAccessToAccountsWithType:[accountTypes objectAtIndex:i]
                                              options:nil
                                           completion:^(BOOL granted, NSError *error) {
            if (granted) {
                NSArray *accountArray = [accountStore accountsWithAccountType:[accountTypes objectAtIndex:i]];
                if (accountArray.count > 0) {
                    NSURL *url = [NSURL URLWithString:@"https://upload.twitter.com/1/statuses/update_with_media.json"];
                    NSDictionary *params = [NSDictionary dictionaryWithObject:msValueImageView.squareFoodPictureImage.foodPicture.comment forKey:@"status"];
                                                       
                    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                            requestMethod:SLRequestMethodPOST
                                                                      URL:url
                                                                parameters:params];
                    [request setAccount:[accountArray objectAtIndex:0]];
                    
                    NSData *imageData = UIImagePNGRepresentation(msValueImageView.squareFoodPictureImage);
                    [request addMultipartData:imageData withName:@"media[]" type:@"multipart/form-data" filename:nil];
                    [request addMultipartData:[msValueImageView.squareFoodPictureImage.foodPicture.comment dataUsingEncoding:NSUTF8StringEncoding] withName:@"status" type:@"multipart/form-data" filename:nil];

                    [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                        //NSLog(@"responseData=%@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
                    }];
                }
            }
        }];
    }
    
    
    
    if([msCamera.state isEqualToString:@"breakfast"])
        [self setMealImage:0 :msValueImageView.squareFoodPictureImage];
    if([msCamera.state isEqualToString:@"lunch"])
        [self setMealImage:1 :msValueImageView.squareFoodPictureImage];
    if([msCamera.state isEqualToString:@"supper"])
        [self setMealImage:2 :msValueImageView.squareFoodPictureImage];
    
    [self cancel_image:sender];
}

-(void) cancel_image:(id)sender{
    msCamera.state = nil;
    [self showTabBar:self.tabBarController];
    naviBar.topItem.title = @"Today Menu";
    [msValueImageView removeFromSuperview];
}

-(void) setMealImage:(int)type :(UIImage*)image{
    CGRect image_rect = CGRectMake(0, (image.size.height-no_image_size.height)/2,
                                   image.size.width,
                                   image.size.height*no_image_size.height/no_image_size.width);
    UIImage *image0,*frame;
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
    
    UIGraphicsBeginImageContext(CGSizeMake(no_image_size.width, no_image_size.height));
    [image0 drawInRect:CGRectMake(0, 0, no_image_size.width, no_image_size.height)];
    [frame drawInRect:CGRectMake(0, 0, no_image_size.width, no_image_size.height)];
    
    switch (type) {
        case 0:
            breakfastImageView.image = UIGraphicsGetImageFromCurrentImageContext();
            breakfastImageView.userInteractionEnabled = NO;
            break;
        case 1:
            lunchImageView.image = UIGraphicsGetImageFromCurrentImageContext();
            lunchImageView.userInteractionEnabled = NO;
            break;
        case 2:
            supperImageView.image = UIGraphicsGetImageFromCurrentImageContext();
            supperImageView.userInteractionEnabled = NO;
            break;
    }
    UIGraphicsEndImageContext();
    
}

@end
