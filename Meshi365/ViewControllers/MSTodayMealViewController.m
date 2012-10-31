#import "MSTodayMealViewController.h"

@interface MSTodayMealViewController ()

@end

@implementation MSTodayMealViewController

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
    breakfastImageView.frame = CGRectMake(20,30,no_image_size.width ,no_image_size.height);
    lunchImageView.frame = CGRectMake(20,130,no_image_size.width ,no_image_size.height);
    supperImageView.frame = CGRectMake(20,230,no_image_size.width ,no_image_size.height);
    
    breakfastImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    //画像の表示
    [self.view addSubview:breakfastImageView];
    [self.view addSubview:lunchImageView];
    [self.view addSubview:supperImageView];
    
    UILabel *othersLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 310, 80, 30)];
    othersLabel.backgroundColor = [UIColor clearColor];
    othersLabel.text = @"Others";
    [self.view addSubview:othersLabel];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSLog(@"%@",msCamera.state);
    if([msCamera.state isEqualToString:@"breakfast"]||[msCamera.state isEqualToString:@"lunch"]||[msCamera.state isEqualToString:@"supper"]){
        msValueImageView = [[MSValueImageView alloc] init];
        msValueImageView.delegate = self;
        msValueImageView.cameraImage = msCamera.camera_image;
        
        self.tabBarController.tabBar.hidden=YES;
        [self.view addSubview:msValueImageView];
    }
}

-(void)breakfastCameraAction{
    NSLog(@"Breakfast");
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        msCamera.state = @"breakfast";
        [as showFromTabBar:self.tabBarController.tabBar];
    }
}

-(void)lunchCameraAction{
    NSLog(@"Lunch");
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        msCamera.state = @"lunch";
        [as showFromTabBar:self.tabBarController.tabBar];
    }
}

-(void)supperCameraAction{
    NSLog(@"Supper");
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
    NSLog(@"%@", [MSAWSConnector postFoodPictureToAWS:msValueImageView.squareFoodPictureImage]);
    
    CGRect image_rect = CGRectMake(0, (msValueImageView.squareFoodPictureImage.size.height-no_image_size.height)/2,
                                   msValueImageView.squareFoodPictureImage.size.width,
                                   msValueImageView.squareFoodPictureImage.size.height*no_image_size.height/no_image_size.width);
    if([msCamera.state isEqualToString:@"breakfast"])
        breakfastImageView.image = [UIImage imageWithCGImage:CGImageCreateWithImageInRect
                                    ([msValueImageView.squareFoodPictureImage CGImage], image_rect)];
    if([msCamera.state isEqualToString:@"lunch"])
        lunchImageView.image = [UIImage imageWithCGImage:CGImageCreateWithImageInRect
                                    ([msValueImageView.squareFoodPictureImage CGImage], image_rect)];
    if([msCamera.state isEqualToString:@"supper"])
        supperImageView.image = [UIImage imageWithCGImage:CGImageCreateWithImageInRect
                                    ([msValueImageView.squareFoodPictureImage CGImage], image_rect)];
    msCamera.state = nil;
    self.tabBarController.tabBar.hidden=NO;
    [msValueImageView removeFromSuperview];
}

-(void) cancel_image:(id)sender{
    self.tabBarController.tabBar.hidden=NO;
    [msValueImageView removeFromSuperview];
}

@end
