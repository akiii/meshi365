//
//  MSFoodLineViewController.m
//  Meshi365
//
//  Created by Mlle.Irene on 2012/10/28.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSFoodLineViewController.h"

#import "MSFoodLineCell.h"

@interface MSFoodLineViewController ()

@end

@implementation MSFoodLineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:style];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
	
	
	[super viewWillAppear:animated];
	
    // detail から master に戻ってきた場合に、選択された行のハイライトを消す。
    NSIndexPath *indexPath = tableView.indexPathForSelectedRow;
    if (indexPath != nil) {
        [tableView deselectRowAtIndexPath:indexPath animated:animated];
    }

	
}





- (id)initWithStyle:(UITableViewStyle)theStyle
{
    self = [super init];    // xib ファイルは使わないと仮定。
    if (self != nil) {
        style = theStyle;
    }
    return self;
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}



- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[MSFoodLineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
	
	
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	
	return 200;
	
	//sample
//	NSString* text = @"表示するテキスト";
//	UIFont* font = [UIFont systemFontOfSize:12];
//	
//	
//	
//	// label は表示する UILabel
//	CGSize size = CGSizeMake(label.size.width, 1000);
//	CGSize textSize = [text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeCharacterWrap];
//	
//	float height = 50.0f; // セルの最低限の高さ
//	
//	// 元の UILabel よりも高さが高ければ高さを補正する
//	float h = textSize.height - label.size.height;
//	if (h > 0) {
//		height += h;
//	}
//	return height;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}





@end
