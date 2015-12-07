//
//  SendLocationViewController.m
//  Gremlins
//
//  Created by Ben Liu on 3/04/2015.
//  Copyright (c) 2015 Ben Liu. All rights reserved.
//

#import "SendLocationViewController.h"


@implementation SendLocationViewController

@synthesize mapView;
@synthesize textAddress;
@synthesize addr;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Show loading image
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD show];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 1. Get the current location
        Common *common = [[Common alloc] init];
        NSArray *aryLocation = [[common deviceLocation] componentsSeparatedByString:@","];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            // 1.1 Current Latitude an Longitude
            double lat= [aryLocation[0] doubleValue];
            double lng= [aryLocation[1] doubleValue];
            
            GMSMarker *marker = [[GMSMarker alloc] init];
            marker.position = CLLocationCoordinate2DMake(lat, lng);
            
            // 1.2 Get current address
            addr= [self getAddressFromLatLng:[aryLocation[0] doubleValue] and:[aryLocation[1] doubleValue]];
            marker.title= addr;
            marker.snippet = @"Your specified location";
            marker.map = self.mapView;
            
            // 2. Add google map and its marker
            self.mapView.camera = [GMSCameraPosition cameraWithLatitude: lat
                                                              longitude: lng
                                                                   zoom: iGoogleMapZoomIn];
            
            // 2.1 send address to textbox value
            textAddress.text= addr;
            textAddress.delegate            = self;
            textAddress.layer.borderColor   = [UIColor grayColor].CGColor;
            textAddress.layer.borderWidth   = 1.0;
            textAddress.layer.cornerRadius  = 5.0;
            
            // field value
            self.field.value= addr;
        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Get the latitude and longitude by given address
- (NSString*) getAddressFromLatLng: (double)lat and:(double)lng {
    NSString *address;
    NSString *req = [NSString stringWithFormat:@"%@%f,%f",szURLGoogleMapGetAddress, lat, lng];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        
        //if ([scanner scanUpToString:@"\"formatted_address\" :" intoString:nil]) {
        if([scanner scanUpToString:@"\"formatted_address\" : \"" intoString:nil]
           && [scanner scanString:@"\"formatted_address\" : \"" intoString:nil]){
            [scanner scanUpToString: @"\"," intoString: &address];
            [scanner scanString: @"\"," intoString: NULL];
        }
    }
    return address;
}


- (IBAction)btnPutAddressOnMap:(id)sender {
    if([textAddress.text isEqualToString:@""]){
        [Common alertStatus:@"Please input a valid address" withTitle:@"Invaid address": 0];
    }else{
        // Update the map
        [self updateWithNewLocation];
        // set the global variable
        addr= textAddress.text;
    }
}

// update with new location
-(void) updateWithNewLocation {
    // Clear the old marker
    [self.mapView clear];
    
    // Move to the new location
    CLLocationCoordinate2D loc= [self geoCodeUsingAddress:textAddress.text];
    self.mapView.camera = [GMSCameraPosition cameraWithLatitude: loc.latitude
                                                      longitude: loc.longitude
                                                           zoom: 14];
    // Add new marker
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(loc.latitude,
                                                 loc.longitude);
    marker.snippet = textAddress.text;
    marker.map = self.mapView;
    
    self.field.value= textAddress.text;
    
    // dismiss keyboard
    [textAddress resignFirstResponder];
    
}


// get the latitude and longitude by given address
- (CLLocationCoordinate2D) geoCodeUsingAddress:(NSString *)address
{
    double latitude = 0, longitude = 0;
    NSString *esc_addr =  [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"%@%@", szURLGoogleMapGetLatlng, esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanDouble:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanDouble:&longitude];
            }
        }
    }
    CLLocationCoordinate2D center;
    center.latitude = latitude;
    center.longitude = longitude;
    return center;
}


// dismiss the keyboard
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [textAddress resignFirstResponder];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    if (textField) {
        [self updateWithNewLocation];
        [textAddress resignFirstResponder];
    }
    return NO;
}

@end


















