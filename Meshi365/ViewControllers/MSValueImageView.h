#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MSFoodPictureImage.h"

#define kNumOfStars 5

@interface MSValueImageView : UIScrollView<UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate,CLLocationManagerDelegate,UIScrollViewDelegate,UITextFieldDelegate,UITextViewDelegate>{
    Boolean observing;
    
    UIButton *star[kNumOfStars];
    UIImageView *im;
    
    //For XMLParser
    int node_flag;
    int amenity_flag;
    NSString *name_amenity,*node_latitude,*node_longitude;
    NSMutableArray *nameArray,*amenityArray,*locationArray;
    
    CLLocationManager *locationManager;
    double latitude, longitude;
    
    UITextView *comment;
    UITextField *mealNameTextField;
    
    UIButton *twitterBtn;
    UIButton *facebookBtn;
}

@property (nonatomic       ) int cnt_stars;
@property (nonatomic       ) int place_amenity;
@property (nonatomic       ) Boolean flag_twitter;
@property (nonatomic       ) Boolean flag_facebook;
@property (nonatomic,strong) NSString *place_name;
@property (nonatomic,strong) UIImage *cameraImage;
@property (nonatomic,strong) MSFoodPictureImage *squareFoodPictureImage;
@property (nonatomic,strong) UIView *darkView;

-(void) dataPreservation;

@end
