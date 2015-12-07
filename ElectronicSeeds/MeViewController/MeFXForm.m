//
//  MeFXForm.m
//  Gremlins
//
//  Created by Ben Liu on 26/07/2015.
//  Copyright (c) 2015 Ben Liu. All rights reserved.
//

#import "MeFXForm.h"

@implementation MeFXForm {
    
    // Simulated Constants, but they are actually instance level variable
    NSArray     *ARY_CATELOG;
    
    // Instance Variables
    NSString    *szEmail;
    NSString    *szNotification;
    NSArray     *aryCategory;

}


- (id)initWithVariables{
    self = [super init];
    if (self) {
        // Initialize
        ARY_CATELOG= @[@"Drink", @"Entertainment", @"Travel", @"Sports", @"Accommondation", @"Atraction", @"Meal", @"Movie"];
    }
    return self;
}

- (id)init {
    // Forward to the "designated" initialization method
    return [self initWithVariables];
}



// Account name
- (NSDictionary *)accountField {

    // retrieve User's local data
    UserInfo *userInfo= [Common deSerializeUserInfo];
    if (userInfo!=nil) {
        szEmail = userInfo.userEmail;
    }else{
        szEmail = @"Not Logged In";         // This information shouldn't be here.
    }
    
    
    return @{
             FXFormFieldHeader:         @"Account Info",
             FXFormFieldKey:            @"siteName",
             FXFormFieldTitle:          @"Account Info",
             FXFormFieldPlaceholder:    szEmail,
             @"textField.enabled":      @(NO)               // set readonly
             };
}


// Notification info
- (NSDictionary *)settingField {
    
    // retrieve User's local data
    UserInfo *userInfo= [Common deSerializeUserInfo];
    if (userInfo!=nil) {
        szNotification  = userInfo.notificationOption;
    }else{
        szNotification  = @"ON";
    }
    
    return @{

             FXFormFieldKey:            @"setting",
             FXFormFieldHeader:         @"Setting",
             FXFormFieldOptions:        @[@"On", @"Off"],
             FXFormFieldTitle:          @"Notification Setting",
             FXFormFieldDefaultValue:   szNotification
             };
}


// Category info
- (NSDictionary *)categoryField {
    
    // retrieve User's local data
    UserInfo *userInfo= [Common deSerializeUserInfo];
    if (userInfo!=nil) {
        aryCategory  =  [NSArray arrayWithArray:userInfo.categoryOption];
    }else{
        aryCategory  =  [[NSArray alloc] init];
    }
    
    
    return @{

             FXFormFieldKey:            @"category",
             FXFormFieldOptions:        ARY_CATELOG,
             FXFormFieldTitle:          @"Notfication only for category",
             FXFormFieldDefaultValue:   aryCategory
             };
}



// Facebook
- (NSDictionary *)facebookField {
    return @{
             FXFormFieldHeader:   @"Social",
             FXFormFieldTitle:    @"Like us on Facebook",
             FXFormFieldSegue:    @"facebookSegue"
             };
}


// Twitter
- (NSDictionary *)twitterField {
    return @{
             FXFormFieldTitle:    @"Follow us on Twitter",
             FXFormFieldSegue:    @"twitterSegue"
             };
}


// About
- (NSDictionary *)aboutField {
    return @{
             FXFormFieldHeader:   @"About",
             FXFormFieldTitle:    @"Electronic Seeds",
             FXFormFieldSegue:    @"aboutSegue"
             };
}

// Logout
- (NSDictionary *)btnLogoutField {
    return @{
             FXFormFieldCell:     [CustomLogoutBtnCell class],
             FXFormFieldTitle:    @" ",
             FXFormFieldHeader:   @"Logout",
             FXFormFieldAction:   @"logout:",
             };
}


@end

































