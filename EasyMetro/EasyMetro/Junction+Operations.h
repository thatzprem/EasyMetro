//
//  Junction+Operations.h
//  EasyMetro
//
//  Created by Prem kumar on 18/09/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import "Junction.h"

@interface Junction (Operations)

+ (Junction *)junctionWithDetails:(NSDictionary *)iDetailsDictionary
           inManagedObjectContext:(NSManagedObjectContext *)context;

@end
