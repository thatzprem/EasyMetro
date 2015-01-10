//
//  EMJunctionDataOperations.m
//  EasyMetro
//
//  Created by Prem kumar on 20/09/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import "EMJunctionDataOperations.h"
#import "EMAppDelegate+CoreData.h"

@implementation EMJunctionDataOperations

- (Junction *)fetchJunctionConnectingSourceLaneId:(NSNumber *)sourceLaneId andDestinationLaneId:(NSNumber *)destinationLaneId {
    
    EMAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Junction" inManagedObjectContext:appDelegate.globalDatabaseContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"((lane1 == %@ && lane2 == %@) || (lane2 == %@ && lane1 == %@))",sourceLaneId,destinationLaneId,sourceLaneId,destinationLaneId];
    [request setEntity:entity];
    [request setPredicate:predicate];
    [request setReturnsObjectsAsFaults:NO];
    NSError *error;
    NSArray *results = [appDelegate.globalDatabaseContext executeFetchRequest:request error:&error];
    
    Junction *aJunction = nil;
    if (results != nil && results.count == 1) {
        
        if ([[results firstObject]isKindOfClass:[Junction class]]) {
            aJunction = (Junction *)[results firstObject];
        }
    }
    return aJunction;
}

- (NSArray *)fetchAllJunctionsConnectingSourceLaneId:(NSNumber *)sourceLaneId andDestinationLaneId:(NSNumber *)destinationLaneId {
    
    EMAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Junction" inManagedObjectContext:appDelegate.globalDatabaseContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"((lane1 == %@ || lane2 == %@) || (lane1 == %@ || lane2 == %@))",sourceLaneId,destinationLaneId,destinationLaneId,sourceLaneId];
    [request setEntity:entity];
    [request setPredicate:predicate];
    NSError *error;
    NSArray *results = [appDelegate.globalDatabaseContext executeFetchRequest:request error:&error];
    
    NSArray *junctions = nil;
    NSLog(@"Results count :%lu",(unsigned long)[results count]);
    if (results != nil) {
        junctions = results;
    }
    return junctions;
}

@end
