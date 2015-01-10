//
//  Junction.h
//  EasyMetro
//
//  Created by Prem kumar on 18/09/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Junction : NSManagedObject

@property (nonatomic, retain) NSString * cityName;
@property (nonatomic, retain) NSNumber * lane1;
@property (nonatomic, retain) NSNumber * lane2;

@end
