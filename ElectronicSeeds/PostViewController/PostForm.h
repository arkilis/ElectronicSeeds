//
//  RegistrationForm.h
//  BasicExample
//
//  Created by Nick Lockwood on 04/03/2014.
//  Copyright (c) 2014 Charcoal Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXForms.h"
#import "CustomSubmitButtonCell.h"
#import "GoogleMaps/GoogleMaps.h"



@interface PostForm : NSObject <FXForm>

// Part 0
@property (nonatomic, copy)     NSString        *seedName;
@property (nonatomic, copy)     NSString        *range;
@property (nonatomic, copy)     NSString        *category;

// Part 1
@property (nonatomic, copy)     NSDate          *startDateTime;
@property (nonatomic, copy)     NSString        *duration;

// Part 2
@property (nonatomic, strong)   id              chooseFile;
@property (nonatomic, strong)   UIImage         *photo;

// Part 3
@property (nonatomic, strong)   NSString        *location;

// Part 4
@property (nonatomic, strong)   id              term;
@property (nonatomic, assign)   BOOL            agreedToTerms;
@property (nonatomic, strong)   id              btnSubmit;

@end
