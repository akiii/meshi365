//
//  MSFoodPictureImage.m
//  Meshi365
//
//  Created by Akifumi on 2012/10/31.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSFoodPictureImage.h"

@implementation MSFoodPictureImage

- (id)initWithCGImage:(CGImageRef)cgImage{
    if (self = [super initWithCGImage:cgImage]) {
        self.foodPicture = [[MSFoodPicture alloc] init];
    }
    return self;
}

- (void)dealloc{
    self.foodPicture = nil;
}

@end
