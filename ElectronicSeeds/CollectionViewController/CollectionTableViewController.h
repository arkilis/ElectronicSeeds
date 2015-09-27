//
//  CollectionTableViewController.h
//  Gremlins
//
//  Created by Ben Liu on 29/07/2015.
//  Copyright (c) 2015 Ben Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "SeedModel.h"
#import "CustomTableCell.h"
#import "SelectItemViewController.h"
#import "SWTableViewCell.h"

@interface CollectionTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, SWTableViewCellDelegate>

@property (strong, nonatomic) IBOutlet UITableView *listTableView;

@end
