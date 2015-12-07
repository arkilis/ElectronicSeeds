//
//  CustomTableViewCell.m
//  Test_TableView
//
//  Created by Ben Liu on 1/02/2015.
//  Copyright (c) 2015 Ben Liu. All rights reserved.
//

#import "CustomTableCell.h"

@implementation CustomTableCell

// These two functions are all default methos after creation

- (void)awakeFromNib {
    // Initialization code
     
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


// write a function receive all the parametere and
-(void) createLayout:(NSString*)szSeedName
        withCategory:(NSString*)szCategory
        withDistance:(double)distance
   withCategoryImage:(UIImage*)imageCategory
      withImportance:(NSString*)szImportance
      withExpireDate:(NSString*)szExpireDate
{
    
    UIView *sv= self.contentView;
    
    UIView *containterView= [UIView new];
    containterView.backgroundColor= [UIColor whiteColor];
    [sv addSubview:containterView];
    [containterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(sv).with.insets(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    
    // add category image
    UIImageView *imageView= [UIImageView new];
    imageView.image= imageCategory;
    imageView.contentMode= UIViewContentModeScaleAspectFit;
    [sv addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(containterView.mas_top).with.offset(10);
        make.left.equalTo(containterView.mas_left).with.offset(10);
        make.height.equalTo(@88);
        make.width.equalTo(@88);
    }];
    
    // add category name
    UILabel *categoryLabel= [UILabel new];
    [categoryLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:11]];
    [categoryLabel setText:szCategory];
    [sv addSubview:categoryLabel];
    [categoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).with.offset(2);
        make.centerX.equalTo(imageView.mas_centerX).with.offset(5);
        make.height.equalTo(@10);
        make.width.equalTo(@50);
    }];
    
    // add seed name
    UILabel *seedNameLabel= [UILabel new];
    [seedNameLabel setFont:[UIFont fontWithName:szFontStyle size:18]];
    [seedNameLabel setText:szSeedName];
    [containterView addSubview:seedNameLabel];
    [seedNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(containterView.mas_top).with.offset(5);
        make.left.equalTo(imageView.mas_right).with.offset(2);
        make.height.equalTo(@44);
        make.width.equalTo(containterView).multipliedBy(.5);
    }];
    
    // add distnace
    UILabel *distanceLabel= [UILabel new];
    [distanceLabel setFont:[UIFont fontWithName:szFontStyle size:14]];
    [distanceLabel setText: [NSString stringWithFormat:@"%.2f Meters", distance]];
    [containterView addSubview:distanceLabel];
    [distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(seedNameLabel.mas_bottom).with.offset(0);
        make.left.equalTo(seedNameLabel.mas_left).with.offset(5);
        make.height.equalTo(@20);
        make.width.equalTo(seedNameLabel);
    }];
    
    // add importance
    if([szImportance isEqualToString:@"1"]){
        UIImageView *imageImportance= [UIImageView new];
        imageImportance.image= [UIImage imageNamed:@"dot.png"];
        imageImportance.contentMode= UIViewContentModeScaleAspectFit;
        [containterView addSubview:imageImportance];
        [imageImportance mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(containterView.mas_top).with.offset(20);
            make.right.equalTo(containterView.mas_right).with.offset(-10);
            make.height.equalTo(@10);
            make.width.equalTo(@10);
        }];
     }
     
     // add expire date
     UILabel *expireDateLabel= [UILabel new];
     [expireDateLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:11]];
     expireDateLabel.textColor=[Common colorFromHexString:szColorCellText];
     [expireDateLabel setText: [NSString stringWithFormat:@"Expire Date: %@", szExpireDate]];
     [containterView addSubview:expireDateLabel];
     [expireDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(containterView.mas_right).with.offset(-5);
        make.top.equalTo(categoryLabel.mas_top);
        make.height.equalTo(@10);
        make.width.equalTo(@170);
    }];
    
}


@end
