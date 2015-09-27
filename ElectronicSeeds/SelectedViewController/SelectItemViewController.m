//
//  SelectItemViewController.m
//
//  Created by Ben Liu on 22/01/2015.
//  Copyright (c) 2015 Ben Liu. All rights reserved.
//

#import "SelectItemViewController.h"
#import "Common.h"

@interface SelectItemViewController ()

@end

@implementation SelectItemViewController{
    NSString *global_dropbox_url;
}


@synthesize selectedSeed;
@synthesize mapView;
@synthesize imageLogo;


//- (void)viewDidLoad {
-(void) viewDidAppear:(BOOL)animated{
    
    //[super viewDidLoad];
    
    [super viewDidAppear:animated];
    // Do any additional setup after loading the view.
    
    [_labelStationName setText:selectedSeed.seedName];                  // Set seed name
    [_labelPostDateTime setText:selectedSeed.postDateTime];             // Set post date and time
    [_labelExpireDateTime setText:selectedSeed.expireDateTime];         // Set expire date and time
    [_labelDistance setText: [NSString stringWithFormat:@"%.2f Meters", // Set expire date and time
                              [selectedSeed.range floatValue]]];

    
    // add google map and its marker
    self.mapView.camera = [GMSCameraPosition cameraWithLatitude: [selectedSeed.latitude doubleValue]
                                                      longitude: [selectedSeed.longitude doubleValue]
                                                           zoom: iGoogleMapZoomIn];
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake([selectedSeed.latitude doubleValue],
                                                 [selectedSeed.longitude doubleValue]);
    marker.title = selectedSeed.seedName;
    //marker.snippet = @"Australia";
    marker.map = self.mapView;
    
    
    // load image or url
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *szURLDropbox= selectedSeed.fileURLDropbox;
        NSString *szURLUpload=  [NSString stringWithFormat:@"%@%@", szURLMain, selectedSeed.fileURLUpload];
        
        szURLDropbox= [szURLDropbox stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
        NSString *szURLTemp= [selectedSeed.fileURLUpload stringByReplacingOccurrencesOfString:@"upload/" withString:@""];
        
        NSLog(@"szURLDropbox: %@", szURLDropbox);
        NSLog(@"szURLUpload: %@", szURLTemp);
        
        // upload is not null AND dropbox is null
        if(![szURLTemp isEqualToString:@""]&&
           [szURLDropbox isEqualToString:@""]){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImageView *imageUpload = [[UIImageView alloc] initWithFrame:CGRectMake(0, 725, 320, 158)];
                NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: szURLUpload]];
                UIImage *image = [UIImage imageWithData:imageData];
                imageUpload.image = image;
                imageUpload.contentMode= UIViewContentModeScaleAspectFill;
                [self.scrollView addSubview:imageUpload];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            });
        }
        
        // upload is null AND dropbox is not null
        if([szURLTemp isEqualToString:@""] && ![szURLDropbox isEqualToString:@""]){
            // load dropbox url
            global_dropbox_url= [NSString stringWithFormat:@"%@",szURLDropbox];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            button.backgroundColor= [Common colorFromHexString:@"#0581E4"];
            button.layer.cornerRadius = 5;
            button.clipsToBounds = YES;
            [button addTarget:self
                       action:@selector(aMethod)
             forControlEvents:UIControlEventTouchUpInside];
            [button setTitle:@"Dropbox Link" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
            button.frame = CGRectMake(15, 725, 290, 44);
            [self.scrollView addSubview:button];
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
        
        //// upload is not null AND dropbox is not null
        if(![szURLTemp isEqualToString:@""] && ![szURLDropbox isEqualToString:@""]){
            //[self.scrollView addSubview:button];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // load upload image first
                UIImageView *imageUpload_upload = [[UIImageView alloc] initWithFrame:CGRectMake(0, 725, 320, 158)];
                NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: szURLUpload]];
                UIImage *image = [UIImage imageWithData:imageData];
                imageUpload_upload.image = image;
                imageUpload_upload.contentMode= UIViewContentModeScaleAspectFill;
                //[self.scrollView addSubview:imageUpload_upload];
                
                // load dropbox url
                global_dropbox_url= [NSString stringWithFormat:@"%@",szURLDropbox];
                UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                button.backgroundColor= [Common colorFromHexString:@"#0581E4"];
                button.layer.cornerRadius = 5;
                button.clipsToBounds = YES;
                [button addTarget:self
                           action:@selector(aMethod)
                 forControlEvents:UIControlEventTouchUpInside];
                [button setTitle:@"Dropbox Link" forState:UIControlStateNormal];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
                button.frame = CGRectMake(15, 940, 290, 44);
                
                [self.scrollView addSubview:imageUpload_upload];
                [self.scrollView addSubview:button];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            });
        }
        
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)aMethod {
    if(![global_dropbox_url isEqualToString:@""]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: global_dropbox_url]];
    }
}



@end






























