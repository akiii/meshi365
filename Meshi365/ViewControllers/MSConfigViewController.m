//
//  MSConfigViewController.m
//  Meshi365
//
//  Created by Mlle.Irene on 2012/10/29.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSConfigViewController.h"

@interface MSConfigViewController ()
@property(nonatomic,strong) UITextField *textField;
@end

@implementation MSConfigViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.view.backgroundColor = [UIColor colorWithRed:1.0 green:0.93 blue:0.8 alpha:1.0];
		UIScrollView* scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)];
		scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 800);
		scrollView.showsHorizontalScrollIndicator = NO;
		scrollView.showsVerticalScrollIndicator = YES;
		[self.view addSubview:scrollView];

		
		int x = 10;
		int y = 50;
		int dy = 30;
		UILabel *inputUserName = [[UILabel alloc]initWithFrame:CGRectMake(x, y, 100, 30)];
		inputUserName.text = @"User Name";
		inputUserName.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
		[scrollView addSubview:inputUserName];
		y+=dy;
		
		
		_textField = [[UITextField alloc] initWithFrame:CGRectMake(x, y, 200, 30)];
		_textField.placeholder = @"input your nickname";
		_textField.clearButtonMode = UITextFieldViewModeAlways;
		_textField.borderStyle = UITextBorderStyleRoundedRect;
		[_textField addTarget:self action:@selector(nicknameInputDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
		[scrollView addSubview:_textField];
		
		
		UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[submitButton setTitle:@"Submit" forState:UIControlStateNormal];
		submitButton.frame = CGRectMake(x+210, y, 80, 30);
		[submitButton addTarget:self action:@selector(submitNickname:) forControlEvents:UIControlEventTouchDown];
		[scrollView addSubview:submitButton];
		y+=dy;
		
		
		
		
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)submitNickname:(UITextField*)textfield{
	NSLog(@"submit!!!!!!!");
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField{
	[_textField resignFirstResponder];
	return YES;
}

@end
