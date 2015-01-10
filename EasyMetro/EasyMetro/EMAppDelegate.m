//
//  EMAppDelegate.m
//  EasyMetro
//
//  Created by Prem kumar on 18/09/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import "EMAppDelegate.h"
#import "EMAppDelegate+CoreData.h"
#import "Station+Operations.h"
#import "Junction+Operations.h"
#import "Lane+Operatios.h"
#import "EMMainViewController.h"

@interface EMAppDelegate()

@end

@implementation EMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    self.globalDatabaseContext = [self createMainQueueManagedObjectContext];
    
    BOOL downloaded = [[NSUserDefaults standardUserDefaults] boolForKey: @"downloaded"];
    if (!downloaded) {
        //download code here
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey: @"downloaded"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self populateDatabase];
    }
    
    return YES;
}

- (void)populateDatabase {
    
    NSArray *stationDetails = [self fetchDataFromPlistWithName:@"Stations"];
    [stationDetails enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *aStation = (NSDictionary *)obj;
            [Station stationWithDetails:aStation inManagedObjectContext:self.globalDatabaseContext];
        }
    }];
    
    
    NSArray *junctionDetails = [self fetchDataFromPlistWithName:@"Junctions"];
    [junctionDetails enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *aStation = (NSDictionary *)obj;
            [Junction junctionWithDetails:aStation inManagedObjectContext:self.globalDatabaseContext];
        }
    }];
    
    NSArray *laneDetails = [self fetchDataFromPlistWithName:@"Lanes"];
    [laneDetails enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *aLane = (NSDictionary *)obj;
            [Lane laneWithDetails:aLane inManagedObjectContext:self.globalDatabaseContext];
        }
    }];
    
    [self saveContext:self.globalDatabaseContext];
}

- (NSArray *)fetchDataFromPlistWithName:(NSString *)iName {
	NSString *aPath = [[NSBundle mainBundle] pathForResource:iName ofType:@"plist"];
	return [NSDictionary dictionaryWithContentsOfFile:aPath][@"data"];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
}


@end
