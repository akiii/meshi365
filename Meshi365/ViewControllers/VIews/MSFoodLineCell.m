//
//  MSFoodLineCell.m
//  Meshi365
//
//  Created by Mlle.Irene on 2012/10/28.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSFoodLineCell.h"

@implementation MSFoodLineCell


- (void) layoutSubviews {
    [super layoutSubviews];
	
	
	
	int x = 10;
	int y = 10;
	int dy=30;
	
	self.textLabel.text = @"Break Fast";
	self.textLabel.frame =  CGRectMake(x, y, [UIScreen mainScreen].bounds.size.width,30);

	
	self.detailTextLabel.text = @"hh:mm dd/MM/yy";
	self.detailTextLabel.textAlignment =  NSTextAlignmentLeft;
	self.detailTextLabel.frame =  CGRectMake(x+100, y, [UIScreen mainScreen].bounds.size.width,30);
	y+=dy;
	
	int length = [UIScreen mainScreen].bounds.size.width-20;
	self.imageView.image = [UIImage imageNamed:@"sampleMenu.png"];
	self.imageView.frame = CGRectMake(x, y, length,length);
    self.imageView.contentMode = UIViewContentModeScaleToFill;
	y+=length+10;
	
	
	UILabel *menuName = [[UILabel alloc] initWithFrame:CGRectMake(x, y, [UIScreen mainScreen].bounds.size.width, 30)];
	[menuName setFont:[UIFont systemFontOfSize:18]];
	menuName.text = @"Rice";
	[self addSubview:menuName];
	y+=dy;


	UILabel *storeName = [[UILabel alloc] initWithFrame:CGRectMake(x, y, [UIScreen mainScreen].bounds.size.width, 30)];
	[storeName setFont:[UIFont systemFontOfSize:18]];
	storeName.text = @"Starbucks";
	[self addSubview:storeName];
	y+=dy;
	
	
	int maxStar = 5;
	UIImageView *starImg[maxStar];
	int starSize = 30;
	int starNum = 3;
	for(int i = 0; i < maxStar; i++)
	{
		starImg[i] = [[UIImageView alloc]initWithFrame:CGRectMake(x+starSize*i, y, starSize, starSize)];
		if(i < starNum)starImg[i].image = [UIImage imageNamed:@"star.png"];
		else starImg[i].image = [UIImage imageNamed:@"starNonSelect.png"];
		
		starImg[i].contentMode = UIViewContentModeScaleAspectFit;
		[self addSubview:starImg[i]];
	}
	
	

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		
        // accessory
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
		
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
