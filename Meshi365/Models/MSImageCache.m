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
			foodIimage = [imageCache alloc] in
			
			
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

- (id)retain {
    return self;  // シングルトン状態を保持するため何もせず self を返す
}

- (unsigned)retainCount {
    return UINT_MAX;  // 解放できないインスタンスを表すため unsigned int 値の最大値 UINT_MAX を返す
}

- (void)release {
    // シングルトン状態を保持するため何もしない
}

- (id)autorelease {
    return self;  // シングルトン状態を保持するため何もせず self を返す
}

@end
