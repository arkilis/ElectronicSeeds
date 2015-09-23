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
    
    // Cell Style
    cell.labelStationName.text  = item.seedName;            // Seed Name
    cell.labelCategory.text     = item.category;            // Category
    
    // Distance
    cell.labelDistance.text     = [NSString stringWithFormat:@"%.2f Meters", [item.range floatValue]];
    
    if([item.category isEqual:@"Freebie"]){
        cell.imageCategory.image= [UIImage imageNamed:@"freebie_512.jpg"];
    }
    if([item.category isEqual:@"Discount"]){
        cell.imageCategory.image= [UIImage imageNamed:@"discount_512.jpg"];
    }
    if([item.category isEqual:@"Entertainment"]){
        cell.imageCategory.image= [UIImage imageNamed:@"entertainment_512.png"];
    }
    
    cell.labelExpiredDate.text  = item.expireDateTime;      // Expire date time
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    
    return cell;
}

@end
