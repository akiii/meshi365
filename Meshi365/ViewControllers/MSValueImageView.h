#import <UIKit/UIKit.h>

@interface MSValueImageView : UIView{
    UIButton *star0,*star1,*star2,*star3,*star4;
}

@property (nonatomic,strong) id delegate;
@property (nonatomic       ) int cnt_stars;
@property (nonatomic,strong) UIImage *original_image;
@property (nonatomic,strong) UIImage *resized_image;

@end
