//
//  MSFoodLineCell.m
//  Meshi365
//
//  Created by Mlle.Irene on 2012/10/28.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSFoodLineCell.h"

@interface MSFoodLineCell()



@end

@implementation MSFoodLineCell


- (void) layoutSubviews {
    [super layoutSubviews];
	self.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
	
	
	int x = 10;
	int y = 10;
	int dy=30;
	

	int length = 50;
	UIImageView* profileImageView = [[UIImageView alloc]init];
	profileImageView.image = _profileImage;
	profileImageView.frame = CGRectMake(x, y, length,length);
    profileImageView.contentMode = UIViewContentModeScaleToFill;
	[self addSubview:profileImageView];
	

	UILabel *userName = [[UILabel alloc] initWithFrame:CGRectMake(x+50, y, [UIScreen mainScreen].bounds.size.width, 30)];
	[userName setFont:[UIFont systemFontOfSize:26]];
	[userName setText:_foodPicture.user.name];
	[self addSubview:userName];
	y+=length;

	
	switch (_foodPicture.mealType) {
		case 0:self.textLabel.text = @"Breakfast";break;
		case 1:self.textLabel.text = @"Lunch";break;
		case 2:self.textLabel.text = @"Dinner";break;
		default:self.textLabel.text = @"Dessert";break;break;
	}
	self.textLabel.frame =  CGRectMake(x, y, [UIScreen mainScreen].bounds.size.width,30);

	
	self.detailTextLabel.text = _foodPicture.createdAt;
	self.detailTextLabel.textAlignment =  NSTextAlignmentLeft;
	self.detailTextLabel.frame =  CGRectMake(x+100, y, [UIScreen mainScreen].bounds.size.width,30);
	y+=dy;
	
	
	length = [UIScreen mainScreen].bounds.size.width-20;
	self.imageView.image = _foodImage;
	self.imageView.frame = CGRectMake(x, y, length,length);
    self.imageView.contentMode = UIViewContentModeScaleToFill;
	y+=length+10;
	
	
	int maxStar =5;
	UIImageView *starImg[maxStar];
	int starSize = 30;
	int starNum = _foodPicture.starNum;
	for(int i = 0; i < maxStar; i++)
	{
		starImg[i] = [[UIImageView alloc]initWithFrame:CGRectMake(x+starSize*i, y, starSize, starSize)];
		if(i < starNum)starImg[i].image = [UIImage imageNamed:@"star.png"];
		else starImg[i].image = [UIImage imageNamed:@"starNonSelect.png"];
		
		starImg[i].contentMode = UIViewContentModeScaleAspectFit;
		[self addSubview:starImg[i]];
	}
	y+=starSize+5;

	
	if(_foodPicture.menuName)
	{
		UILabel *menuName = [[UILabel alloc] initWithFrame:CGRectMake(x, y, [UIScreen mainScreen].bounds.size.width, 30)];
		[menuName setFont:[UIFont systemFontOfSize:18]];
		[menuName setText:_foodPicture.menuName];
		[self addSubview:menuName];
		y+=dy;
	}
	
	
	if(_foodPicture.storeName)
	{
		UILabel *storeName = [[UILabel alloc] initWithFrame:CGRectMake(x, y, [UIScreen mainScreen].bounds.size.width, 30)];
		[storeName setFont:[UIFont systemFontOfSize:18]];
		storeName.text = _foodPicture.storeName;
		[self addSubview:storeName];
		y+=dy;
	}
	


}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		//noting to do
	}
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
