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
	int x = 15;
	int y = 10;
	int dy=30;
	int length = 50;
	
	
	
	length = [UIScreen mainScreen].bounds.size.width-100;
	int imagePosX = ([UIScreen mainScreen].bounds.size.width  - length )/2;
	self.imageView.image = _foodImage;
	self.imageView.frame = CGRectMake(imagePosX, y, length,length);
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
	
	
	
	
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		self.height = 400;
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
