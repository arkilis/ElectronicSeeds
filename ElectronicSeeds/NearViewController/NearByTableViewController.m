//
//  RecvTableTableViewController.m
//  Tuxingsun
//
//  Created by Ben Liu on 21/01/2015.
//  Copyright (c) 2015 Ben Liu. All rights reserved.
//

#import "NearByTableViewController.h"


@interface NearByTableViewController () {
    SeedModel       *seedModel;
    NSArray         *arySeeds;
    NSMutableArray  *searchResultsNow;
}
@end



@implementation NearByTableViewController 


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // initialize the search results
    NearBySearchResultsTableViewController *searchResultsController = [[self storyboard]
                                                                       instantiateViewControllerWithIdentifier:@"SearchResultsNowTableViewController"];
    
    // initialize the data
    [self wrapperDownLoadedItems];
    
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
    
    // initialize the refresh control.
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
    
    Common *common= [[Common alloc] init];
    
    [common getNearbySeedsArray: [common deviceLocation]
                 withCompletion: ^(NSMutableArray* aryMutableSeeds){
                     arySeeds= [NSArray arrayWithArray:aryMutableSeeds];
                     // populate the table view
                     self.listTableView.delegate = self;
                     self.listTableView.dataSource = self;
                     
                     // Reload the table view
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
     ];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return arySeeds.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *cellIdentifier = @"basicCellNow";
    CustomTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // get references to labels of cell
    if (cell == nil) {
        cell = [[CustomTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    
    // add Right Swipe
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor: [Common colorFromHexString:@"#FB3032"]
                                                title: @"Collect"];
    [rightUtilityButtons sw_addUtilityButtonWithColor: [Common colorFromHexString:@"#BBBAC2"]
                                                title: @"Dislike"];
    
    cell.rightUtilityButtons = rightUtilityButtons;
    cell.delegate= self;
    
    // Get the location to be shown
    SeedModel *item = arySeeds[indexPath.row];
    
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

// When click the table item
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showDetailNow"]) {
        NSIndexPath *indexPath = [self.listTableView indexPathForSelectedRow];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD show];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            // post a click stats including: latitude/longitude & stationID
            Common *common = [[Common alloc] init];
            NSString *szSendClientStatsURL= [NSString stringWithFormat:@"%@%@", szURLMain, szURLSendStats];
            SeedModel *item = arySeeds[indexPath.row];
            
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            [manager POST: szSendClientStatsURL
               parameters: @{
                             @"latlng": [common deviceLocation],        // format example: -27.496719,153.010117
                             @"seedID":[NSString stringWithFormat:@"%@", item.seedID]
                             }
                  success: ^(AFHTTPRequestOperation *operation, id responseObject) {
                      NSLog(@"JSON: %@", responseObject);
                      // transition
                      SelectItemViewController *destViewController = (SelectItemViewController*)segue.destinationViewController;
                      destViewController.selectedSeed = [arySeeds objectAtIndex:indexPath.row];
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


// override the cell click event
// which will not display the navigation bar
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"showDetailNow" sender:self];
}


#pragma mark - Right Swipe on table cell

// Action for right swipe
// -- for collection
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    switch (index) {
        case 0:
        {
            // get the local stations if there is any
            NSArray *aryStoredSeeds             = [Common getStoredSeeds];
            NSIndexPath *cellIndexPath          = [self.tableView indexPathForCell:cell];
            SeedModel *seedWantedTobeCollected  = (SeedModel*)[arySeeds objectAtIndex:cellIndexPath.row];
            int count                           = 0;
            
            // if there is no userdefault, then create one
            if([aryStoredSeeds count]==0){
                NSArray *aryNewSeeds    = [NSArray arrayWithObjects: seedWantedTobeCollected, nil];
                [Common setStoredSeeds:aryNewSeeds];
                [SVProgressHUD showSuccessWithStatus:@"Succeed!"];
                
            }else{
                // if the new station is not in the stored array yet, add to the array
                for(SeedModel *s in aryStoredSeeds) {
                    if([s isEqual:seedWantedTobeCollected]==NO){
                        count++;
                    }
                }
                if(count == [aryStoredSeeds count]){
                    [Common AddStoredSeed:seedWantedTobeCollected];
                    [SVProgressHUD showSuccessWithStatus:@"Succeed!"];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"Already in Collection"];
                }
            }
            [cell hideUtilityButtonsAnimated:YES];
            break;
        }
        case 1:
        {
            
            [cell hideUtilityButtonsAnimated:YES];
            break;
        }
        default:
            break;
    }

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
        NearBySearchResultsTableViewController *vc = (NearBySearchResultsTableViewController *)self.searchController.searchResultsController;
        // Update searchResults
        vc.searchResults = searchResultsNow;
        // And reload the tableView with the new data
        [vc.tableView reloadData];
    }
}


// Update self.searchResults based on searchString, which is the argument in passed to this method
- (void)updateFilteredContentForStringName:(NSString *)searchText
{
    
    if (searchText == nil) {
        // If empty the search results are the same as the original data
        searchResultsNow = [arySeeds mutableCopy];
    } else {
        NSMutableArray *searchResults = [[NSMutableArray alloc] init];
        for (SeedModel *seed in arySeeds) {
            if ([seed.seedName containsString:searchText]) {
                [searchResults addObject:seed];
            }
        }
        searchResultsNow= searchResults;
        NearBySearchResultsTableViewController *tableController = (NearBySearchResultsTableViewController *)self.searchController.searchResultsController;
        tableController.searchResults = searchResults;
        [tableController.tableView reloadData];
    }
}

@end































