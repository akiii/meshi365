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
	
    MSRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell =[[MSRecommendCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];

		
		int size = [UIScreen mainScreen].bounds.size.width/2;
		UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(3, 3, size, 30)];
		label.text = @"Breakfast";
		[cell addSubview:label];
	}
	
	
	//[cell updateJsonData:[MSAWSConnector foodPictureImageUrlFromJsonArray:_jsonArray imageNum:indexPath.row] jsonData:_jsonArray[indexPath.row]];
	
	
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	//todo セルのサイズに合わせてか可変を
	return 400;
	
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath != nil) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}

@end
