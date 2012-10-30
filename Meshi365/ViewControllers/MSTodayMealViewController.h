#import <UIKit/UIKit.h>
#import "MSCameraViewController.h"
#import "MSValueImageView.h"

@interface MSTodayMealViewController : UIViewController{
    UIImageView *breakfastImageView;
    UIImageView *lunchImageView;
    UIImageView *supperImageView;
    
    MSCameraViewController *msCamera;
    MSValueImageView *msValueImageView;
    
    CGSize no_image_size;
}

@end
