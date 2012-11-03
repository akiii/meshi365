
#import <UIKit/UIKit.h>
#import "MSCameraViewController.h"
#import "MSValueImageView.h"
#import "MSAWSConnector.h"

@interface MSTodayMealViewController : UIViewController<UIActionSheetDelegate>{
    
    UIActivityIndicatorView *indicator[3];
    
    UIImageView *mealImageView[3];
    UIImageView *otherImageView;
    
    MSCameraViewController *msCamera;
    MSValueImageView *msValueImageView;
    
    UIActionSheet *as;
    
    UINavigationBar *naviBar;
    
    CGSize no_image_size;
    
    int cntOtherImage;
    int flag_async;
}

@end
