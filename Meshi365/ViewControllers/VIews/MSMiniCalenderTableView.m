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
	
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		
		NSLog(@"fucking indexpath [%d]", indexPath.row);
		_label = [[UILabel alloc]initWithFrame:CGRectMake(3, 3, size, 30)];
		[_label setBackgroundColor: [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0]];
		if(!foodPicture)_label.text = @"Nothing";
		else
		{
			switch (foodPicture.mealType) {
				case 0:_label.text = @"Breakfast";break;
				case 1:_label.text = @"Lunch";break;
				case 2:_label.text = @"Dinner";break;
				case 3:_label.text = @"Other";break;
			}
		}
		
		
		[cell addSubview:_label];
		
		
	
		
	}
	
	
	
	if(foodPicture.url != nil && ![_indctrDict objectForKey:foodPicture.url])
	{
		
		[_indctrDict setObject:[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] forKey:foodPicture.url];
		
		UIActivityIndicatorView* indctr =[_indctrDict objectForKey:foodPicture.url];
		indctr.color= DEFAULT_INDICATOR_COLOR;
		[indctr setCenter:CGPointMake(size/2,size/2 )];
		[indctr setTransform:FOOD_LINE_PROFILE_INDICATOR_TRANSFORM];
		[cell.imageView addSubview:indctr];
		
	}
	
	
	if([_indctrDict objectForKey:foodPicture.url])[[_indctrDict objectForKey:foodPicture.url] startAnimating];
	
	
	MSImageCache* cache = [MSImageCache sharedManager];
	if(!foodPicture)
	{
		cell.imageView.image =  [UIImage imageNamed:@"starNonSelect.png"];
		[[_indctrDict objectForKey:foodPicture.url] stopAnimating];
		
	}
	else if( [cache.image objectForKey:foodPicture.url])
	{
		cell.imageView.image =  [cache.image objectForKey:foodPicture.url];
		if([_indctrDict objectForKey:foodPicture.url])[[_indctrDict objectForKey:foodPicture.url] stopAnimating];
	}
	else
		cell.imageView.image =  [UIImage imageNamed:@"star.png"];
	
	
    
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
