
#import <UIKit/UIKit.h>
#import "MSCameraViewController.h"
#import "MSValueImageView.h"
#import "MSAWSConnector.h"

@interface MSTodayMealViewController : UIViewController<UIActionSheetDelegate>{
    UIImageView *breakfastImageView;
    UIImageView *lunchImageView;
    UIImageView *supperImageView;
    
    MSCameraViewController *msCamera;
    MSValueImageView *msValueImageView;
    
    UIActionSheet *as;
    
    CGSize no_image_size;
}

@end
