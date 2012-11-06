//
//  MSConfigViewController.h
//  Meshi365
//
//  Created by Mlle.Irene on 2012/10/29.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "MSFoodPicture.h"


@interface MSConfigViewController : UIViewController
<UITextFieldDelegate>
{
	NSString *postMsg;
    
    UITextField *friendSearchTextField;
    NSDictionary *jsonDic;
}



@end
