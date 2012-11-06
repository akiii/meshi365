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
	return self.frame.size.height/3.0f;//110;
	
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath != nil) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}



@end
