//
//  MSMiniCalenderScrollView.m
//  Meshi365
//
//  Created by Mlle.Irene on 2012/10/29.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSMiniCalenderScrollView.h"

@implementation MSMiniCalenderScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		self.delegate = self;
	
	
	}
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (void)fixScrollOffset
{
	
	int step = [UIScreen mainScreen].bounds.size.width/3;
	float stopX = (int)((self.contentOffset.x+ step*0.5f) / step) * step;
	[self setContentOffset:CGPointMake( stopX, 0.0f) animated:YES];
	
}

- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
	[self fixScrollOffset];
}



- (void)scrollViewDidEndDragging:(UIScrollView *)_scrollView
willDecelerate:(BOOL)decelerate
{
	if(decelerate == 0)
		[self fixScrollOffset];
}

@end
