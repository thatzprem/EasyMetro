//
//  EMViewModel.h
//  EasyMetro
//
//  Created by Prem kumar on 20/09/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Station.h"
#import "EMStationDataOperations.h"
#import "EMJunctionDataOperations.h"

@interface EMViewModel : NSObject

@property (nonatomic,strong) Station *startingStation;
@property (nonatomic,strong) Station *destinationStation;
@property (nonatomic,strong) NSMutableArray *routesList; //Array of RouteDetails

+ (EMViewModel *)sharedInstance;
+ (void)resetInstance;

- (EMViewModel *)fetchRoutesForCase1;

@end

@interface RouteDetails : NSObject

@property (nonatomic,strong) NSMutableArray *routeStations;
@property (nonatomic,strong) NSDecimalNumber *cost;
@property (nonatomic,strong) NSNumber *time;

@end
