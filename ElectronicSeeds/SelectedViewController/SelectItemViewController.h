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
#import "Masonry.h"
#import "GoogleMaps/GoogleMaps.h"
#import "SVProgressHUD/SVProgressHUD.h"
#import "MMPlaceHolder.h"
#import "Common.h"
#import "SDWebImage/UIImageView+WebCache.h"




@interface SelectItemViewController : UIViewController

@property (strong ,nonatomic) SeedModel *selectedSeed;
@property (strong, nonatomic) NSString *stationName;
@property (strong, nonatomic) IBOutlet UILabel *labelURL;


-(void)dropboxMethod;
-(void)applyMethod;

@end