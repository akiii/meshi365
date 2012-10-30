//
//  MSFoodPictureImage.m
//  Meshi365
//
//  Created by Akifumi on 2012/10/31.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSFoodPictureImage.h"

@implementation MSFoodPictureImage

- (id)init{
    if (self = [super init]) {
        self.foodPicture = [[MSFoodPicture alloc] init];
    }
    return self;
}

- (void)dealloc{
    self.foodPicture = nil;
}

@end
