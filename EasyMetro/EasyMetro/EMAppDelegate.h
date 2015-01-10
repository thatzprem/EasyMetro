//
//  EMAppDelegate.h
//  EasyMetro
//
//  Created by Prem kumar on 18/09/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/**
 Global core database context .
 */
@property (nonatomic,strong)NSManagedObjectContext *globalDatabaseContext;

@end
