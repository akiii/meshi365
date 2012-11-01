//
//  MSFoodPicture.h
//  Meshi365
//
//  Created by Akifumi on 2012/10/30.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSFoodPicture : NSObject
@property (nonatomic, strong) NSString *uiid;
@property (assign) int mealType;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, strong) NSString *menuName;
@property (nonatomic, strong) NSString *comment;
@property (assign) int starNum;
@property (readonly) NSString *params;
@end
