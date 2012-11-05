//
//  MSFoodLineCell.m
//  Meshi365
//
//  Created by Mlle.Irene on 2012/10/28.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSFoodLineCell.h"

@interface MSFoodLineCell()


@property(nonatomic,strong)UILabel *comment;
@property(nonatomic,strong)UIImageView* profileImageView;
@property(nonatomic,strong)UILabel *userName;
@property(nonatomic,strong)UILabel *storeName;
@property(nonatomic,strong)UILabel *menuName;
@property(nonatomic,strong)NSMutableArray *starArray;

@end

@implementation MSFoodLineCell


- (void) layoutSubviews {
    [super layoutSubviews];

	
	int fontSize =  26;
	int x = 15;
	int y = 10;
	int dy=30;
	int length = 50;
	_profileImageView.image = _profileImage;
	_profileImageView.frame = CGRectMake(x, y, length,length);
	
	
	_userName.frame =CGRectMake(x+length+10, y+fontSize/2, [UIScreen mainScreen].bounds.size.width, fontSize+5);
	_userName.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
	[_userName setFont:[UIFont systemFontOfSize:fontSize]];
	[_userName setText:_foodPicture.user.name];
	y+=length;
	
	
	switch (_foodPicture.mealType) {
		case 0:self.textLabel.text = @"Breakfast";break;
		case 1:self.textLabel.text = @"Lunch";break;
		case 2:self.textLabel.text = @"Dinner";break;
		default:self.textLabel.text = @"Dessert";break;break;
	}
	//self.textLabel.text = [NSString stringWithFormat:@"%d" ,self.indexPathRow ];
	
	self.textLabel.frame =  CGRectMake(x, y, [UIScreen mainScreen].bounds.size.width,30);
	
	
	self.detailTextLabel.text = [NSString stringWithFormat:@"Date:%@",_foodPicture.createdAt];
	self.detailTextLabel.textAlignment =  NSTextAlignmentLeft;
	self.detailTextLabel.frame =  CGRectMake(x+90, y, [UIScreen mainScreen].bounds.size.width,30);
	y+=dy;

	
	
	length = [UIScreen mainScreen].bounds.size.width-100;
	int imagePosX = ([UIScreen mainScreen].bounds.size.width  - length )/2;
	self.imageView.image = _foodImage;
	self.imageView.frame = CGRectMake(imagePosX, y, length,length);
	y+=length+10;

	
	
	int starSize = 30;
	int maxStar = 5;
	int starNum = _foodPicture.starNum;
	int starPosX =  ([UIScreen mainScreen].bounds.size.width- starSize*maxStar)/2;
	for(int i = 0; i < maxStar; i++)
	{
		UIImageView *star = [_starArray objectAtIndex:i];
		star.frame = CGRectMake(starPosX+i*starSize, y, starSize, starSize);
		if(i < starNum)star.image = [UIImage imageNamed:@"star.png"];
		else star.image = [UIImage imageNamed:@"starNonSelect.png"];		
	}
	y+=starSize+5;
	

	[_storeName setHidden:YES];
	[_menuName setHidden:YES];
	[_comment setHidden:YES];

	fontSize = 18;
	if(_foodPicture.storeName != nil)
	{
		[_storeName setHidden:NO];
		_storeName.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
		_storeName.frame = CGRectMake(x, y, [UIScreen mainScreen].bounds.size.width, fontSize);
		[_storeName setFont:[UIFont systemFontOfSize:fontSize]];
		_storeName.text = [NSString stringWithFormat:@"Place:%@",_foodPicture.storeName ];
		y+=dy;
	}

	
	if(_foodPicture.menuName != nil)
	{
		[_menuName setHidden:NO];
		_menuName.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
		_menuName.frame = CGRectMake(x, y, [UIScreen mainScreen].bounds.size.width, fontSize);
		[_menuName setFont:[UIFont systemFontOfSize:fontSize]];
		_menuName.text = [NSString stringWithFormat:@"Menu:%@",_foodPicture.menuName ];
		y+=dy;

	}
	
	if(_foodPicture.comment != nil)
	{
		[_comment setHidden:NO];
		_comment.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
		_comment.frame = CGRectMake(x, y, [UIScreen mainScreen].bounds.size.width, 30);
		[_comment setFont:[UIFont systemFontOfSize:18]];
		_comment.text = [NSString stringWithFormat:@"Comment:%@",_foodPicture.comment ];
		y+=dy;

	}

	self.height = y;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		self.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
		
		int maxStar =5;
		_starArray = [NSMutableArray array];
		for(int i = 0; i < maxStar; i++)
		{
			UIImageView *star = [[UIImageView alloc]init];
			star.contentMode= UIViewContentModeScaleAspectFit;
			[self addSubview:star];
			[_starArray addObject: star];
		}

		_profileImageView	= [[UIImageView alloc]init];
		_storeName			= [[UILabel alloc] init];
		_menuName			= [[UILabel alloc] init];
		_comment			= [[UILabel alloc] init];
		_userName			= [[UILabel alloc] init];

		
		_profileImageView.contentMode	= UIViewContentModeScaleToFill;
		self.imageView.contentMode		= UIViewContentModeScaleToFill;
		
		//self.contentView
		[self.contentView addSubview:_profileImageView];
		[self.contentView addSubview:_userName];
		[self.contentView addSubview:_comment];
		[self.contentView addSubview:_menuName];
		[self.contentView addSubview:_storeName];
		
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
