//
//  MSMiniCalenderTableView.m
//  Meshi365
//
//  Created by Mlle.Irene on 2012/10/29.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSMiniCalenderTableView.h"
#import "MSFoodLineCell.h"
#import "MSAWSConnector.h"
#import "MSImageLoader.h"
#import "MSImageCache.h"
#import "MSMiniCalenderCell.h"

@interface MSMiniCalenderTableView()
@property(nonatomic,strong) UILabel *label;
@property(nonatomic,strong) NSMutableDictionary *indctrDict;
@end

@implementation MSMiniCalenderTableView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		self.delegate = self;
		self.dataSource = self;
		_indctrDict = [NSMutableDictionary dictionary];
		self.backgroundColor = DEFAULT_BGCOLOR;
		
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return MAX(_jsonArray.count, 3);
}


-(void)loadImage
{
	
	
	for( int i = 0; i < _jsonArray.count;i++)
	{
		MSFoodPicture* foodPicture = [[MSFoodPicture alloc] initWithJson:_jsonArray[i]];
		[[MSImageLoader sharedManager] ImageLoad:foodPicture.url view:self];
	}
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
	
	int size = [UIScreen mainScreen].bounds.size.width/3-10;
	
	MSFoodPicture *foodPicture = nil;
	
	if(_jsonArray && _jsonArray.count > indexPath.row)foodPicture= [[MSFoodPicture alloc]initWithJson: _jsonArray[indexPath.row] ];
	
	
    MSMiniCalenderCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[MSMiniCalenderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
	
	cell.foodPicture = foodPicture;
	
	if(foodPicture.url != nil && ![_indctrDict objectForKey:foodPicture.url])
	{
		
		[_indctrDict setObject:[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] forKey:foodPicture.url];
		
		UIActivityIndicatorView* indctr =[_indctrDict objectForKey:foodPicture.url];
		indctr.color= DEFAULT_INDICATOR_COLOR;
		[indctr setCenter:CGPointMake(size/2,size/2 )];
		[indctr setTransform:FOOD_LINE_PROFILE_INDICATOR_TRANSFORM];
		[cell.imageView addSubview:indctr];
		
	}
	
	
	//if([_indctrDict objectForKey:foodPicture.url])[[_indctrDict objectForKey:foodPicture.url] startAnimating];
	
	[cell.foodImgIdctr startAnimating];
	
	MSImageCache* cache = [MSImageCache sharedManager];
	if(!foodPicture)
	{
		cell.foodImage =  [UIImage imageNamed:IMG_NO_IMAGE_LARGE];
		//[[_indctrDict objectForKey:foodPicture.url] stopAnimating];
		[cell.foodImgIdctr stopAnimating];
		
		
	}
	else if( [cache.image objectForKey:foodPicture.url])
	{
		cell.foodImage =  [cache.image objectForKey:foodPicture.url];
		//	if([_indctrDict objectForKey:foodPicture.url])[[_indctrDict objectForKey:foodPicture.url] stopAnimating];
		[cell.foodImgIdctr stopAnimating];
	}
	else
		cell.foodImage =  [UIImage imageNamed:IMG_NOW_LOADING_LARGE];
	
	
    [cell layoutSubviews];
	return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	//todo セルのサイズに合わせてか可変を
	return self.frame.size.height/3.0f-5;//110;
	
}



//- (void)view:(UIView*)view touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
//	NSLog(@"delegate touchesBegan");
//	[_popUpView setHidden:YES];
//}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath != nil) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
		
		MSFoodPicture *foodPicture= [[MSFoodPicture alloc]initWithJson: _jsonArray[indexPath.row] ];
		MSImageCache* cache = [MSImageCache sharedManager];
		
		
		_popUpView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 130)];
		_popUpView.backgroundColor = COLOR_POPUP;
		
		
		
		int maxStar =5;
		NSMutableArray *starArray = [NSMutableArray array];
		for(int i = 0; i < maxStar; i++)
		{
			UIImageView *star = [[UIImageView alloc]init];
			star.contentMode= UIViewContentModeScaleAspectFit;
			[self addSubview:star];
			[starArray addObject: star];
		}
		
		
		
		
		
		
		UIImageView* foodImageView	= [[UIImageView alloc]init];
		UIImageView* profileImageView	= [[UIImageView alloc]init];
		UILabel* storeName			= [[UILabel alloc] init];
		UILabel* menuName			= [[UILabel alloc] init];
		UILabel* comment			= [[UILabel alloc] init];
		UILabel* mealType			= [[UILabel alloc] init];
		UILabel* dateText			= [[UILabel alloc] init];
		
		storeName.textColor = [UIColor whiteColor];
		menuName.textColor = [UIColor whiteColor];
		comment.textColor = [UIColor whiteColor];
		mealType.textColor = [UIColor whiteColor];
		dateText.textColor = [UIColor whiteColor];
		
		
		
		int fontSize =  20;
		int x = 15;
		int y = 0;
		int dy=21;
		int length = 40;
		
		
		switch (foodPicture.mealType) {
			case 0:mealType.text = @"Breakfast";break;
			case 1:mealType.text = @"Lunch";break;
			case 2:mealType.text = @"Dinner";break;
			default:mealType.text = @"Dessert";break;break;
		}
		//self.textLabel.text = [NSString stringWithFormat:@"%d" ,self.indexPathRow ];
		mealType.backgroundColor =  [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
		mealType.frame =  CGRectMake(x, y, [UIScreen mainScreen].bounds.size.width,30);
		
		
		dateText.text = [NSString stringWithFormat:@"Date:%@",foodPicture.createdAt];
		dateText.textAlignment =  NSTextAlignmentLeft;
		dateText.backgroundColor =  [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
		dateText.frame =  CGRectMake(x+90, y, [UIScreen mainScreen].bounds.size.width,30);
		y+=dy+10;
		
		
		
		length = [UIScreen mainScreen].bounds.size.width-100;
		int imagePosX = ([UIScreen mainScreen].bounds.size.width  - length )/2;
		foodImageView.image = [cache.image objectForKey:foodPicture.url];
		foodImageView.frame = CGRectMake(imagePosX, y, length,length);
		y+=length+10;
		
		
		
		int starSize = 30;
		int starNum = foodPicture.starNum;
		int starPosX =  ([UIScreen mainScreen].bounds.size.width- starSize*maxStar)/2;
		for(int i = 0; i < maxStar; i++)
		{
			UIImageView *star = [starArray objectAtIndex:i];
			star.frame = CGRectMake(starPosX+i*starSize, y, starSize, starSize);
			if(i < starNum)star.image = [UIImage imageNamed:@"star.png"];
			else star.image = [UIImage imageNamed:@"starNonSelect.png"];
			[_popUpView addSubview:star];
		}
		y+=starSize+5;
		
		
		[storeName setHidden:YES];
		[menuName setHidden:YES];
		[comment setHidden:YES];
		
		fontSize = 18;
		if(foodPicture.storeName != nil)
		{
			[storeName setHidden:NO];
			storeName.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
			storeName.frame = CGRectMake(x, y, [UIScreen mainScreen].bounds.size.width, fontSize);
			[storeName setFont:[UIFont systemFontOfSize:fontSize]];
			storeName.text = [NSString stringWithFormat:@"Place:%@",foodPicture.storeName ];
			y+=dy;
		}
		
		
		if(foodPicture.menuName != nil)
		{
			[menuName setHidden:NO];
			menuName.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
			menuName.frame = CGRectMake(x, y, [UIScreen mainScreen].bounds.size.width, fontSize);
			[menuName setFont:[UIFont systemFontOfSize:fontSize]];
			menuName.text = [NSString stringWithFormat:@"Menu:%@",foodPicture.menuName ];
			y+=dy;
			
		}
		
		if(foodPicture.comment != nil)
		{
			[comment setHidden:NO];
			comment.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
			comment.frame = CGRectMake(x, y, [UIScreen mainScreen].bounds.size.width, 30);
			[comment setFont:[UIFont systemFontOfSize:18]];
			comment.text = [NSString stringWithFormat:@"Comment:%@",foodPicture.comment ];
			y+=dy;
			
		}
		
		
		
		
		
		
		
		[_popUpView addSubview:foodImageView];
		
		[_popUpView addSubview:profileImageView];
		[_popUpView addSubview:comment];
		[_popUpView addSubview:menuName];
		[_popUpView addSubview:storeName];
		[_popUpView addSubview:mealType];
		[_popUpView addSubview:dateText];
		
		
		
		
		[self.baseView.view addSubview:_popUpView];
		
		
		
    }
}



@end
