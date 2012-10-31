#import <UIKit/UIKit.h>
#import "MSFoodPictureImage.h"

#define kNumOfStars 5

@interface MSValueImageView : UIView<UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate>{
    UIButton *star[kNumOfStars];
    
    
    //For XMLParser
    int node_flag,amenity_flag;
    NSString *name_amenity,*node_latitude,*node_longitude;
    NSMutableArray *nameArray,*amenityArray,*locationArray;
    
}

@property (nonatomic,strong) id delegate;
@property (nonatomic       ) int cnt_stars;
@property (nonatomic,strong) UIImage *cameraImage;
@property (nonatomic,strong) MSFoodPictureImage *squareFoodPictureImage;

@end
