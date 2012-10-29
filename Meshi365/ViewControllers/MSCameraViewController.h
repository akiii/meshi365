//
//  MSCameraViewController.h
//  Meshi365
//
//  Created by Mlle.Irene on 2012/10/29.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSValueImageViewController.h"

@interface MSCameraViewController : UIImagePickerController
<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,strong) UIImage *camera_image;
@property (nonatomic,strong) NSString *state;

@end
