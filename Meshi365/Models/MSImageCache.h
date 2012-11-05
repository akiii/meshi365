//
//  MSImageCache.h
//  Meshi365
//
//  Created by Mlle.Irene on 2012/11/04.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSImageCache : NSObject
@property(nonatomic,strong)	NSCache *foodIimage;
@property(nonatomic,strong)	NSCache *foodImageRequest;
@property(nonatomic,strong)	NSCache *profileImage;
@property(nonatomic,strong)	NSCache *profileImageRequest;


+ (MSImageCache*)imageCache;
@end
