//
//  FutureTableTableViewController.h
//  Gremlins
//
//  Created by Ben Liu on 25/07/2015.
//  Copyright (c) 2015 Ben Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "SeedModel.h"
#import "CustomTableCell.h"
#import "SelectItemViewController.h"
//#import "SWTableViewCell.h"
#import "FutureSearchResultsTableViewController.h"


@interface FutureTableTableViewController : UITableViewController <UITableViewDataSource,
                                                                    UITableViewDelegate,
                                                                    SWTableViewCellDelegate,
                                                                    UISearchResultsUpdating,
                                                                    UISearchControllerDelegate,
                                                                    UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UITableView *listTableView;
@property (nonatomic, strong) UISearchController *searchController;

@end
