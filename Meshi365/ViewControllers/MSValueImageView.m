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
    CGRect image_rect = CGRectMake(0, (self.original_image.size.height-self.original_image.size.width)/2,
                                   self.original_image.size.width,
                                   self.original_image.size.width);
    self.resized_image = [UIImage imageWithCGImage:CGImageCreateWithImageInRect( [self.original_image CGImage], image_rect)];
    
    UIImageView *im = [[UIImageView alloc] initWithImage:self.resized_image];
    im.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width-200)/2, 30, 200, 200);
    [self addSubview:im];

    
    UIButton *cancel_button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancel_button.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2-85, 260, 80, 30);
    [cancel_button setTitle:@"cancel" forState:UIControlStateNormal];
    [cancel_button addTarget:self.delegate action:@selector(cancel_image:)
          forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancel_button];
    
    UIButton *save_button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    save_button.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2+5, 260, 80, 30);
    [save_button setTitle:@"save" forState:UIControlStateNormal];
    [save_button addTarget:self.delegate action:@selector(save_image:)
          forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:save_button];
}


@end
