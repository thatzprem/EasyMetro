//
//  EMRouteDisplayTVC.m
//  EasyMetro
//
//  Created by Prem kumar on 20/09/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import "EMRouteDisplayTVC.h"
#import "EMLaneOperations.h"
#import "EMRouteDataTVCell.h"


@interface EMRouteDisplayTVC ()

@end

@implementation EMRouteDisplayTVC

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Route Details";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.aRoute.routeStations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EMRouteDataTVCell *routeDatacell = [tableView dequeueReusableCellWithIdentifier:@"RouteCellID" forIndexPath:indexPath];
    
    // Configure the cell...
    Station *aStation = [self.aRoute.routeStations objectAtIndex:indexPath.row];
    routeDatacell.stationName.text = aStation.stationName;
    
    NSNumber *laneId = aStation.laneId;

    if ([laneId isEqualToNumber:@1]) {
        routeDatacell.backgroundImageView.image = [UIImage imageNamed:@"GreenLane"];
    }
    else if ([laneId isEqualToNumber:@4]) {
        routeDatacell.backgroundImageView.image = [UIImage imageNamed:@"YellowLane"];
    }
    else if ([laneId isEqualToNumber:@2]) {
        routeDatacell.backgroundImageView.image = [UIImage imageNamed:@"BlueLane"];
    }
    else if ([laneId isEqualToNumber:@3]) {
        routeDatacell.backgroundImageView.image = [UIImage imageNamed:@"RedLane"];
    }
    else if ([laneId isEqualToNumber:@5]) {
        routeDatacell.backgroundImageView.image = [UIImage imageNamed:@"BlackLane"];
    }
    else {
        routeDatacell.backgroundImageView.image = [UIImage imageNamed:@"WhiteLane"];
    }
    return routeDatacell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
