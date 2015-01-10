//
//  EMStationsListTVC.m
//  EasyMetro
//
//  Created by Prem kumar on 20/09/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import "EMStationsListTVC.h"
#import "EMStationDataOperations.h"
#import "EMLaneOperations.h"
#import "Lane+Operatios.h"

@interface EMStationsListTVC ()

@property (nonatomic,strong) NSMutableArray *stationsArray;
@property (nonatomic,strong) NSArray *lanesArray;

@end

@implementation EMStationsListTVC

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
    
    self.lanesArray = @[@1,@2,@3,@4,@5];
    self.stationsArray = [NSMutableArray array];
    [self.lanesArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSMutableDictionary *aDictionary = [NSMutableDictionary dictionary];
        [aDictionary setObject:obj forKey:[[EMStationDataOperations new] fetchStationsWithLaneId:(NSNumber *)obj]];
        [self.stationsArray addObject:aDictionary];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)doneButtonPressed:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.onCancel)
            self.onCancel();
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.lanesArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[EMStationDataOperations new] fetchStationsWithLaneId:[self.lanesArray objectAtIndex:section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StationCellID" forIndexPath:indexPath];
    
    NSNumber *laneId = [self.lanesArray objectAtIndex:indexPath.section];
    NSArray *stationsList = [[EMStationDataOperations new] fetchStationsWithLaneId:laneId];
    Station *aStation = [stationsList objectAtIndex:indexPath.row];
    cell.textLabel.text = aStation.stationName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self dismissViewControllerAnimated:YES completion:^{
        NSNumber *laneId = [self.lanesArray objectAtIndex:indexPath.section];
        NSArray *stationsList = [[EMStationDataOperations new] fetchStationsWithLaneId:laneId];
        Station *aStation = [stationsList objectAtIndex:indexPath.row];
        
        if (self.onConfirm)
            self.onConfirm(aStation);
    }];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    
    EMLaneOperations *laneOperations  = [EMLaneOperations new];
    
    NSNumber *laneId = [self.lanesArray objectAtIndex:section];
    
    if ([laneId isEqualToNumber:@1]) {
        [view setBackgroundColor:[UIColor greenColor]];
    }
    else if ([laneId isEqualToNumber:@2]) {
        [view setBackgroundColor:[UIColor blueColor]];
    }
    else if ([laneId isEqualToNumber:@3]) {
        [view setBackgroundColor:[UIColor redColor]];
    }
    else if ([laneId isEqualToNumber:@4]) {
        [view setBackgroundColor:[UIColor yellowColor]];
    }
    else if ([laneId isEqualToNumber:@5]) {
        [view setBackgroundColor:[UIColor grayColor]];
    }
    
    NSString *string = [laneOperations fetchLaneForLaneKey:[self.lanesArray objectAtIndex:section]];
    /* Section header is in 0th index... */
    [label setText:string];
    [view addSubview:label];
    return view;
}

@end
