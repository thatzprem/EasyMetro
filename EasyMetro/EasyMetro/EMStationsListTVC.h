//
//  EMStationsListTVC.h
//  EasyMetro
//
//  Created by Prem kumar on 20/09/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Station.h"

@interface EMStationsListTVC : UITableViewController

/**
 Call back block to handle the selection and cancel in station list.
 @return Station selected station data model.
 */
@property (copy) void (^onConfirm)(Station *);
@property (copy) void (^onCancel)(void);

@end
