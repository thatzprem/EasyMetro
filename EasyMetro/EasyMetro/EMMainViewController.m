//
//  EMMainViewController.m
//  EasyMetro
//
//  Created by Prem kumar on 18/09/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import "EMMainViewController.h"
#import "EMRouteDisplayTVC.h"
#import "EMStationsListTVC.h"
#import "EMRoutesTVC.h"

@interface EMMainViewController ()

@property (weak, nonatomic) IBOutlet UIButton *startingStationButton;
@property (weak, nonatomic) IBOutlet UIButton *destinationStationButton;
@property (nonatomic,strong) EMRoutesTVC *routesTVC;

@end

@implementation EMMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib
    self.routesTVC.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; //To remove empty cells in tableview

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


 #pragma mark - Navigation
 
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     
     if([segue.identifier isEqualToString:@"RoutesTVCSegueId"]) {
         self.routesTVC = (EMRoutesTVC *) segue.destinationViewController;
     }
     
     if([segue.identifier isEqualToString:@"StartingStationsListSegueIdentifier"]) {
         
         UINavigationController *navigationController = segue.destinationViewController;
         EMStationsListTVC *routeDisplayTVC =(EMStationsListTVC *)[[navigationController viewControllers] objectAtIndex:0];
         
         routeDisplayTVC.onCancel = ^(){
             NSLog(@"On Cancel.");
             [EMViewModel sharedInstance].startingStation = nil;
             [self.routesTVC reloadViewForNewData];
         };
         
         routeDisplayTVC.onConfirm = ^(Station *startingStation){
             [EMViewModel sharedInstance].startingStation = startingStation;
             self.startingStationButton.titleLabel.text = startingStation.stationName;
             self.startingStationButton.backgroundColor = [self getColorForLaneId:startingStation.laneId];
             [self.routesTVC reloadViewForNewData];
         };
     }
     
     if([segue.identifier isEqualToString:@"DestinationStationsListSegueIdentifier"]) {
         
         UINavigationController *navigationController = segue.destinationViewController;
         EMStationsListTVC *routeDisplayTVC =(EMStationsListTVC *)[[navigationController viewControllers] objectAtIndex:0];
         
         routeDisplayTVC.onCancel = ^(){
             NSLog(@"On Cancel.");
             [EMViewModel sharedInstance].destinationStation = nil;
             [self.routesTVC reloadViewForNewData];
         };
         
         routeDisplayTVC.onConfirm = ^(Station *destinationStation){
             [EMViewModel sharedInstance].destinationStation = destinationStation;
             self.destinationStationButton.titleLabel.text = destinationStation.stationName;
             self.destinationStationButton.backgroundColor = [self getColorForLaneId:destinationStation.laneId];
             [self.routesTVC reloadViewForNewData];
         };
     }

 }
- (IBAction)refreshButtonPressed:(id)sender {
    [self.routesTVC reloadViewForNewData];

}

- (UIColor *)getColorForLaneId:(NSNumber *)laneId {
    
    if ([laneId isEqualToNumber:@1]) {
        return [UIColor greenColor];
    }
    else if ([laneId isEqualToNumber:@2]) {
        return [UIColor blueColor];
    }
    else if ([laneId isEqualToNumber:@3]) {
         return [UIColor redColor];
    }
    else if ([laneId isEqualToNumber:@4]) {
        return [UIColor yellowColor];
    }
    else if ([laneId isEqualToNumber:@5]) {
        return [UIColor grayColor];
    }
    else
        return nil;
}

@end
