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


-(void)setLayout:(int)tableNum
{
	
	self.backgroundColor = [UIColor cyanColor];
	self.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*tableNum/3.0f, 0);
	self.showsHorizontalScrollIndicator = YES;
	self.showsVerticalScrollIndicator = NO;
	self.bounces = YES;
	self.pagingEnabled = NO;
	
	[self setDecelerationRate:UIScrollViewDecelerationRateFast];
	
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

//
- (void)fixScrollOffset
{
	
	int step = [UIScreen mainScreen].bounds.size.width/3;
	float stopX = (int)((self.contentOffset.x+ step*0.5f) / step) * step;
	[self setContentOffset:CGPointMake( stopX, 0.0f) animated:YES];
	
	
	
	//	if(stopX >= self.contentSize.width - step*4 - 5)
	//	{
	//		[self setContentOffset:CGPointMake( self.frame.size.width/2.0f, 0.0f) animated:YES];
	//		[self setContentOffset:CGPointMake( 80, 0.0f) animated:NO];
	//
	//	}
	//
	
}

- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
	[self fixScrollOffset];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)_scrollView
				  willDecelerate:(BOOL)decelerate
{
	if(decelerate == NO)
		[self fixScrollOffset];
}


//-(void)scrollViewDidScroll:
//(UIScrollView *)scrollView
//{
//	int step = [UIScreen mainScreen].bounds.size.width/3;
//	if(self.contentOffset.x >= self.contentSize.width - step*4)
//	{
//
//		//TODO:画面端に来ているので最読み込みをさせるように
//		[self setContentOffset:CGPointMake( self.frame.size.width/2.0f, 0.0f) animated:YES];
//
//	}
//
//
//}

@end
