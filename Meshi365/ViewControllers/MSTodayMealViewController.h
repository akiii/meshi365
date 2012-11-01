
#import <UIKit/UIKit.h>
#import "MSCameraViewController.h"
#import "MSSignUpViewController.h"
#import "MSValueImageView.h"
#import "MSAWSConnector.h"

@interface MSTodayMealViewController : UIViewController<UIActionSheetDelegate>{
    
    UIImageView *breakfastImageView;
    UIImageView *lunchImageView;
    UIImageView *supperImageView;
    UIImageView *otherImageView;
    
    MSCameraViewController *msCamera;
    MSValueImageView *msValueImageView;
    
    UIActionSheet *as;
    
    UINavigationBar *naviBar;
    
    CGSize no_image_size;
    
    int cntOtherImage;
}

@end
