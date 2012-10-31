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
@property(nonatomic, strong) NSDictionary* jsonData;


@end

@implementation MSRecommendCell


- (void) layoutSubviews {
    [super layoutSubviews];
	self.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
	
	
	int x = 10;
	int y = 10;
	int dy=30;
	
	self.textLabel.text = @"Break Fast";
	self.textLabel.frame =  CGRectMake(x, y, [UIScreen mainScreen].bounds.size.width,30);
	
	
	self.detailTextLabel.text = [NSString stringWithFormat:@"%@",[_jsonData objectForKey:@"created_at"]];
	self.detailTextLabel.textAlignment =  NSTextAlignmentLeft;
	self.detailTextLabel.frame =  CGRectMake(x+100, y, [UIScreen mainScreen].bounds.size.width,30);
	y+=dy;
	
	
	int length = [UIScreen mainScreen].bounds.size.width/2-10;
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
		[self loadImage];
    }
	
    return self;
}


- (void)updateJsonData:(NSURL*)imageUrl jsonData:(NSDictionary*)jsonData
{
	_imageUrl = imageUrl;
	_jsonData = jsonData;
	NSLog(@"imageUrl:%@",_imageUrl);
	[self loadImage];
}


- (void)loadImage
{
	//set indicator
	UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
	indicator.color = [UIColor colorWithRed:0.4 green:0.0 blue:0.1 alpha:1.0];
	[indicator setCenter:CGPointMake(self.frame.size.width/4.0f, 180.0f)];
	[self addSubview: indicator];
	[indicator startAnimating];
	
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	
	
	//load image
	dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main = dispatch_get_main_queue();
	
    self.imageView.image = nil;
    dispatch_async(q_global, ^{
		NSData* data = [NSData dataWithContentsOfURL:_imageUrl];
		UIImage* image = [[UIImage alloc] initWithData:data];
        
        dispatch_async(q_main, ^{
            self.imageView.image = image;
			[indicator stopAnimating];
			[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
			[self layoutSubviews];
			
        });
    });
	
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
	
    // Configure the view for the selected state
}


@end
