#import <UIKit/UIKit.h>

@interface MSCameraViewController : UIImagePickerController
<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,strong) UIImage *camera_image;
@property (nonatomic,strong) NSString *state;

@end
