#import <UIKit/UIKit.h>

@interface MSValueImageView : UIView

@property (nonatomic,strong) id delegate;
@property (nonatomic,strong) UIImage *original_image;
@property (nonatomic,strong) UIImage *resized_image;

@end
