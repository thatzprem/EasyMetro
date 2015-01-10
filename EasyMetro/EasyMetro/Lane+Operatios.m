//
//  Lane+Operatios.m
//  EasyMetro
//
//  Created by Prem kumar on 20/09/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import "Lane+Operatios.h"

@implementation Lane (Operatios)

+ (Lane *)laneWithDetails:(NSDictionary *)iDetailsDictionary
           inManagedObjectContext:(NSManagedObjectContext *)context{
    Lane *aLane = nil;
    
    aLane = [NSEntityDescription insertNewObjectForEntityForName:@"Lane" inManagedObjectContext:context];
    aLane.laneKey = iDetailsDictionary[@"laneKey"];
    aLane.laneValue = iDetailsDictionary[@"laneValue"];
    return aLane;
}



@end
