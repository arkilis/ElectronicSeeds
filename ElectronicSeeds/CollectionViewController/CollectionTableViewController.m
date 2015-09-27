//
//  CollectionTableViewController.m
//  Gremlins
//
//  Created by Ben Liu on 29/07/2015.
//  Copyright (c) 2015 Ben Liu. All rights reserved.
//

#import "CollectionTableViewController.h"

@interface CollectionTableViewController (){
    NSArray         *aryCollectedSeeds;
}

@end

@implementation CollectionTableViewController

/*
- (void)viewDidLoad {
    [super viewDidLoad];
    
    aryCollectedSeeds= [[NSMutableArray alloc] init];
    
    // load data items
    [self wrapperDownLoadedItems];
    
    // Initialize the refresh control.
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(wrapperDownLoadedItems)
                  forControlEvents:UIControlEventValueChanged];
    
}

*/


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];

    aryCollectedSeeds= [[NSMutableArray alloc] init];
    
    // load data items
    [self wrapperDownLoadedItems];
    
    // Initialize the refresh control.
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(wrapperDownLoadedItems)
                  forControlEvents:UIControlEventValueChanged];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) wrapperDownLoadedItems{
    
    // retrieve from NSUserDefault
    aryCollectedSeeds= [Common getStoredSeeds];
    NSLog(@"%@", aryCollectedSeeds);
    
    // populate the table view
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    
    // end refreshing
    [self.listTableView reloadData];
    
    // End the refreshing
    if (self.refreshControl) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
        
        [self.refreshControl endRefreshing];
    }
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return aryCollectedSeeds.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = @"basicCellCollection";
    CustomTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // Get references to labels of cell
    if (cell == nil) {
        cell = [[CustomTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // add Right Swipe
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor: [Common colorFromHexString:@"#2488FC"]
                                                title: @"Remove"];
    cell.rightUtilityButtons = rightUtilityButtons;
    cell.delegate= self;
    
    // Get the location to be shown
    SeedModel *seedItem= (SeedModel*)aryCollectedSeeds[indexPath.row];
    
    cell.labelStationName.text  = seedItem.seedName;            // seed Name
    cell.labelCategory.text     = seedItem.category;            // category
    //cell.labelPostDate.text   = item.postDateTime;            // post DateTime
    // Distance
    cell.labelDistance.text     = [NSString stringWithFormat:@"%.2f Meters", [seedItem.range floatValue]];
    
    if([seedItem.category isEqual:@"Freebie"]){
        cell.imageCategory.image= [UIImage imageNamed:@"freebie_512.jpg"];
    }
    if([seedItem.category isEqual:@"Discount"]){
        cell.imageCategory.image= [UIImage imageNamed:@"discount_512.jpg"];
    }
    if([seedItem.category isEqual:@"Entertainment"]){
        cell.imageCategory.image= [UIImage imageNamed:@"entertainment_512.png"];
    }
    
    cell.labelExpiredDate.text  = seedItem.expireDateTime;      // Expire date time
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    //cell.backgroundView =  [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"cell_bkground5_green.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
    return cell;
    
}


// override the cell click event
// which will not display the navigation bar
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"showDetailCollect" sender:self];
}

// When click the table item
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showDetailCollect"]) {
        NSIndexPath *indexPath = [self.listTableView indexPathForSelectedRow];
        [SVProgressHUD show];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            // post a click stats including: latitude/longitude & stationID
            Common *common = [[Common alloc] init];
            NSString *szSendClientStatsURL= [NSString stringWithFormat:@"%@%@", szURLMain, szURLSendStats];
            SeedModel *item = aryCollectedSeeds[indexPath.row];
            
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            [manager POST: szSendClientStatsURL
               parameters: @{
                             @"latlng": [common deviceLocation],        // format example: -27.496719,153.010117
                             @"seedID":[NSString stringWithFormat:@"%@", item.seedID]
                             }
                  success: ^(AFHTTPRequestOperation *operation, id responseObject) {
                      NSLog(@"JSON: %@", responseObject);
                      // transition
                      SelectItemViewController *destViewController = segue.destinationViewController;
                      destViewController.selectedSeed = [aryCollectedSeeds objectAtIndex:indexPath.row];
                      dispatch_async(dispatch_get_main_queue(), ^{
                          [SVProgressHUD dismiss];
                      });
                  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                      NSLog(@"Error: %@", error);
                      dispatch_async(dispatch_get_main_queue(), ^{
                          // Ben: this should be deleted when distributed
                          [SVProgressHUD showErrorWithStatus:@"Click Stats wrong"];
                      });
                  }];
        });
    }
}




#pragma mark - Right Swipe on table cell

// Action for right swipe
// -- for collection
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        // delete a station
        case 0:
        {
            NSArray *aryStoredSeeds= [Common getStoredSeeds];
            // New array to remove the selected item
            NSMutableArray *aryNewStations = [[NSMutableArray alloc]initWithArray:aryStoredSeeds];
            NSIndexPath *cellIndexPath     = [self.tableView indexPathForCell:cell];
            [aryNewStations removeObjectAtIndex:cellIndexPath.row];
            [Common setStoredSeeds:aryNewStations];
            
            [SVProgressHUD showInfoWithStatus:@"Remove Successfully!"];
            [cell hideUtilityButtonsAnimated:YES];
            [self wrapperDownLoadedItems];
            break;
        }
        default:
            break;
    }
}


#pragma mark - bar buttom item "clear"

// button clear event

- (IBAction)btnClear:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Clear!"
                                                    message:@"Are you sure you want to clear your colleced seeds?"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Ok", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    // Click "OK"
    if (buttonIndex==1) {
        [self clearAll];
        [self wrapperDownLoadedItems];
    }
}


- (void) clearAll{
    aryCollectedSeeds= [[NSArray alloc] init];
    [Common setStoredSeeds:aryCollectedSeeds];
}


@end
