//
//  MSRecommendCell.m
//  Meshi365
//
//  Created by Mlle.Irene on 2012/10/30.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSRecommendCell.h"

@interface MSRecommendCell()
@property(nonatomic, strong) NSURL* imageUrl;
@property(nonatomic,strong)UILabel *storeName;
@property(nonatomic,strong)UILabel *menuName;


@end

@implementation MSRecommendCell


- (void) layoutSubviews {
    [super layoutSubviews];
	int fontSize =  26;
	int x = 5;
	int y = 5;
	int dy=30;
	int length = 50;
	
	
	
	length = [UIScreen mainScreen].bounds.size.width/2-x*2;
	//int imagePosX = ([UIScreen mainScreen].bounds.size.width  - length )/2;
	//	self.imageView.image = _foodImage;
	self.imageView.frame = CGRectMake(x, y, length,length);
	y+=length+10;
	
	
	[_storeName setHidden:YES];
	[_menuName setHidden:YES];
	
	fontSize = 18;
	if(_foodPicture.storeName != nil)
	{
		[_storeName setHidden:NO];
		_storeName.frame = CGRectMake(x, y, [UIScreen mainScreen].bounds.size.width, fontSize);
		[_storeName setFont:[UIFont systemFontOfSize:fontSize]];
		_storeName.text = [NSString stringWithFormat:@"Place:%@",_foodPicture.storeName ];
		y+=dy;
	}
	
	
	if(_foodPicture.menuName != nil)
	{
		[_menuName setHidden:NO];
		_menuName.frame = CGRectMake(x, y, [UIScreen mainScreen].bounds.size.width, fontSize);
		[_menuName setFont:[UIFont systemFontOfSize:fontSize]];
		_menuName.text = [NSString stringWithFormat:@"Menu:%@",_foodPicture.menuName ];
		y+=dy;
		
	}
	
	
	
	self.height = y;
	
	
	
	
	
	_foodImgIdctr.color = DEFAULT_INDICATOR_COLOR;
	[_foodImgIdctr setCenter:CGPointMake(self.imageView.frame.size.width/2,self.imageView.frame.size.height/2)];
	[_foodImgIdctr setTransform:FOOD_LINE_IMAGE_INDICATOR_TRANSFORM];
	
	

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		//	self.height = 400;
		
		self.backgroundColor = DEFAULT_BGCOLOR;
		self.selectionStyle = UITableViewCellSelectionStyleNone;

		_foodImgIdctr = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];

		
		_storeName			= [[UILabel alloc] init];
		_menuName			= [[UILabel alloc] init];
		
		self.imageView.contentMode		= UIViewContentModeScaleToFill;
	
		[self.contentView addSubview:_menuName];
		[self.contentView addSubview:_storeName];
		
		[self.imageView addSubview:_foodImgIdctr];
		
		[self layoutSubviews];

    }
	
    return self;
}


- (void)updateJsonData:(NSURL*)imageUrl jsonData:(NSDictionary*)jsonData
{
	_imageUrl = imageUrl;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
	
    // Configure the view for the selected state
}


@end
