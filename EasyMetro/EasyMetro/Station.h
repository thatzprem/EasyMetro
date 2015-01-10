//
//  Station.h
//  EasyMetro
//
//  Created by Prem kumar on 30/09/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Station : NSManagedObject

@property (nonatomic, retain) NSNumber * laneId;
@property (nonatomic, retain) NSNumber * linkingLaneId;
@property (nonatomic, retain) NSNumber * stationLineNo;
@property (nonatomic, retain) NSString * stationName;
@property (nonatomic, retain) NSNumber * isAvailable;

@end
