//
//  SelectItemViewController.h
//  Tuxingsun
//
//  Created by Ben Liu on 22/01/2015.
//  Copyright (c) 2015 Ben Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "SeedModel.h"
#import "GoogleMaps/GoogleMaps.h"
#import "SVProgressHUD/SVProgressHUD.h"



@interface SelectItemViewController : UIViewController

@property (weak, nonatomic) SeedModel *selectedSeed;


// Testing variable transit between views
@property (strong, nonatomic) NSString *stationName;

// Show on the screen
@property (strong, nonatomic) IBOutlet UILabel *labelURL;

@property (strong, nonatomic) IBOutlet GMSMapView   *mapView;
@property (strong, nonatomic) IBOutlet UILabel      *labelStationName;
@property (strong, nonatomic) IBOutlet UILabel      *labelPostDateTime;
@property (strong, nonatomic) IBOutlet UILabel      *labelExpireDateTime;
@property (strong, nonatomic) IBOutlet UILabel      *labelDistance;
@property (strong, nonatomic) IBOutlet UIImageView  *imageLogo;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView       *viewDesc;

@end