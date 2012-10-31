#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MSFoodPictureImage.h"

#define kNumOfStars 5

@interface MSValueImageView : UIView<UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate,CLLocationManagerDelegate>{
    UIButton *star[kNumOfStars];
    UIImageView *im;
    
    //For XMLParser
    int node_flag,amenity_flag;
    NSString *name_amenity,*node_latitude,*node_longitude;
    NSMutableArray *nameArray,*amenityArray,*locationArray;
    
    CLLocationManager *locationManager; // 現在地情報取得
    double latitude, longitude;
    
    
}

@property (nonatomic,strong) id delegate;
@property (nonatomic       ) int cnt_stars;
@property (nonatomic,strong) UIImage *cameraImage;
@property (nonatomic,strong) MSFoodPictureImage *squareFoodPictureImage;

@end
