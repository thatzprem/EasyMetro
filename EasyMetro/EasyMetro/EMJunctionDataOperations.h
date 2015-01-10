//
//  EMJunctionDataOperations.h
//  EasyMetro
//
//  Created by Prem kumar on 20/09/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Junction+Operations.h"

@interface EMJunctionDataOperations : NSObject

/**
 Fetch the Junction data model.
 @param sourceLaneId of the source station.
 @param destinationLaneId of the destination station.
 @return Junction selected station data model.
 */
- (Junction *)fetchJunctionConnectingSourceLaneId:(NSNumber *)sourceLaneId andDestinationLaneId:(NSNumber *)destinationLaneId;

/**
 Fetch all the Junctions for the request params.
 @param sourceLaneId of the source station.
 @param destinationLaneId of the destination station.
 @return NSArray is available junctions.
 */
- (NSArray *)fetchAllJunctionsConnectingSourceLaneId:(NSNumber *)sourceLaneId andDestinationLaneId:(NSNumber *)destinationLaneId;

@end
