//
//  RegistrationForm.m
//  BasicExample
//
//  Created by Nick Lockwood on 04/03/2014.
//  Copyright (c) 2014 Charcoal Design. All rights reserved.
//

#import "PostForm.h"


@implementation PostForm {
    
}



// Part 0
// -- Site name
- (NSDictionary *)seedNameField {
    return @{
             FXFormFieldHeader:         @"Fill with necessary informtion",
             FXFormFieldKey:            @"seedName",
             @"textField.autocapitalizationType": @(UITextAutocapitalizationTypeWords),
             FXFormFieldTitle:          @"Seed Name",
             FXFormFieldPlaceholder:    @"Seed Name"
             };
}
// -- Range
- (NSDictionary *)rangeField {
    return @{
             FXFormFieldKey:            @"range",
             FXFormFieldOptions:        @[@"100m", @"200m", @"300m", @"400m", @"500m", @"1000m", @"2000m"],
             FXFormFieldTitle:          @"Range",
             FXFormFieldDefaultValue:   @"1000m"
             };
}

// -- category
// This part should be done by 1) obtain via network 2) store it in the userdefaultData
- (NSDictionary *)categoryField {
    return @{
             FXFormFieldKey:            @"category",
             FXFormFieldOptions:        @[@"Freebie", @"Discount", @"Drink", @"Entertainment", @"Travel", @"Sports", @"Accommondation", @"Attraction", @"Meal", @"Movie"],
             FXFormFieldTitle:          @"Category",
             FXFormFieldDefaultValue:   @"Freebie"
             };
}

// Part 1
// -- Choose From Dropbox
- (NSDictionary *)startDateTimeField {
    return @{
             FXFormFieldKey:             @"startDateTime",
             FXFormFieldHeader:          @"Date and Time",
             FXFormFieldTitle:           @"Start from",
             FXFormFieldPlaceholder:     @"Seed activate from",
             FXFormFieldType:            FXFormFieldTypeDateTime
             };
}
// -- Duration
- (NSDictionary *)durationField {
    return @{
             FXFormFieldKey:             @"duration",
             FXFormFieldOptions:         @[@"15 Mins", @"30 Mins", @"1 Hour",  @"2 Hours",  @"3 Hours",
                                           @"4 Hours", @"5 Hours", @"10 Hours", @"1 Day", @"2 Days", @"Unlimited"],
             FXFormFieldTitle:           @"Duration",
             FXFormFieldDefaultValue:    @"1 Hour"
             };
}

// Part 2
// -- Choose From Dropbox
- (NSDictionary *)chooseFileField {
    return @{
             FXFormFieldHeader:          @"Upload",
             FXFormFieldTitle:           @"Dropbox File",
             FXFormFieldViewController:  @"ChooseFileFromDropboxViewController",
             FXFormFieldPlaceholder:     @"Choose a file from Dropbox"
             };
}
- (NSString *)chooseFileFieldDescription{
    return self.chooseFile[0];
}

// -- Photo
- (NSDictionary *)photoField {
    return @{
                FXFormFieldKey:          @"photo",
                FXFormFieldTitle:        @"Take a Photo"
            };
}

// Part 3
// -- Location
- (NSDictionary *)locationField{
    return @{
                FXFormFieldViewController:  @"SendLocationViewController",
                FXFormFieldTitle:           @"Location",
                FXFormFieldHeader:          @"Location",
                FXFormFieldPlaceholder:     @"Your current location"
            };
}

- (NSString *)locationFieldDescription{
    return self.location;
}


// Part 4
// -- Terms
- (NSDictionary *)termField {
    return @{
                FXFormFieldHeader:   @"Legal",
                FXFormFieldTitle:    @"Terms And Conditions",
                FXFormFieldSegue:    @"TermsSegue"
            };
}

// -- Agree to terms
- (NSDictionary *)agreedToTermsField {
    return @{
                FXFormFieldKey:      @"agreedToTerms",
                FXFormFieldTitle:    @"I Agree To These Terms",
                FXFormFieldType:     FXFormFieldTypeOption
                };
}


// Part 5
- (NSDictionary *)btnSubmitField {
    return @{
                FXFormFieldCell:     [CustomSubmitButtonCell class],
                FXFormFieldTitle:    @"I Agree To These Terms",
                FXFormFieldHeader:   @"",
                FXFormFieldAction:   @"submitRegistrationForm:",
                };
}

@end




















