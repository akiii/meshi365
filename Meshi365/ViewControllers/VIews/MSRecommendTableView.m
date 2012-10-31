//
//  MSRecommendTableView.m
//  Meshi365
//
//  Created by Mlle.Irene on 2012/10/30.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSRecommendTableView.h"
#import "MSRecommendCell.h"
#import "MSAWSConnector.h"s

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
    return 10;
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		//		cell = [[MSRecommendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier jsonData:jsonArray[indexPath.row]];
		
		cell =[[MSRecommendCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier imageUrl:[MSAWSConnector foodPictureImageUrlFromJsonArray:jsonArray imageNum:10] jsonData:jsonArray[indexPath.row] ];
	

	
		int size = [UIScreen mainScreen].bounds.size.width/2;
//		UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(3, 10, size, size)];
//		imageView.image = [UIImage imageNamed:@"sampleMenu.png"];
//		imageView.contentMode = UIViewContentModeScaleToFill;
//		[cell addSubview:imageView];
		
		
		
		UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(3, 3, size, 30)];
		label.text = @"Breakfast";
		
		[cell addSubview:label];
		
		
	}
	
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	//todo セルのサイズに合わせてか可変を
	return 450;
	
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath != nil) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}

@end
