//
//  MSCameraViewController.m
//  Meshi365
//
//  Created by Mlle.Irene on 2012/10/29.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSCameraViewController.h"

@interface MSCameraViewController ()
@end

@implementation MSCameraViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.delegate = self;
        // Custom initialization
    }
    return self;
}

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingImage:(UIImage*)image editingInfo:(NSDictionary*)editingInfo{
    
    self.camera_image = image;
    
    MSValueImageViewController *msValueImageViewController = [[MSValueImageViewController alloc] init];
    msValueImageViewController.taken_image = image;
    [self presentModalViewController:msValueImageViewController animated:YES];
    
    //[self dismissModalViewControllerAnimated:YES];
}

//画像の保存完了時に呼ばれるメソッド
-(void)targetImage:(UIImage*)image
didFinishSavingWithError:(NSError*)error contextInfo:(void*)context{
    
    NSLog(@"test");
    
    if(error){
    }else{
    }
}



//画像の選択がキャンセルされた時に呼ばれる
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissModalViewControllerAnimated:YES];
    NSLog(@"test");
}

@end
