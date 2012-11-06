//
//  MSRecommendTableView.m
//  Meshi365
//
//  Created by Mlle.Irene on 2012/10/30.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSRecommendTableView.h"
#import "MSRecommendCell.h"
#import "MSAWSConnector.h"
#import "MSImageLoader.h"
#import "MSFoodPicture.h"
#import "MSImageCache.h"


@interface MSRecommendTableView()
@property(nonatomic,strong) UILabel *label;
@end

@implementation MSRecommendTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		self.delegate = self;
		self.dataSource = self;
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
    return _jsonArray.count;
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
	MSFoodPicture *foodPicture = nil;
	
	if(_jsonArray && _jsonArray.count > indexPath.row)foodPicture= [[MSFoodPicture alloc]initWithJson: _jsonArray[indexPath.row] ];
	
	
	MSRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[MSRecommendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		
		int size = [UIScreen mainScreen].bounds.size.width/3;
		cell.imageView.frame = CGRectMake(0, 0, size, size);
		cell.foodPicture = foodPicture;
		
	}
	
	
	MSImageCache* cache = [MSImageCache sharedManager];
	[cell.foodImgIdctr startAnimating];
	if(!foodPicture)
		cell.imageView.image =  [UIImage imageNamed:@"starNonSelect.png"];
	else if( [cache.image objectForKey:foodPicture.url])
	{
		cell.imageView.image =  [cache.image  objectForKey:foodPicture.url];
		[cell.foodImgIdctr stopAnimating];
	}
	else
		cell.imageView.image =  [UIImage imageNamed:@"star.png"];
	
	return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	MSRecommendCell *cell = (MSRecommendCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.height;
	
}


-(void)loadImage
{
	
	NSLog(@"Start Load Food Image");
	for( int i = 0; i < _jsonArray.count;i++)
	{
		MSFoodPicture* foodPicture = [[MSFoodPicture alloc] initWithJson:_jsonArray[i]];
		
		[[MSImageLoader sharedManager] ImageLoad:foodPicture.url view:self];
	}
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath != nil) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}

@end
