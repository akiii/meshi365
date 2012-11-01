#import "MSCameraViewController.h"

@interface MSCameraViewController ()
@end

@implementation MSCameraViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.delegate = self;
    }
    return self;
}

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingImage:(UIImage*)image editingInfo:(NSDictionary*)editingInfo{
    CGRect image_rect;
    if(image.size.height>image.size.width)
        image_rect = CGRectMake(0, (image.size.height-image.size.width)/2,
                                image.size.width,
                                image.size.width);
    else    image_rect = CGRectMake((image.size.width-image.size.height)/2, 0,
                                    image.size.height,
                                    image.size.height);
    
    self.camera_image = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([image CGImage], image_rect)];

    [self dismissModalViewControllerAnimated:NO];
}

//画像の保存完了時に呼ばれるメソッド
-(void)targetImage:(UIImage*)image
didFinishSavingWithError:(NSError*)error contextInfo:(void*)context{
    if(error){
    }else{
    }
}



//画像の選択がキャンセルされた時に呼ばれる
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    self.state = nil;
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end
