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

- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
	// メソッドに渡された scrollView を使って、先ほどと同じ方法で、現在位置からページ番号を割り出します。
	
	//[self setContentOffset:CGPointMake(0.0f, 0.0f) animated:YES];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)_scrollView
willDecelerate:(BOOL)decelerate
{
	//    offset.x = _scrollView.contentOffset.x/screenScale;
	// offset.y = _scrollView.contentOffset.y/screenScale;

	[self setContentOffset:CGPointMake(0.0f, 0.0f) animated:YES];

}

@end
