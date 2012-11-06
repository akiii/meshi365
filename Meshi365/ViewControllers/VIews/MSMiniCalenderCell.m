//
//  MSMiniCalenderCell.m
//  Meshi365
//
//  Created by Mlle.Irene on 2012/11/06.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSMiniCalenderCell.h"
#import "MSImageLoader.h"


@interface MSMiniCalenderCell()


@property(nonatomic,strong)UIImageView* foodImgView;
@property(nonatomic,strong)UILabel *label;

@end

@implementation MSMiniCalenderCell


- (void) layoutSubviews {
    [super layoutSubviews];
	int length = [UIScreen mainScreen].bounds.size.width/3;

	
	switch (_foodPicture.mealType) {
		case 0:_label.text = @"Breakfast";break;
		case 1:_label.text = @"Lunch";break;
		case 2:_label.text = @"Dinner";break;
		case 3:_label.text = @"other";break;
	}
	//self.textLabel.text = [NSString stringWithFormat:@"%d" ,self.indexPathRow ];
	if(_foodPicture == nil)_label.text = @"";

	_label.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
	_label.frame =  CGRectMake(0, 0, length,30);
	
	
	_foodImgView.frame = CGRectMake(0, 2, length-10,length-10);
	_foodImgView.image = _foodImage;

	
	_foodImgIdctr.color = DEFAULT_INDICATOR_COLOR;
	[_foodImgIdctr setCenter:CGPointMake(length/2.0f,length/2.0f)];
	[_foodImgIdctr setTransform:FOOD_LINE_PROFILE_INDICATOR_TRANSFORM];
	
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		self.backgroundColor = DEFAULT_BGCOLOR;
		
		
		_foodImgIdctr = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		_label			= [[UILabel alloc] init];
		
		_foodImgView = [[UIImageView alloc] init];
		_foodImgView.contentMode		= UIViewContentModeScaleToFill;
		_foodImgView.backgroundColor = DEFAULT_BGCOLOR;
		//self.contentView
		[self.contentView addSubview:_foodImgView];
		[self.contentView addSubview:_label];
		[_foodImgView addSubview:_foodImgIdctr];
		
		
		[self layoutSubviews];
	}
    return self;
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
	
    // Configure the view for the selected state
}



@end

