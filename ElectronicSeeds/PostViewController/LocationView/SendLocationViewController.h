//
//  SendLocationViewController.h
//  Gremlins
//
//  Created by Ben Liu on 3/04/2015.
//  Copyright (c) 2015 Ben Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoogleMaps/GoogleMaps.h"
#import "Common.h"
#import "PostFormViewController.h"
#import "FXForms.h"
#import <QuartzCore/QuartzCore.h>

@interface SendLocationViewController : UIViewController <FXFormFieldViewController, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet  GMSMapView      *mapView;

@property (weak)                        NSString        *addr;
@property (nonatomic, strong)           FXFormField     *field;
@property (strong, nonatomic) IBOutlet  UITextView      *textAddress;
@end
