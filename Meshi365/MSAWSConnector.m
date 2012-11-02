//
//  MSAWSConnector.m
//  Meshi365
//
//  Created by Akifumi on 2012/10/30.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSAWSConnector.h"
#import "MSUIIDController.h"
#import "MSUser.h"
#import "MSFoodPicture.h"
#import "MSNetworkConnector.h"
#import "CommonCrypto/CommonDigest.h"
#import <AWSiOSSDK/S3/AmazonS3Client.h>

#define AWS_BASE_URL                @"https://s3.amazonaws.com"

#define AWS_BUCKET_NAME             @"meshi365-images"

#define AWS_ACCESS_KEY_ID           @"AKIAIGLYHE4PH36VP7HQ"
#define AWS_SECRET_KEY              @"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"

@implementation MSAWSConnector

+ (NSString *)uploadImageToAWS:(UIImage *)image fileName:(NSString *)fileName{
    AmazonS3Client *s3 = [[AmazonS3Client alloc] initWithAccessKey:AWS_ACCESS_KEY_ID withSecretKey:AWS_SECRET_KEY];
    [s3 createBucket:[[S3CreateBucketRequest alloc] initWithName:AWS_BUCKET_NAME]];
    S3PutObjectRequest *por = [[S3PutObjectRequest alloc] initWithKey:fileName inBucket:AWS_BUCKET_NAME];
    por.contentType = @"image/png";
    
    NSData *imageData = [[NSData alloc] initWithData:UIImagePNGRepresentation(image)];
    por.data = imageData;
    S3PutObjectResponse *res = [s3 putObject:por];
    
    if (res) {
        return [NSString stringWithFormat:@"%@/%@/%@", AWS_BASE_URL, AWS_BUCKET_NAME, fileName];
    }else {
        return nil;
    }
}

+ (NSString *)uploadProfileImageToAWS:(UIImage *)image{
    NSString *uiid = [MSUser currentUser].uiid;
    NSString *fn = uiid;
    NSString *fileName = [self md5:fn];
    
    return [self uploadImageToAWS:image fileName:fileName];
}

+ (NSString *)uploadFoodPictureToAWS:(MSFoodPictureImage *)image{
    NSString *uiid = [MSUser currentUser].uiid;
    NSString *fn = [NSString stringWithFormat:@"%@-%@", uiid, [NSDate date]];
    NSString *fileName = [self md5:fn];

    return [self uploadImageToAWS:image fileName:fileName];
}

+ (NSString *)md5:(NSString*)str{
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest );
    char md5string[CC_MD5_DIGEST_LENGTH*2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        sprintf(md5string+i*2, "%02x", digest[i]);
    }
    NSString* md5 = [NSString stringWithCString:md5string encoding:NSUTF8StringEncoding];
    return md5;
}

+ (NSURL *)getS3UrlFromString:(NSString*)url
{
	AmazonS3Client *s3 = [[AmazonS3Client alloc] initWithAccessKey:AWS_ACCESS_KEY_ID withSecretKey:AWS_SECRET_KEY];
	S3ResponseHeaderOverrides *override = [[S3ResponseHeaderOverrides alloc] init];
	override.contentType = @"image/png";

	S3GetPreSignedURLRequest *gpsur = [[S3GetPreSignedURLRequest alloc] init];
	
	
	gpsur.key     = [url lastPathComponent];
	gpsur.bucket  = AWS_BUCKET_NAME;
	gpsur.expires = [NSDate dateWithTimeIntervalSinceNow:(NSTimeInterval) 3600];

	gpsur.responseHeaderOverrides = override;
	return [s3 getPreSignedURL:gpsur];

}


@end
