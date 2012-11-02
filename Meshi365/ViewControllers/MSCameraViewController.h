#import <UIKit/UIKit.h>

@interface MSCameraViewController : UIImagePickerController
<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic ) int state;
@property (nonatomic,strong) UIImage *camera_image;

@end
