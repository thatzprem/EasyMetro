//
//  EMLaneOperations.m
//  EasyMetro
//
//  Created by Prem kumar on 20/09/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import "EMLaneOperations.h"
#import "EMAppDelegate+CoreData.h"


@implementation EMLaneOperations

- (NSArray *)fetchAllLanes {
    
    EMAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Lane" inManagedObjectContext:appDelegate.globalDatabaseContext];
    
    [request setEntity:entity];
    [request setReturnsObjectsAsFaults:NO];
    [request setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"laneKey" ascending:YES]]];
    NSError *error;
    NSArray *results = [appDelegate.globalDatabaseContext executeFetchRequest:request error:&error];
    return results;
}

- (NSString *)fetchLaneForLaneKey:(NSNumber *)laneKey {
    
    EMAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Lane" inManagedObjectContext:appDelegate.globalDatabaseContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(laneKey == %@)",laneKey];

    [request setEntity:entity];
    [request setPredicate:predicate];
    [request setReturnsObjectsAsFaults:NO];
    [request setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"laneKey" ascending:YES]]];
    NSError *error;
    NSArray *results = [appDelegate.globalDatabaseContext executeFetchRequest:request error:&error];
    Lane *aLane = nil;
    if ([results count] == 1) {
        aLane = [results firstObject];
    }
    
    if (aLane == nil) {
        if ([laneKey isEqualToNumber:@1]) {
            return @"Green";
        }
        else if ([laneKey isEqualToNumber:@2]){
            return @"Blue";
        }
        else if ([laneKey isEqualToNumber:@2]){
            return @"Red";
        }
        else if ([laneKey isEqualToNumber:@2]){
            return @"Yellow";
        }
        else if ([laneKey isEqualToNumber:@2]){
            return @"Black";
        }

    }
    return aLane.laneValue;
}

@end
