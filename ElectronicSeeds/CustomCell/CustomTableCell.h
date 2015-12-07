//
//  CustomTableViewCell.h
//  Test_TableView
//
//  Created by Ben Liu on 1/02/2015.
//  Copyright (c) 2015 Ben Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "Common.h"
#import "Masonry.h"
#import "MMPlaceHolder.h"
#import "SWTableViewCell.h"

@interface CustomTableCell : SWTableViewCell


@property (strong, nonatomic) IBOutlet UILabel      *labelStationName;
@property (strong, nonatomic) IBOutlet UILabel      *labelDistance;
@property (strong, nonatomic) IBOutlet UIImageView  *imageImportance;
@property (strong, nonatomic) IBOutlet UILabel      *labelExpiredDate;
@property (strong, nonatomic) IBOutlet UIImageView  *imageCategory;
@property (strong, nonatomic) IBOutlet UILabel      *labelCategory;


@property (strong, nonatomic) IBOutlet UILabel      *labelLogo;
@property (strong, nonatomic) IBOutlet UILabel      *labelPostDate;



-(void) createLayout:(NSString*)szSeedName
        withCategory:(NSString*)szCategory
        withDistance:(double)distance
   withCategoryImage:(UIImage*)imageCategory
      withImportance:(NSString*)szImportance
      withExpireDate:(NSString*)szExpireDate;


@end
