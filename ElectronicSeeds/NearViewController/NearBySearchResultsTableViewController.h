//
//  NearBySearchResultsTableViewController.h
//  Gremlins
//
//  Created by Ben Liu on 3/08/2015.
//  Copyright (c) 2015 Ben Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTableCell.h"
#import "SeedModel.h"
#import "SVProgressHUD.h"
#import "Common.h"
#import "SelectItemViewController.h"

@interface NearBySearchResultsTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *searchResults;

@end
