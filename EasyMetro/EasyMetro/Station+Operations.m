//
//  Station+Operations.m
//  EasyMetro
//
//  Created by Prem kumar on 18/09/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import "Station+Operations.h"

@implementation Station (Operations)

+ (Station *)stationWithDetails:(NSDictionary *)iDetailsDictionary
        inManagedObjectContext:(NSManagedObjectContext *)context{
    Station *aStation = nil;
    
    aStation = [NSEntityDescription insertNewObjectForEntityForName:@"Station" inManagedObjectContext:context];
    aStation.stationName = iDetailsDictionary[@"stationName"];
    aStation.stationLineNo = iDetailsDictionary[@"stationLineNo"];
    aStation.laneId = iDetailsDictionary[@"sourceLaneId"];
    aStation.linkingLaneId = iDetailsDictionary[@"linkingLaneId"];
    return aStation;
}

@end
