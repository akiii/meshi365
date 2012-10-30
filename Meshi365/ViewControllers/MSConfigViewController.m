//
//  MSConfigViewController.m
//  Meshi365
//
//  Created by Mlle.Irene on 2012/10/29.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSConfigViewController.h"
#import "MSUIIDController.h"

//#import "CommonCrypto/CommonDigest.h"
//#import <AWSiOSSDK/S3/AmazonS3Client.h>
//
//#define AWS_BUCKET_NAME     @"meshi365-images"
//
//#define AWS_ACCESS_KEY_ID   @"AKIAIGLYHE4PH36VP7HQ"
//#define AWS_SECRET_KEY      @"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"

@interface MSConfigViewController ()

@end

@implementation MSConfigViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        // Custom initialization
//        NSString *uiid = [[[MSUIIDController alloc] init] uiid];
//        NSString *fn = [NSString stringWithFormat:@"%@-%@", uiid, [NSDate date]];
//        NSString *fileName = [self MD5:fn];
//        
//        AmazonS3Client *s3 = [[AmazonS3Client alloc] initWithAccessKey:AWS_ACCESS_KEY_ID withSecretKey:AWS_SECRET_KEY];
//        [s3 createBucket:[[S3CreateBucketRequest alloc] initWithName:AWS_BUCKET_NAME]];
//        S3PutObjectRequest *por = [[S3PutObjectRequest alloc] initWithKey:fileName inBucket:AWS_BUCKET_NAME];
//        por.contentType = @"image/jpeg";
//        
//        UIImage *image = [UIImage imageNamed:@"sampleMenu.png"];
//        NSData *imageData = [[NSData alloc] initWithData:UIImagePNGRepresentation(image)];
//        por.data = imageData;
//        [s3 putObject:por];
    }
    return self;
}

//- (NSString *)MD5:(NSString*)str{
//    const char *cStr = [str UTF8String];
//    unsigned char digest[CC_MD5_DIGEST_LENGTH];
//    CC_MD5( cStr, strlen(cStr), digest );
//    char md5string[CC_MD5_DIGEST_LENGTH*2];
//    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
//        sprintf(md5string+i*2, "%02x", digest[i]);
//    }
//    NSString* md5 = [NSString stringWithCString:md5string encoding:NSUTF8StringEncoding];
//    return md5;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
