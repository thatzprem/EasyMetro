//
//  Lane.h
//  EasyMetro
//
//  Created by Prem kumar on 18/09/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Lane : NSManagedObject

@property (nonatomic, retain) NSNumber * laneKey;
@property (nonatomic, retain) NSString * laneValue;

@end
