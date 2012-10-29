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
        // Custom initialization
    }
    return self;
}

-(void)imagePickerController:(UIImagePickerController*)picker
       didFinishPickingImage:(UIImage*)image editingInfo:(NSDictionary*)editingInfo{
    
    //[self dismissModalViewControllerAnimated:YES];  // モーダルビューを閉じる
    
    // 渡されてきた画像をフォトアルバムに保存する
    UIImageWriteToSavedPhotosAlbum(
                                   image, self, @selector(targetImage:didFinishSavingWithError:contextInfo:),
                                   NULL);
}

//画像の保存完了時に呼ばれるメソッド
-(void)targetImage:(UIImage*)image
didFinishSavingWithError:(NSError*)error contextInfo:(void*)context{
    
    if(error){
    }else{
    }
}



//画像の選択がキャンセルされた時に呼ばれる
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    //[self dismissModalViewControllerAnimated:YES];  // モーダルビューを閉じる
}

@end
