//
//  EMAppDelegate+CoreData.h
//  EasyMetro
//
//  Created by Prem kumar on 18/09/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import "EMAppDelegate.h"

@interface EMAppDelegate (CoreData)

/**
 Method to create core data managed object context.
 @return NSManagedObjectContext to be accessed for core data operations.
 */
- (NSManagedObjectContext *)createMainQueueManagedObjectContext;

/**
 Method to call explicit save on core data .
 @param managedObjectContext to call save upon.
 */
- (void)saveContext:(NSManagedObjectContext *)managedObjectContext;

@end
