//
//  Lane+Operatios.h
//  EasyMetro
//
//  Created by Prem kumar on 20/09/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import "Lane.h"

@interface Lane (Operatios)

+ (Lane *)laneWithDetails:(NSDictionary *)iDetailsDictionary
   inManagedObjectContext:(NSManagedObjectContext *)context;

@end
