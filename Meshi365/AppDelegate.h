//
//  AppDelegate.h
//  Meshi365
//
//  Created by Akifumi on 2012/10/28.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSRootTabBarController.h"
#import "MSSignUpViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) MSRootTabBarController *rootTabBarController;
@property (nonatomic, strong) MSSignUpViewController *signUpViewController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
@end
