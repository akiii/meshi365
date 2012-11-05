//
//  MSImageCache.m
//  Meshi365
//
//  Created by Mlle.Irene on 2012/11/04.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSImageCache.h"

@implementation MSImageCache
static MSImageCache* imageCache = nil;

+ (MSImageCache*)sharedManager {
    @synchronized(self) {
        if (imageCache == nil) {
			imageCache.foodIimage = [[NSCache alloc] init];
			imageCache.foodImageRequest = [[NSCache alloc] init];
			imageCache.profileImage = [[NSCache alloc] init];
			imageCache.profileImageRequest = [[NSCache alloc] init];
			
			//        _imageCache.countLimit = 20;
			//        _imageCache.totalCostLimit = 640 * 480 * 10;

			
			
            imageCache = [[self alloc] init];
        }
    }
    return imageCache;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (imageCache == nil) {
            imageCache = [super allocWithZone:zone];
            return imageCache;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone*)zone {
    return self;  // シングルトン状態を保持するため何もせず self を返す
}


@end
