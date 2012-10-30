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
    UIImageView *im = [[UIImageView alloc] initWithImage:self.original_image];
    im.frame = CGRectMake(0, 0, 100, 100);
    [self addSubview:im];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 200, 200)];
    lbl.text = @"test";
    [self addSubview:lbl];
    
    UIButton *save_button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    save_button.frame = CGRectMake(120, 100, 80, 30);
    [save_button setTitle:@"save" forState:UIControlStateNormal];
    [save_button addTarget:self.delegate action:@selector(save_image:)
        forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:save_button];
}


@end
