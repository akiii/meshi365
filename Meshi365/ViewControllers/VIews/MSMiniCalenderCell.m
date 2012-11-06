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

	float y = 2;
	_label.backgroundColor = [UIColor colorWithRed:0.97 green:0.96 blue:0.5 alpha:0.6];
	//_label.backgroundColor = DEFAULT_BGCOLOR;
	switch (_foodPicture.mealType) {
		case 0:
			_label.text = @"Breakfast";
			_label.frame =  CGRectMake(0, y, length-30,20);

			break;
		case 1:
			_label.text = @"Lunch";
			_label.frame =  CGRectMake(0, y, length-55,20);

			break;
		case 2:
			_label.text = @"Supper";
			_label.frame =  CGRectMake(0, y, length-45,20);

			break;
		case 3:
			_label.text = @"other";
			_label.frame =  CGRectMake(0, y, length-57,20);

			break;
	}
	//self.textLabel.text = [NSString stringWithFormat:@"%d" ,self.indexPathRow ];
	if(_foodPicture == nil)
	{
		_label.text = @"";
		_label.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
	}
	
	
	
	
	_foodImgView.frame = CGRectMake(0, y, length-10,length-10);
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
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
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

