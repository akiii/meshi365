//
//  MSImageCache.m
//  Meshi365
//
//  Created by Mlle.Irene on 2012/11/04.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSImageCache.h"

@interface MSImageCache()

@end

@implementation MSImageCache

static MSImageCache* imageCache = nil;

+ (MSImageCache*)sharedManager {
    @synchronized(self) {
        if (imageCache == nil) {
            imageCache = [[self alloc] init];
			imageCache.image = [[NSCache alloc] init];
			imageCache.imageRequest = [[NSCache alloc] init];
			
			//        _imageCache.countLimit = 20;
			//        _imageCache.totalCostLimit = 640 * 480 * 10;
			
			
			

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
