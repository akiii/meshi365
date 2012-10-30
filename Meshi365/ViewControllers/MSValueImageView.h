#import <UIKit/UIKit.h>
#import "MSFoodPictureImage.h"

#define kNumOfStars 5

@interface MSValueImageView : UIView{
    UIButton *star[kNumOfStars];
}

@property (nonatomic,strong) id delegate;
@property (nonatomic       ) int cnt_stars;
@property (nonatomic,strong) UIImage *cameraImage;
@property (nonatomic,strong) MSFoodPictureImage *squareFoodPictureImage;

@end
