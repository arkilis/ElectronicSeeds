//
//  FutureSearchResultsTableViewController.h
//  Gremlins
//
//  Created by Ben Liu on 16/08/2015.
//  Copyright (c) 2015 Ben Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTableCell.h"
#import "SeedModel.h"
#import "SVProgressHUD.h"
#import "Common.h"
#import "SelectItemViewController.h"

@interface FutureSearchResultsTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *searchResults;

@end
