//
//  Junction+Operations.m
//  EasyMetro
//
//  Created by Prem kumar on 18/09/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import "Junction+Operations.h"

@implementation Junction (Operations)

+ (Junction *)junctionWithDetails:(NSDictionary *)iDetailsDictionary
      inManagedObjectContext:(NSManagedObjectContext *)context{
    Junction *aJunction = nil;
    
    aJunction = [NSEntityDescription insertNewObjectForEntityForName:@"Junction" inManagedObjectContext:context];
    aJunction.cityName = iDetailsDictionary[@"cityName"];
    aJunction.lane1 = iDetailsDictionary[@"lane1"];
    aJunction.lane2 = iDetailsDictionary[@"lane2"];
    return aJunction;
}


@end
