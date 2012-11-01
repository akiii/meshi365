#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MSFoodPictureImage.h"

#define kNumOfStars 5

@interface MSValueImageView : UIScrollView<UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate,CLLocationManagerDelegate,UIScrollViewDelegate,UITextViewDelegate>{
    UIButton *star[kNumOfStars];
    UIImageView *im;
    
    //For XMLParser
    int node_flag,amenity_flag;
    NSString *name_amenity,*node_latitude,*node_longitude;
    NSMutableArray *nameArray,*amenityArray,*locationArray;
    
    CLLocationManager *locationManager;
    double latitude, longitude;
    
    UITextView *comment;
    UITextField *meal_name;
}

@property (nonatomic       ) int cnt_stars;
@property (nonatomic,strong) NSString *comment_text;
@property (nonatomic,strong) NSString *meal_name;
@property (nonatomic,strong) NSString *place_name;
@property (nonatomic,strong) NSString *place_amenity;
@property (nonatomic,strong) UIImage *cameraImage;
@property (nonatomic,strong) MSFoodPictureImage *squareFoodPictureImage;

@end
