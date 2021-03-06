//
//  MSFoodPicture.h
//  Meshi365
//
//  Created by Akifumi on 2012/10/30.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSUser.h"

@interface MSFoodPicture : NSObject
@property (nonatomic, strong) NSString *uiid;
@property (assign) int mealType;
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, strong) NSString *menuName;
@property (assign) int amenity;
@property (nonatomic, strong) NSString *comment;
@property (assign) int starNum;
@property (readonly) NSString *url;
@property (nonatomic, strong) NSString *createdAt;
@property (readonly) NSString *params;
@property(nonatomic,strong) MSUser* user;
- (id)initWithJson:(NSDictionary*)json;

@end
