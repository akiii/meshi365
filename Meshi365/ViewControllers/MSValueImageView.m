#import "MSValueImageView.h"

@implementation MSValueImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = [[UIScreen mainScreen] bounds];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    int left_line = ([[UIScreen mainScreen] bounds].size.width-200)/2;
    
    self.cnt_stars = 3;
    
    CGRect image_rect = CGRectMake(0, (self.cameraImage.size.height-self.cameraImage.size.width)/2,
                                   self.cameraImage.size.width,
                                   self.cameraImage.size.width);
    self.squareFoodPictureImage = [[MSFoodPictureImage alloc] initWithCGImage:CGImageCreateWithImageInRect([self.cameraImage CGImage], image_rect)];
    
    UIImageView *im = [[UIImageView alloc] initWithImage:self.squareFoodPictureImage];
    im.frame = CGRectMake(left_line, 30, 200, 200);
    [self addSubview:im];

    for (int i = 0; i < kNumOfStars; i++) {
        star[i] = [UIButton buttonWithType:UIButtonTypeCustom];
        star[i].frame = CGRectMake(left_line + 30 * i, 240, 30, 30);
        star[i].tag = i;
        [self setBackgroundImageOfStarButton:star[i].tag];
        [star[i] addTarget:self action:@selector(tap_star0:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:star[i]];
    }    
    
    UIButton *cancel_button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancel_button.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2-85, 300, 80, 30);
    [cancel_button setTitle:@"cancel" forState:UIControlStateNormal];
    [cancel_button addTarget:self.delegate action:@selector(cancel_image:)
          forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancel_button];
    
    UIButton *save_button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    save_button.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2+5, 300, 80, 30);
    [save_button setTitle:@"save" forState:UIControlStateNormal];
    [save_button addTarget:self.delegate action:@selector(save_image:)
          forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:save_button];
}

-(void) tap_star0:(UIButton *)sender{
    self.cnt_stars = sender.tag + 1;
    for (int i = 0; i < kNumOfStars; i++) {
        [self setBackgroundImageOfStarButton:star[i].tag];
    }
    self.squareFoodPictureImage.foodPicture.starNum = self.cnt_stars;
}

- (void)setBackgroundImageOfStarButton:(int)tag{
    UIImage *backgroundImage;
    if (tag < self.cnt_stars) {
        backgroundImage = [UIImage imageNamed:@"star.png"];
    }else {
        backgroundImage = [UIImage imageNamed:@"starNonSelect.png"];
    }
    [star[tag] setBackgroundImage:backgroundImage forState:UIControlStateNormal];
}

@end
