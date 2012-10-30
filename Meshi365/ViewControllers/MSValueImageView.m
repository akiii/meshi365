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
    
    CGRect image_rect = CGRectMake(0, (self.original_image.size.height-self.original_image.size.width)/2,
                                   self.original_image.size.width,
                                   self.original_image.size.width);
    self.resized_image = [UIImage imageWithCGImage:CGImageCreateWithImageInRect
                            ([self.original_image CGImage], image_rect)];
    
    UIImageView *im = [[UIImageView alloc] initWithImage:self.resized_image];
    im.frame = CGRectMake(left_line, 30, 200, 200);
    [self addSubview:im];

    
    star0 = [UIButton buttonWithType:UIButtonTypeCustom];
    star1 = [UIButton buttonWithType:UIButtonTypeCustom];
    star2 = [UIButton buttonWithType:UIButtonTypeCustom];
    star3 = [UIButton buttonWithType:UIButtonTypeCustom];
    star4 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [star0 setBackgroundImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
    [star1 setBackgroundImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
    [star2 setBackgroundImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
    [star3 setBackgroundImage:[UIImage imageNamed:@"starNonSelect.png"] forState:UIControlStateNormal];
    [star4 setBackgroundImage:[UIImage imageNamed:@"starNonSelect.png"] forState:UIControlStateNormal];
    
    star0.frame = CGRectMake(left_line,240,30,30);
    star1.frame = CGRectMake(left_line+30,240,30,30);
    star2.frame = CGRectMake(left_line+60,240,30,30);
    star3.frame = CGRectMake(left_line+90,240,30,30);
    star4.frame = CGRectMake(left_line+120,240,30,30);
    
    [star0 addTarget:self action:@selector(tap_star0:) forControlEvents:UIControlEventTouchDown];
    [star1 addTarget:self action:@selector(tap_star1:) forControlEvents:UIControlEventTouchDown];
    [star2 addTarget:self action:@selector(tap_star2:) forControlEvents:UIControlEventTouchDown];
    [star3 addTarget:self action:@selector(tap_star3:) forControlEvents:UIControlEventTouchDown];
    [star4 addTarget:self action:@selector(tap_star4:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:star0];
    [self addSubview:star1];
    [self addSubview:star2];
    [self addSubview:star3];
    [self addSubview:star4];
    
    
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

-(void) tap_star0:(id)sender{
    self.cnt_stars = 1;
    [star0 setBackgroundImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
    [star1 setBackgroundImage:[UIImage imageNamed:@"starNonSelect.png"] forState:UIControlStateNormal];
    [star2 setBackgroundImage:[UIImage imageNamed:@"starNonSelect.png"] forState:UIControlStateNormal];
    [star3 setBackgroundImage:[UIImage imageNamed:@"starNonSelect.png"] forState:UIControlStateNormal];
    [star4 setBackgroundImage:[UIImage imageNamed:@"starNonSelect.png"] forState:UIControlStateNormal];
}
-(void) tap_star1:(id)sender{
    self.cnt_stars = 2;
    [star0 setBackgroundImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
    [star1 setBackgroundImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
    [star2 setBackgroundImage:[UIImage imageNamed:@"starNonSelect.png"] forState:UIControlStateNormal];
    [star3 setBackgroundImage:[UIImage imageNamed:@"starNonSelect.png"] forState:UIControlStateNormal];
    [star4 setBackgroundImage:[UIImage imageNamed:@"starNonSelect.png"] forState:UIControlStateNormal];
}
-(void) tap_star2:(id)sender{
    self.cnt_stars = 3;
    [star0 setBackgroundImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
    [star1 setBackgroundImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
    [star2 setBackgroundImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
    [star3 setBackgroundImage:[UIImage imageNamed:@"starNonSelect.png"] forState:UIControlStateNormal];
    [star4 setBackgroundImage:[UIImage imageNamed:@"starNonSelect.png"] forState:UIControlStateNormal];
}
-(void) tap_star3:(id)sender{
    self.cnt_stars = 4;
    [star0 setBackgroundImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
    [star1 setBackgroundImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
    [star2 setBackgroundImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
    [star3 setBackgroundImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
    [star4 setBackgroundImage:[UIImage imageNamed:@"starNonSelect.png"] forState:UIControlStateNormal];
}
-(void) tap_star4:(id)sender{
    self.cnt_stars = 5;
    [star0 setBackgroundImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
    [star1 setBackgroundImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
    [star2 setBackgroundImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
    [star3 setBackgroundImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
    [star4 setBackgroundImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
}

@end
