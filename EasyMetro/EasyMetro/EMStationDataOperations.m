//
//  EMStationDataOperations.m
//  EasyMetro
//
//  Created by Prem kumar on 20/09/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import "EMStationDataOperations.h"
#import "EMAppDelegate+CoreData.h"

@implementation EMStationDataOperations

- (NSArray *)fetchStationsForJunction:(Junction *)iJunction {
    
    Station *junctionForSourceLane  = [self fetchStationForStationName:iJunction.cityName andSourceLaneId:iJunction.lane1];
    Station *junctionForDestLane    = [self fetchStationForStationName:iJunction.cityName andSourceLaneId:iJunction.lane2];
    if (junctionForDestLane != nil && junctionForSourceLane != nil) {
        return @[junctionForSourceLane,junctionForDestLane];
    }
    else
        return nil;
}

- (Station *)fetchStationForStationName:(NSString *)stationName andSourceLaneId:(NSNumber *)iSourceLaneId{
    EMAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Station" inManagedObjectContext:appDelegate.globalDatabaseContext];
    
    NSPredicate *predicate = nil;
    if (iSourceLaneId == nil) {
        predicate = [NSPredicate predicateWithFormat:@"(stationName == %@)",stationName];
    }
    else {
        predicate = [NSPredicate predicateWithFormat:@"(stationName == %@ && laneId == %@)",stationName,iSourceLaneId];
    }
    
    [request setEntity:entity];
    [request setPredicate:predicate];
    [request setReturnsObjectsAsFaults:NO];
    NSError *error;
    NSArray *results = [appDelegate.globalDatabaseContext executeFetchRequest:request error:&error];
    
    Station *aStation = nil;
    if (results != nil && results.count == 1) {
        
        if ([[results firstObject]isKindOfClass:[Station class]]) {
            aStation = (Station *)[results firstObject];
        }
    }
    return aStation;
}

- (Station *)fetchStationForLinkedSourceId:(NSNumber *)iLinkedLaneId andLaneId:(NSNumber *)iLaneId{
    EMAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Station" inManagedObjectContext:appDelegate.globalDatabaseContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(linkingLaneId == %@ && laneId == %@)",iLinkedLaneId,iLaneId];
    
    [request setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"stationLineNo" ascending:YES]]];
    [request setEntity:entity];
    [request setPredicate:predicate];
    NSError *error;
    NSArray *results = [appDelegate.globalDatabaseContext executeFetchRequest:request error:&error];
    
    Station *aStation = nil;
    if (results != nil && results.count == 1) {
        
        if ([[results firstObject]isKindOfClass:[Station class]]) {
            aStation = (Station *)[results firstObject];
        }
    }
    return aStation;
}

- (NSArray *)fetchAllStationsWithSourceLaneId:(NSNumber *)iSourceLaneId andMinLaneNo:(NSNumber *)iLowerRange andMaxLaneNo:(NSNumber *)iUpperRange{
    
    EMAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Station" inManagedObjectContext:appDelegate.globalDatabaseContext];
    
    NSPredicate *predicate = nil;
    
    if ([iLowerRange intValue] > [iUpperRange intValue]) {
        predicate = [NSPredicate predicateWithFormat:@"(laneId == %@ && ((stationLineNo >= %@) && (stationLineNo <= %@)))", iSourceLaneId,iUpperRange,iLowerRange];
        [request setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"stationLineNo" ascending:NO]]];
    }
    else{
        predicate = [NSPredicate predicateWithFormat:@"(laneId == %@ && ((stationLineNo >= %@) && (stationLineNo <= %@)))", iSourceLaneId,iLowerRange,iUpperRange];
        [request setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"stationLineNo" ascending:YES]]];
    }
    
    [request setEntity:entity];
    [request setPredicate:predicate];
    NSError *error;
    NSArray *results = [appDelegate.globalDatabaseContext executeFetchRequest:request error:&error];
    
    return results;
}

- (NSArray *)fetchStationsWithJunctionForSourceLaneId:(NSNumber *)iSourceLaneId{
    
    EMAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Station" inManagedObjectContext:appDelegate.globalDatabaseContext];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(laneId == %@ && linkingLaneId != 0)",iSourceLaneId];
    [request setEntity:entity];
    
    [request setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"stationLineNo" ascending:YES]]];
    [request setPredicate:predicate];
    NSError *error;
    NSArray *results = [appDelegate.globalDatabaseContext executeFetchRequest:request error:&error];
    
    return results;
}

- (NSArray *)fetchStationsWithLaneId:(NSNumber *)iLaneId {
    
    EMAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Station" inManagedObjectContext:appDelegate.globalDatabaseContext];
    
    [request setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"stationLineNo" ascending:YES]]];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(laneId == %@)",iLaneId];
    [request setPredicate:predicate];
    [request setEntity:entity];
    NSError *error;
    NSArray *results = [appDelegate.globalDatabaseContext executeFetchRequest:request error:&error];
    return results;
}

@end
