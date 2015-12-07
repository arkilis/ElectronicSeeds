//
//  CollectionTableViewController.m
//  Gremlins
//
//  Created by Ben Liu on 29/07/2015.
//  Copyright (c) 2015 Ben Liu. All rights reserved.
//

#import "CollectionTableViewController.h"

@interface CollectionTableViewController (){
    SeedModel       *seedModel;
    NSArray         *aryCollectedSeeds;
    NSMutableArray  *searchResultsCollect;
}

@end

@implementation CollectionTableViewController

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];

    aryCollectedSeeds= [[NSMutableArray alloc] init];
    
    // load data items
    [self wrapperDownLoadedItems];
    
    // initialize the search results
    CollectionSearchResultsTableViewController *searchResultsController = [[self storyboard]
                                                                       instantiateViewControllerWithIdentifier:@"SearchResultsCollectionTableViewController"];
    
    // initialize the search control
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultsController];
    self.searchController.searchResultsUpdater = self;
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
    searchResultsController.tableView.delegate= self;
    self.searchController.delegate= self;
    self.searchController.dimsBackgroundDuringPresentation= NO;
    self.searchController.searchBar.delegate= self;
    
    // Initialize the refresh control.
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(wrapperDownLoadedItems)
                  forControlEvents:UIControlEventValueChanged];
    
    // remove all empty rows
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
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
    SeedModel *item= (SeedModel*)aryCollectedSeeds[indexPath.row];
   
    // Category
    NSDictionary    *imageCategory= [Common initCategoryImages];
    NSString        *szImageCategorName= imageCategory[item.category];
    
    [cell createLayout:item.seedName
          withCategory:item.category
          withDistance:[item.range floatValue]
     withCategoryImage:[UIImage imageNamed:szImageCategorName]
        withImportance:item.importance
        withExpireDate:item.expireDateTime];
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
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
        
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
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


#pragma mark - Search Results
// Called when the search bar becomes first responder
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    // Set searchString equal to what's typed into the searchbar
    NSString *searchString = self.searchController.searchBar.text;
    [self updateFilteredContentForStringName:searchString];
    // If searchResultsController
    if (self.searchController.searchResultsController) {
        CollectionSearchResultsTableViewController *vc = (CollectionSearchResultsTableViewController *)self.searchController.searchResultsController;
        // Update searchResults
        vc.searchResults = searchResultsCollect;
        // And reload the tableView with the new data
        [vc.tableView reloadData];
    }
}


// Update self.searchResults based on searchString, which is the argument in passed to this method
- (void)updateFilteredContentForStringName:(NSString *)searchText
{
    
    if (searchText == nil) {
        // If empty the search results are the same as the original data
        searchResultsCollect = [aryCollectedSeeds mutableCopy];
    } else {
        NSMutableArray *searchResults = [[NSMutableArray alloc] init];
        for (SeedModel *seed in aryCollectedSeeds) {
            if ([seed.seedName containsString:searchText]) {
                [searchResults addObject:seed];
            }
        }
        searchResultsCollect= searchResults;
        
        CollectionSearchResultsTableViewController *tableController = (CollectionSearchResultsTableViewController *)self.searchController.searchResultsController;
        tableController.searchResults = searchResults;
        [tableController.tableView reloadData];
    }
}


@end
