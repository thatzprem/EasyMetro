//
//  EMStationDataOperations.h
//  EasyMetro
//
//  Created by Prem kumar on 20/09/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Station+Operations.h"
#import "Junction+Operations.h"

@interface EMStationDataOperations : NSObject

/**
 Fetch all the Stations for the Junction.
 @param iJunction of the source station.
 @return NSArray is available junctions.
 */
- (NSArray *)fetchStationsForJunction:(Junction *)iJunction;

/**
 Fetch the Stations for the station name and the sourceLaneId.
 @param stationName for the request.
 @param iSourceLaneId for the request.
 @return Station for the request.
 */
- (Station *)fetchStationForStationName:(NSString *)stationName andSourceLaneId:(NSNumber *)iSourceLaneId;

/**
 Fetch the Stations for the linkedSourceId and the laneId.
 @param iLinkedLaneId for the request.
 @param iLaneId for the request.
 @return Station for the request.
 */
- (Station *)fetchStationForLinkedSourceId:(NSNumber *)iLinkedLaneId andLaneId:(NSNumber *)iLaneId;

/**
 Fetch all the Stations for the Junction.
 @param iSourceLaneId for the request.
 @param iLowerRange for the request.
 @param iUpperRange for the request.
 @return NSArray for results.
 */
- (NSArray *)fetchAllStationsWithSourceLaneId:(NSNumber *)iSourceLaneId andMinLaneNo:(NSNumber *)iLowerRange andMaxLaneNo:(NSNumber *)iUpperRange;

/**
 Fetch all the Stations for the Junction with SourceLaneId.
 @param iSourceLaneId for the request.
 @return NSArray for results.
 */
- (NSArray *)fetchStationsWithJunctionForSourceLaneId:(NSNumber *)iSourceLaneId;

/**
 Fetch all the Stations with iLaneId.
 @param iLaneId for the request.
 @return NSArray for results.
 */
- (NSArray *)fetchStationsWithLaneId:(NSNumber *)iLaneId;

@end
