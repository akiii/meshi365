//
//  MSFoodLineCell.m
//  Meshi365
//
//  Created by Mlle.Irene on 2012/10/28.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSFoodLineCell.h"

@interface MSFoodLineCell()
@property(nonatomic, strong) NSURL* imageUrl;
@property(nonatomic, strong) NSDictionary* jsonData;



@end

@implementation MSFoodLineCell


- (void) layoutSubviews {
    [super layoutSubviews];
	self.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
	
	
	int x = 10;
	int y = 10;
	int dy=30;
	
	self.textLabel.text = @"Break Fast";
	self.textLabel.frame =  CGRectMake(x, y, [UIScreen mainScreen].bounds.size.width,30);

	
	//self.detailTextLabel.text = @"hh:mm dd/MM/yy";
	//self.detailTextLabel.text = [[_jsonData objectForKey:@"created_at"] stringValue];
	
	//__NSCFString
	//NSLog(@" class is %@",[[_jsonData objectForKey:@"created_at"] class]);
	
	self.detailTextLabel.text = [NSString stringWithFormat:@"%@",[_jsonData objectForKey:@"created_at"]];
	self.detailTextLabel.textAlignment =  NSTextAlignmentLeft;
	self.detailTextLabel.frame =  CGRectMake(x+100, y, [UIScreen mainScreen].bounds.size.width,30);
	y+=dy;
	
	
	int length = [UIScreen mainScreen].bounds.size.width-20;
	self.imageView.frame = CGRectMake(x, y, length,length);
    self.imageView.contentMode = UIViewContentModeScaleToFill;
	y+=length+10;
	
	
	UILabel *menuName = [[UILabel alloc] initWithFrame:CGRectMake(x, y, [UIScreen mainScreen].bounds.size.width, 30)];
	[menuName setFont:[UIFont systemFontOfSize:18]];
	//menuName.text = @"Rice";
	menuName.text =[[_jsonData objectForKey:@"menu_num"] stringValue];
	[self addSubview:menuName];
	y+=dy;


	UILabel *storeName = [[UILabel alloc] initWithFrame:CGRectMake(x, y, [UIScreen mainScreen].bounds.size.width, 30)];
	[storeName setFont:[UIFont systemFontOfSize:18]];
	//storeName.text = @"Starbucks";
	storeName.text =[[_jsonData objectForKey:@"store_num"] stringValue];
	[self addSubview:storeName];
	y+=dy;
	
	
	int maxStar =5;
	UIImageView *starImg[maxStar];
	int starSize = 30;
	int starNum =  [[_jsonData objectForKey:@"star_num"] intValue];
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
		//noting to do
	}
    return self;
}


- (void)updateJsonData:(NSURL*)imageUrl jsonData:(NSDictionary*)jsonData image:(UIImage*)image{
	_imageUrl = imageUrl;
	_jsonData = jsonData;
	self.imageView.image = image;
	
}

- (void)loadImage:(NSCache*)imageCache imageCacheKey:(NSString*)imageCacheKey
{
	NSLog(@"Load FoodLine image");
	//set indicator
	UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
	indicator.color = [UIColor colorWithRed:0.4 green:0.0 blue:0.1 alpha:1.0];
	[indicator setCenter:CGPointMake(self.frame.size.width/2.0f, 180.0f)];
	[self addSubview: indicator];
	[indicator startAnimating];
	
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	
	
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
