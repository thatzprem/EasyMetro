//
//  EMLaneOperations.h
//  EasyMetro
//
//  Created by Prem kumar on 20/09/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Lane.h"

@interface EMLaneOperations : NSObject

/**
 Fetch all the lane datamodels for DB.
 @return NSArray for results.
 */
- (NSArray *)fetchAllLanes;

/**
 Fetch the lane name for the lanekey.
 @param laneKey to get the name.
 @return NSArray for results.
 */
- (NSString *)fetchLaneForLaneKey:(NSNumber *)laneKey;

@end
