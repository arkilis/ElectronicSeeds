//
//  RecvTableTableViewController.h
//  Tuxingsun
//
//  Created by Ben Liu on 21/01/2015.
//  Copyright (c) 2015 Ben Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "SeedModel.h"
#import "CustomTableCell.h"
#import "SelectItemViewController.h"
#import "SWTableViewCell.h"
#import "NearBySearchResultsTableViewController.h"

@interface NearByTableViewController : UITableViewController <UITableViewDataSource,
                                                                UITableViewDelegate,
                                                                SWTableViewCellDelegate,
                                                                UISearchResultsUpdating,
                                                                UISearchControllerDelegate,
                                                                UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UITableView *listTableView;
@property (nonatomic, strong) UISearchController *searchController;

@end
