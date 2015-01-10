//
//  EMRoutesTVC.m
//  EasyMetro
//
//  Created by Prem kumar on 20/09/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import "EMRoutesTVC.h"
#import "EMStationDataOperations.h"
#import "EMJunctionDataOperations.h"
#import "EMRouteDisplayTVC.h"
#import "EMRouteDetailsTVCell.h"
#import "MBProgressHUD.h"
#import "NSJSONSerialization+Additions.h"

@interface EMRoutesTVC ()

@property (nonatomic,strong) EMViewModel *viewModel;
@property (nonatomic,assign) NSInteger sectionsCountToDisplay;

@end

@implementation EMRoutesTVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to refresh"];
    [refresh addTarget:self
                action:@selector(reloadViewForNewData)
      forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;

//    [self reloadViewForNewData];
    
    self.sectionsCountToDisplay = 0;
    self.viewModel = [EMViewModel sharedInstance];
    [self fetchRoutes];
}

- (void)reloadViewForNewData {
    self.sectionsCountToDisplay = 0;
    self.viewModel = [EMViewModel sharedInstance];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Updating..."];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    [self fetchRoutes];
    
    [MBProgressHUD hideHUDForView:self.view.window animated:YES]; // Remove progressview indicator.
    [self.refreshControl endRefreshing];
}

- (void)fetchServerUpdates{
    
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSString *urlString = @"";
            NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
            NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
            NSURL *url = [NSURL URLWithString:urlString];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                                   cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                               timeoutInterval:60.0];
            
            NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                NSString *jsonString = [NSJSONSerialization convertNSDataToJsonString:data];
                NSDictionary *jsonDictionary = [NSJSONSerialization convertJsonStringToDictionary:jsonString];
                
                NSLog(@"SERVER DATA");
                
        }];
            [postDataTask resume];
        });
}

- (void)fetchRoutes {
    
    // Do an online search to know.
    
//    NSString *aPath1 = [[NSBundle mainBundle] pathForResource:@"Response.json" ofType:@"json"];
//	NSDictionary *jsonValue = [NSDictionary dictionaryWithContentsOfFile:aPath1];
//
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Response" ofType:@"json"];
//    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
//    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
//
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
//                                                NSUserDomainMask,
//                                                YES);
//    
//    NSString *fullPath = [[paths lastObject] stringByAppendingPathComponent:@"Response.json"];
//    NSData *jsonData1 = [[NSFileManager defaultManager] contentsAtPath:fullPath];

    //
    //Process data from server.
    
    NSDictionary * responseDataDictionary = [NSDictionary new];
    NSArray *stationsArray = responseDataDictionary[@"stations"];
    
    [responseDataDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
       
        if ([key isKindOfClass:[NSDictionary class]]) {
            NSDictionary *aStationDict = (NSDictionary *)key;
            NSString *aStationName = aStationDict[@"stationName"];
            
        }
    }];
    //
    
    self.viewModel.routesList = nil;
    if (self.viewModel.routesList == nil) {
        self.viewModel.routesList = [NSMutableArray array];
    }
    
    if (self.viewModel == nil) {
        NSLog(@"In sufficient data to proceed...");
        self.viewModel.routesList = nil;
        [self.tableView reloadData];
        return;
        
    }
    
    if (self.viewModel != nil) {
        if (self.viewModel.startingStation == nil || self.viewModel.destinationStation == nil) {
            NSLog(@"In sufficient data to proceed...");
            self.viewModel.routesList = nil;
            [self.tableView reloadData];
            return;
        }
    }
    
    EMStationDataOperations *stationDataOperations = [[EMStationDataOperations alloc] init];
    EMJunctionDataOperations *junctionDataOperations = [[EMJunctionDataOperations alloc] init];
    
    Station *sourceStation = [stationDataOperations fetchStationForStationName:self.viewModel.startingStation.stationName andSourceLaneId:self.viewModel.startingStation.laneId];
    Station *destinationStation = [stationDataOperations fetchStationForStationName:self.viewModel.destinationStation.stationName andSourceLaneId:self.viewModel.destinationStation.laneId];
        
    if (sourceStation != nil && destinationStation != nil) {
        
        if ([sourceStation.laneId isEqualToNumber:destinationStation.laneId]) {
            
//            NSLog(@"CASE - 1: Source and destination lanes are same.");
//            int abs_diff = abs([sourceStation.stationLineNo intValue] - [destinationStation.stationLineNo intValue]);
//            NSLog(@"Stations between two statios: %d",abs_diff);
//            NSArray *stations = [stationDataOperations fetchAllStationsWithSourceLaneId:sourceStation.laneId andMinLaneNo:sourceStation.stationLineNo andMaxLaneNo:destinationStation.stationLineNo];
//            RouteDetails *aRoute = [RouteDetails new];
//            aRoute.cost = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lu",(long)stations.count -1]];
//            aRoute.time = [NSNumber numberWithUnsignedLong:stations.count - 1];
//
//            [aRoute.routeStations addObjectsFromArray:stations];
//            
//            [self.viewModel.routesList addObject:aRoute];
            [self.viewModel fetchRoutesForCase1];
            
            //Validate if the route stations is any if the once in the dict
                [self.viewModel.routesList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    
                    if ([obj isKindOfClass:[Station Class]]) {
                        <#statements#>
                    }
                }];
            
        }
        else{
            
            Junction *aJunction = [junctionDataOperations fetchJunctionConnectingSourceLaneId:sourceStation.laneId andDestinationLaneId:destinationStation.laneId];
            
            if (aJunction == nil) {
                NSLog(@"CASE - 3: Source and destination stations have connecting lane.");
                
                //Get stations with junctions for sourceStation.
                
                NSNumber *sourceLaneId = sourceStation.laneId;
                NSNumber *destinationId = destinationStation.laneId;
                
                NSArray *sourceJunctions = [stationDataOperations fetchStationsWithJunctionForSourceLaneId:sourceLaneId];
                
                //Get stations with junctions for destinationStation.
                NSArray *destinationJunctions = [stationDataOperations fetchStationsWithJunctionForSourceLaneId:destinationId];
                
                //Get the common connecting lane
                NSMutableArray *routesArray = [NSMutableArray array];
                
                for (Station *aSourceJunction in sourceJunctions) {
                    
                    for (Station *aDestJunction in destinationJunctions) {
                        
                        
                        if ([aSourceJunction.linkingLaneId isEqualToNumber:aDestJunction.linkingLaneId]) {
                            
                            RouteDetails *aRoute = [RouteDetails new];
                            
                            NSNumber *linkingLaneId  = aSourceJunction.linkingLaneId;
                            NSLog(@"Linking lane station id : %@",aSourceJunction.linkingLaneId);
                            
                            NSArray *sourceStationArray = [stationDataOperations fetchAllStationsWithSourceLaneId:sourceStation.laneId andMinLaneNo:sourceStation.stationLineNo andMaxLaneNo:aSourceJunction.stationLineNo];
                            for (Station *aStation in sourceStationArray) {
                                NSLog(@"****ROUTE: %@",aStation.stationName);
                            }
                            [aRoute.routeStations addObjectsFromArray:sourceStationArray];
                            
                            Station *connectingSource = [stationDataOperations fetchStationForLinkedSourceId:aSourceJunction.laneId andLaneId:linkingLaneId];
                            Station *connectingDest = [stationDataOperations fetchStationForLinkedSourceId:aDestJunction.laneId andLaneId:linkingLaneId];
                            NSArray *linkingStationsArray = [stationDataOperations fetchAllStationsWithSourceLaneId:linkingLaneId andMinLaneNo:connectingSource.stationLineNo andMaxLaneNo:connectingDest.stationLineNo];
                            for (Station *aStation in linkingStationsArray) {
                                NSLog(@"****ROUTE: %@",aStation.stationName);
                            }
                            [aRoute.routeStations addObjectsFromArray:linkingStationsArray];

                            NSArray *destinationStationArray = [stationDataOperations fetchAllStationsWithSourceLaneId:destinationStation.laneId andMinLaneNo:aDestJunction.stationLineNo andMaxLaneNo:destinationStation.stationLineNo];
                            for (Station *aStation in destinationStationArray) {
                                NSLog(@"****ROUTE: %@",aStation.stationName);
                            }
                            [aRoute.routeStations addObjectsFromArray:destinationStationArray];
                            
                            aRoute.cost = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lu",(long)aRoute.routeStations.count - 1]];
                            aRoute.time = [NSNumber numberWithUnsignedLong:aRoute.routeStations.count - 3];
                            
                            [routesArray addObject:aRoute];
                        }
                        else {
                            // NSLog(@"CASE - 4: Source and destination stations do not have connecting lane.");
                        }
                    }
                }
                
                if (routesArray.count > 0) {
                    
                    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"time" ascending:YES]];
                    NSArray *sortedArray = [routesArray sortedArrayUsingDescriptors:sortDescriptors];
                    
                    [self.viewModel.routesList addObject:[sortedArray firstObject]];
                }
            }
            else{
                NSLog(@"CASE - 2: Source and destination stations have a connecting junction.");
                NSLog(@"Name of the connecting junction: %@",aJunction.cityName);
                
                RouteDetails *aRoute = [RouteDetails new];

                NSArray *junctionStations = [stationDataOperations fetchStationsForJunction:aJunction];
                
                [junctionStations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    
                    if ([obj isKindOfClass:[Station class]]) {
                        Station *aStation = (Station *)obj;
                        
                        if ([aStation.laneId isEqualToNumber:sourceStation.laneId ]) {
                            NSArray *stationsInSourceLane =  [stationDataOperations fetchAllStationsWithSourceLaneId:sourceStation.laneId andMinLaneNo:sourceStation.stationLineNo andMaxLaneNo:aStation.stationLineNo];
                            
                            [stationsInSourceLane enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                Station *aStation  = (Station *)obj;
                                NSLog(@"****ROUTE: %@",aStation.stationName);
                                [aRoute.routeStations addObject:aStation];
                            }];
                        }
                    }
                }];
                
                [junctionStations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    
                    if ([obj isKindOfClass:[Station class]]) {
                        Station *aStation = (Station *)obj;
                        
                        if ([aStation.laneId isEqualToNumber:destinationStation.laneId]){
                            NSArray *stationsInDestLane =  [stationDataOperations fetchAllStationsWithSourceLaneId:destinationStation.laneId andMinLaneNo:aStation.stationLineNo andMaxLaneNo:destinationStation.stationLineNo];
                            
                            [stationsInDestLane enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                Station *aStation  = (Station *)obj;
                                NSLog(@"****ROUTE: %@",aStation.stationName);
                                [aRoute.routeStations addObject:aStation];
                            }];
                        }
                    }
                }];
                
                //There will an identical.
                aRoute.cost = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lu",(unsigned long)aRoute.routeStations.count - 1]];
                aRoute.time = [NSNumber numberWithUnsignedLong:aRoute.routeStations.count - 2];
                [self.viewModel.routesList addObject:aRoute];
            }
        }
    }
    self.sectionsCountToDisplay = 1;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel.routesList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EMRouteDetailsTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RouteNameCellID" forIndexPath:indexPath];
    
    RouteDetails *aRouteDetail = [self.viewModel.routesList objectAtIndex:indexPath.row];
    // Configure the cell...
    cell.routeNameLabel.text = [NSString stringWithFormat:@"Route - %ld",(unsigned long)indexPath.row +1];
    cell.costIncuredLabel.text = [NSString stringWithFormat:@"$ %@",aRouteDetail.cost];
    cell.timeTakenLabel.text = [NSString stringWithFormat:@"%d min ",[aRouteDetail.time intValue] * 5];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    label.numberOfLines = 2;
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    NSString *string = nil;
    if (self.sectionsCountToDisplay == 1) {
        string = @"Optimal route found... Tap the route for details...";
    }
    else if (self.sectionsCountToDisplay == 0) {
        string = @"Choose the stations...No routes found yet...";
    }
    /* Section header is in 0th index... */
    [label setText:string];
    [view addSubview:label];
    return view;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    RouteDetails *aRoute  = [self.viewModel.routesList objectAtIndex:indexPath.row];
    EMRouteDisplayTVC *routeDisplayTVC = (EMRouteDisplayTVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"DisplayRouteStoryboardID"];
    routeDisplayTVC.aRoute = aRoute;
    [self.navigationController pushViewController:routeDisplayTVC animated:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//    
//        if([segue.identifier isEqualToString:@"RoutesTVCSegueId"]) {
//            EMRouteDisplayTVC *routeDisplayTVC = (EMRouteDisplayTVC *) segue.destinationViewController;
//            if ([sender isKindOfClass:[NSArray class]])
//                routeDisplayTVC.routesNamesArray = sender;
//            else
//                routeDisplayTVC.routesNamesArray = nil;
//        }
//}

@end
