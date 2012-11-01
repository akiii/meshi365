//
//  MSSignUpViewController.h
//  Meshi365
//
//  Created by tatsuya on 11/1/12.
//  Copyright (c) 2012 Akifumi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSNetworkConnector.h"
#import "MSUIIDController.h"
#import "MSUser.h"
#import "MSCameraViewController.h"

@interface MSSignUpViewController : UIViewController<UITextFieldDelegate,UIActionSheetDelegate>{
    UITextField *tf;
    UIImageView *profileImageView;
    MSCameraViewController *msCamera;
    
    UIActionSheet *as;
}

@end
