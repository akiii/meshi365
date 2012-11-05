
#import <UIKit/UIKit.h>
#import "MSCameraViewController.h"
#import "MSValueImageView.h"
#import "MSAWSConnector.h"

@interface MSTodayMealViewController : UIViewController<UIActionSheetDelegate>{
    
    UIActivityIndicatorView *indicator[3];
    UIScrollView *scv;
    
    UIImageView *mealImageView[3];
    UIImageView *otherImageView;
    
    MSCameraViewController *msCamera;
    MSValueImageView *msValueImageView;
    
    
    UIActionSheet *as;
    
    UINavigationBar *naviBar;
    
    int cntOtherImage;
    int flag_async;
}


@property(nonatomic,strong)	NSArray *jsonArray;

@end
