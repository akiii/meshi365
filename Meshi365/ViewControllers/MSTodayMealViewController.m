#import "MSTodayMealViewController.h"

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
    msCamera.state = nil;
    
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
    
    UILabel *othersLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 300, 80, 30)];
    othersLabel.backgroundColor = [UIColor clearColor];
    othersLabel.text = @"Others";
    [self.view addSubview:othersLabel];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    naviBar.topItem.title = @"Today Menu";
    if([msCamera.state isEqualToString:@"breakfast"]||[msCamera.state isEqualToString:@"lunch"]||[msCamera.state isEqualToString:@"supper"]){
        msValueImageView = [[MSValueImageView alloc] init];
        msValueImageView.cameraImage = msCamera.camera_image;
        
        naviBar.topItem.title = @"Food Image Config";
        [self hideTabBar:self.tabBarController];
        [self.view addSubview:msValueImageView];
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //MSSignUpViewController *view = [[MSSignUpViewController alloc]init];
    //[self presentModalViewController:view animated:YES];
    
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

-(void) save_image:(id)sender{
    NSString *urlString = [MSAWSConnector uploadFoodPictureToAWS:msValueImageView.squareFoodPictureImage];
    msValueImageView.squareFoodPictureImage.foodPicture.uiid = [MSUser currentUser].uiid;
    
//    msValueImageView.squareFoodPictureImage.foodPicture.starNum=
//    msValueImageView.squareFoodPictureImage.foodPicture.comment=
    
    
//    image.foodPicture.uiid = [MSUser currentUser].uiid;
//    image.foodPicture.url = urlString;
//    
//    [MSNetworkConnector requestToUrl:URL_OF_POST_FOOD_PICTURE method:RequestMethodPost params:image.foodPicture.params block:^(NSData *response) {}];
    
    
    CGRect image_rect = CGRectMake(0, (msValueImageView.squareFoodPictureImage.size.height-no_image_size.height)/2,
                                   msValueImageView.squareFoodPictureImage.size.width,
                                   msValueImageView.squareFoodPictureImage.size.height*no_image_size.height/no_image_size.width);
    if([msCamera.state isEqualToString:@"breakfast"]){
        breakfastImageView.image = [UIImage imageWithCGImage:CGImageCreateWithImageInRect
                                    ([msValueImageView.squareFoodPictureImage CGImage], image_rect)];
        breakfastImageView.userInteractionEnabled = NO;
    }
    if([msCamera.state isEqualToString:@"lunch"]){
        lunchImageView.image = [UIImage imageWithCGImage:CGImageCreateWithImageInRect
                                    ([msValueImageView.squareFoodPictureImage CGImage], image_rect)];
        lunchImageView.userInteractionEnabled = NO;
    }
    if([msCamera.state isEqualToString:@"supper"]){
        supperImageView.image = [UIImage imageWithCGImage:CGImageCreateWithImageInRect
                                    ([msValueImageView.squareFoodPictureImage CGImage], image_rect)];
        supperImageView.userInteractionEnabled = NO;
    }
    
    msCamera.state = nil;
    [self showTabBar:self.tabBarController];
    naviBar.topItem.title = @"Today Menu";
    [msValueImageView removeFromSuperview];
}

-(void) cancel_image:(id)sender{
    msCamera.state = nil;
    [self showTabBar:self.tabBarController];
    naviBar.topItem.title = @"Today Menu";
    [msValueImageView removeFromSuperview];
}

@end
