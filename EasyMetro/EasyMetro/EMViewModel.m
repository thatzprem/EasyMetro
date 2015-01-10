//
//  EMViewModel.m
//  EasyMetro
//
//  Created by Prem kumar on 20/09/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import "EMViewModel.h"

@implementation EMViewModel

static EMViewModel *instance;

+ (EMViewModel *)sharedInstance {
	@synchronized(self) {
		if (instance == nil) {
			instance = [[EMViewModel alloc] init];
		}
	}
	
	return instance;
}

+ (void)resetInstance {
    instance = nil;
}

- (instancetype)init {
	if (self = [super init]) {
        self.routesList = [NSMutableArray array];
	}
	return self;
}

-(NSMutableArray *)routesList {
    
    if (!_routesList) {
        _routesList = [NSMutableArray array];
    }
    return _routesList;
}

- (EMViewModel *)fetchRoutesForCase1 {
    
    EMStationDataOperations *stationDataOperations = [[EMStationDataOperations alloc] init];
    
    Station *sourceStation = [stationDataOperations fetchStationForStationName:self.startingStation.stationName andSourceLaneId:self.startingStation.laneId];
    Station *destinationStation = [stationDataOperations fetchStationForStationName:self.destinationStation.stationName andSourceLaneId:self.destinationStation.laneId];
    
    if ([sourceStation.laneId isEqualToNumber:destinationStation.laneId]) {
        
        NSLog(@"CASE - 1: Source and destination lanes are same.");
        int abs_diff = abs([sourceStation.stationLineNo intValue] - [destinationStation.stationLineNo intValue]);
        NSLog(@"Stations between two statios: %d",abs_diff);
        NSArray *stations = [stationDataOperations fetchAllStationsWithSourceLaneId:sourceStation.laneId andMinLaneNo:sourceStation.stationLineNo andMaxLaneNo:destinationStation.stationLineNo];
        RouteDetails *aRoute = [RouteDetails new];
        aRoute.cost = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lu",(long)stations.count -1]];
        aRoute.time = [NSNumber numberWithUnsignedLong:stations.count - 1];
        
        [aRoute.routeStations addObjectsFromArray:stations];
        [self.routesList addObject:aRoute];
    }
    return self;
}

@end

@implementation RouteDetails

-(NSMutableArray *)routeStations {
    
    if (!_routeStations) {
        _routeStations = [NSMutableArray array];
    }
    return _routeStations;
}

@end
