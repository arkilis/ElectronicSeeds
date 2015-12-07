//
//  FutureSearchResultsTableViewController.m
//  Gremlins
//
//  Created by Ben Liu on 16/08/2015.
//  Copyright (c) 2015 Ben Liu. All rights reserved.
//

#import "FutureSearchResultsTableViewController.h"

@implementation FutureSearchResultsTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // remove all empty rows
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.searchResults count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basicCellSearchResultsFuture" forIndexPath:indexPath];
    SeedModel *item = self.searchResults[indexPath.row];
   
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

@end
