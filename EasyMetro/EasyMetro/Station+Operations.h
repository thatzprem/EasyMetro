//
//  Station+Operations.h
//  EasyMetro
//
//  Created by Prem kumar on 18/09/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import "Station.h"

@interface Station (Operations)

+ (Station *)stationWithDetails:(NSDictionary *)iDetailsDictionary
      inManagedObjectContext:(NSManagedObjectContext *)context;

@end
