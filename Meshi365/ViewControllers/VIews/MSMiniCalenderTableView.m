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


@interface MSMiniCalenderTableView()
@property(nonatomic,strong)	NSCache *imageCache;
@property(nonatomic,strong) UILabel *label;
@end

@implementation MSMiniCalenderTableView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
    return MAX(_jsonArray.count, 3);
}


-(void)loadImage
{
	_imageCache = [[NSCache alloc] init];
	
	for( int i = 0; i < _jsonArray.count;i++)
	{
		MSFoodPicture *foodPicture = [[MSFoodPicture alloc]initWithJson: _jsonArray[i] ];
		
		if([_imageCache objectForKey:foodPicture.url])continue;
		
		dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
		dispatch_async(q_global, ^{
			NSLog(@"...... load start:%d", i);
			
			
			NSURL *foodImageAccessKeyUrl = [MSAWSConnector getS3UrlFromString:foodPicture.url];
			NSData* data = [NSData dataWithContentsOfURL:foodImageAccessKeyUrl];
			UIImage* image = [[UIImage alloc] initWithData:data];
			
			if(![_imageCache objectForKey:foodPicture.url])
			{
				[_imageCache setObject:image forKey:foodPicture.url];
				[self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
				NSLog(@"...... load done:%d", i);
			}
		});
	}
	
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
	
	
	MSFoodPicture *foodPicture = nil;

	if(_jsonArray && _jsonArray.count > indexPath.row)foodPicture= [[MSFoodPicture alloc]initWithJson: _jsonArray[indexPath.row] ];
	
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		
		
		
		int size = [UIScreen mainScreen].bounds.size.width/3 - 20;
		cell.imageView.frame = CGRectMake(3, 10, size, size);
		
		
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
	
	
	if(!foodPicture)
		cell.imageView.image =  [UIImage imageNamed:@"starNonSelect.png"];
	else if( [_imageCache objectForKey:foodPicture.url])
		cell.imageView.image =  [_imageCache objectForKey:foodPicture.url];
	else
		cell.imageView.image =  [UIImage imageNamed:@"star.png"];


    
	return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	//todo セルのサイズに合わせてか可変を
	return 120;
	
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath != nil) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}



@end
